import sys

import boto3
import botocore
import os


def delete_pipeline(pipeline):
    client = boto3.client('codepipeline')
    try:
        client.get_pipeline(name=pipeline)
        response = client.delete_pipeline(
            name=pipeline
        )
        print(response)
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "PipelineNotFoundException":
            print("Pipeline does not exist")
        else:
            raise e


def lambda_handler(event, context):
    branch = event['detail']['referenceName']
    pipeline = branch + "-ci"
    if branch in ["main"]:
        print("Not working with the " + branch + " branch")
        sys.exit(0)
    client = boto3.client('codepipeline')
    # If the pipeline exists, delete it and recreate it
    delete_pipeline(pipeline)
    if event['detail']['event'] == "referenceCreated":
        response = client.create_pipeline(
            pipeline={
                'name': pipeline,
                'roleArn': os.getenv("CODEPIPELINE_ROLE_ARN"),
                'artifactStore': {
                    'type': 'S3',
                    'location': os.getenv("CODEPIPELINE_S3_BUCKET"),
                },
                'stages': [
                    {
                        'name': 'Pull',
                        'actions': [
                            {
                                'name': 'Pull',
                                'actionTypeId': {
                                    'category': 'Source',
                                    'owner': 'AWS',
                                    'provider': 'CodeCommit',
                                    'version': '1'
                                },
                                'outputArtifacts': [
                                    {
                                        'name': 'source_output'
                                    },
                                ],
                                'configuration': {
                                    'RepositoryName': event['detail']['repositoryName'],
                                    'BranchName': event['detail']['referenceName']
                                }
                            },
                        ]
                    },
                    {
                        'name': 'Build',
                        'actions': [
                            {
                                'name': 'Build',
                                'actionTypeId': {
                                    'category': 'Build',
                                    'owner': 'AWS',
                                    'provider': 'CodeBuild',
                                    'version': '1'
                                },
                                'inputArtifacts': [
                                    {
                                        'name': 'source_output'
                                    },
                                ],
                                'outputArtifacts': [
                                    {
                                        'name': 'build_output'
                                    },
                                ],
                                'configuration': {
                                    'ProjectName': os.getenv("CODEBUILD_CI_PROJECT"),
                                }
                            },
                        ]
                    }
                ]
            }
        )
    # event = {'version': '0', 'id': '6bbfdb52-6dd3-ae11-32c5-f40ae9f369dd',
    #         'detail-type': 'CodeCommit Repository State Change', 'source': 'aws.codecommit', 'account': '790250078024',
    #         'time': '2021-12-30T16:46:56Z', 'region': 'eu-west-1',
    #         'resources': ['arn:aws:codecommit:eu-west-1:790250078024:weatherapp'],
    #         'detail': {'callerUserArn': 'arn:aws:iam::790250078024:user/gitlab',
    #                    'commitId': 'ec3a87304850ca25f8e57945c0262ea5c44001ed', 'event': 'referenceCreated',
    #                    'referenceFullName': 'refs/heads/feature-c', 'referenceName': 'feature-c',
    #                    'referenceType': 'branch', 'repositoryId': 'de04b8fc-2214-4dc3-9d7a-2fa8c2ba748c',
    #                    'repositoryName': 'weatherapp'}}
