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
COPY . /app 
CMD bash -c "./db-script.sh && python3 manage.py runserver 0.0.0.0:8000"