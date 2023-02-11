FROM ubuntu
RUN apt update -y 
USER 0 
RUN mkdir app
WORKDIR app 
RUN ap install -y ansible curl vim wget
CMD ["bash"]
