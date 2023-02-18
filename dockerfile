FROM alpine:3.12
RUN apk add --no-cache mysql-client \
    && apk update && apk add vim \
    &&  apk add curl && apk add wget \
    && apk add --no-cache bash
WORKDIR julie
RUN adduser s4julie;echo 's4julie:777' | chpasswd
USER s4julie
ENTRYPOINT ["mysql"]
mnmbvnvb
kjhnbjg,kjb.uhkjn
