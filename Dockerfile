FROM ubuntu
RUN apt update -y
USER 0
Run mkdir app
WORKDIR app
RUN apt install -y ansible curl vim wget
CMD ["bash"]
