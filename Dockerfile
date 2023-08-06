FROM python:3.9-slim

 # Set the working directory inside the container
 WORKDIR /app

 # Copy the current directory contents into the container at /app
 COPY . /app

 # Install the required dependencies
 RUN pip install --no-cache-dir Flask

 # Expose port 5000 (the default Flask port)
 EXPOSE 5000
