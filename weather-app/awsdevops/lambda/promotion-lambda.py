import json
import sys

import boto3
import botocore
import os


def pipeline_exists(pipeline):
    client = boto3.client('codepipeline')
    try:
        client.get_pipeline(name=pipeline)
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "PipelineNotFoundException":
            print("Pipeline does not exist")
            return False
        else:
            return True


def lambda_handler(event, context):
    tag = event['detail']['referenceName']
    pipeline = tag + "-promotion"
    client = boto3.client('codepipeline')
    # If the pipeline exists, exit
    if pipeline_exists(pipeline):
        print("Pipeline already there. Exiting without errors")
        sys.exit(0)
    if event['detail']['event'] == "referenceCreated" and event['detail']['referenceType'] == "tag":
        client.create_pipeline(
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
                                'namespace': 'SourceVariables',
                                'configuration': {
                                    'RepositoryName': event['detail']['repositoryName'],
                                    'BranchName': "main",
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
                                    'ProjectName': os.getenv("CODEBUILD_PROMOTION_PROJECT"),
                                    "EnvironmentVariables": json.dumps([
                                        {
                                            "name": "CI_COMMIT_TAG",
                                            "value": tag,
                                            "type": "PLAINTEXT"
                                        },
                                        {
                                            "name": "REPO_NAME",
                                            "value": os.getenv("REPO_NAME"),
                                            "type": "PLAINTEXT"
                                        },
                                        {
                                            "name": "REPO_URL",
                                            "value": os.getenv("REPO_URL"),
                                            "type": "PLAINTEXT"
                                        }
                                    ])
                                },
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
