FROM ubuntu
RUN yum update -y 
USER 0 
RUN mkdir app
WORKDIR app 
RUN apt install -y ansible curl vim wget
CMD ["bash"]
