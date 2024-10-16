# Use a specific Python version as a parent image
FROM python:3.10-alpine

# Set the working directory to /application
WORKDIR /application

# Copy only the poetry files to leverage Docker cache
COPY pyproject.toml poetry.lock /application/

# Install poetry and dependencies
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev

# Upgrade pip and setuptools to resolve vulnerabilities
RUN pip install --no-cache-dir --upgrade pip setuptools

# Copy the current directory contents into the container at /application
COPY . /application

# Set environment variables
#COPY .env .env
#ENV PYTHONPATH="/application"

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Command to run FastAPI app using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
