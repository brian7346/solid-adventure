#!/bin/bash
set -e

if [ "$ENV" = 'UNIT' ]; then
    echo "Running Unit Tests"
    echo "Current directory: $(pwd)"
    echo "Contents of current directory:"
    ls -la
    echo "Contents of /app:"
    ls -la /app
    cd /app  # Переходим в директорию с тестами
    exec python "tests.py"
elif [ "$ENV" = 'DEV' ]; then
    echo "Running Development Server"
    exec python "identidock.py"
else
    echo "Running Production Server"
    exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
         --callable app --stats 0.0.0.0:9191
fi