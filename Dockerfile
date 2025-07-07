FROM python:3.13.5-alpine3.22
# Use an official Python runtime as a parent image
# Using a slim version to keep the image size small.
# The readme.md specifies Python 3.10+, so 3.11-slim is a good choice.
#FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file first to leverage Docker's layer caching.
# The layer with dependencies will only be rebuilt if requirements.txt changes.
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
# --no-cache-dir: Disables the cache, which is useful for keeping image sizes down.
# --upgrade pip: Ensures we are using the latest version of pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copy the rest of the application's code to the working directory.
COPY . .

# Make port 8000 available to the world outside this container, as uvicorn will run on it.
EXPOSE 8000

# Run the application using uvicorn.
# We use 0.0.0.0 as the host to make it accessible from outside the container.
# The --reload flag is removed as it's intended for development, not production.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


