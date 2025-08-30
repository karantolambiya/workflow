FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "app:app"]


# Placeholder for the required files:
#
# requirements.txt:
# flask
# gunicorn
#
# app.py:
# from flask import Flask
#
# app = Flask(__name__)
#
# @app.route('/')
# def hello_world():
#     return 'Hello, World!'
