# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies specified in requirements.txt
RUN pip install

# Define environment variable(s) if needed
ENV ENV_VAR_NAME=value

# Expose a port if your application listens on a specific port
EXPOSE 8000

# Command to run your application when the container starts
CMD ["python", "app.py"]
