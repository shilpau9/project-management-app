# syntax=docker/dockerfile:1.4

FROM python:3.10-slim
EXPOSE 8000
WORKDIR /app 
# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    bash \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app
RUN pip3 install -r requirements.txt --no-cache-dir
COPY . .

# Move into Django project folder
WORKDIR /app/ves

# Give permission to script
RUN chmod +x ../db-script.sh

# Run DB script + start server
CMD bash -c "../db-script.sh && gunicorn ves.wsgi:application --bind 0.0.0.0:8000"