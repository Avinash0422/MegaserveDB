# Use Python 3.11 slim for a lightweight base image
FROM python:3.11-slim

# Set environment variables to prevent Python from writing .pyc files and buffering output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies for MySQL and pandas
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose port 8000
EXPOSE 8000

# Run the application with Waitress
CMD ["python", "run_app.py"]