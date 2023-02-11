FROM ubuntu
RUN Yum update -y 
USER 1
RUN mkdir app
WORKDIR app 
RUN apt install -y ansible curl vim wget
CMD ["bash"]
<html>
</html>
