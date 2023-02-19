FROM devopseasylearning2021/challenger:ruby-latest-1
MAINTAINER EK TECH SOFTWARE SOLUTION
WORKDIR /app
COPY yelb-appserver.rb yelb-appserver.rb 
COPY Gemfile Gemfile
COPY modules modules
ENV LANG=en_us.UTF-8
ENV LC_ALL=C.UTF-8
ENV RACK_ENV=production
RUN gem install sinatra 
RUN gem install redis 
RUN apt-get update
RUN apt-get install libpq-dev -y
RUN gem install pg -v 1.1.4 
RUN gem install aws-sdk-dynamodb pg:1.1.4 
WORKDIR /
ADD startup.sh startup.sh
CMD ["./startup.sh"]
