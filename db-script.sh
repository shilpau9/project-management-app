#!/bin/bash

echo "Waiting for DB..."
sleep 10

python manage.py migrate
python manage.py collectstatic --noinput
