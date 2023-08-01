# Use the official Python image as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the Flask app will listen on
EXPOSE 5000

# Set the environment variable for Flask
ENV FLASK_APP=app.py

# Start the Flask application
CMD ["flask", "run", "--host", "0.0.0.0"]
