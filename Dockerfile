FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]


# Create a dummy requirements.txt for completeness if you don't have one
# Create an app.py for a basic Flask app

# requirements.txt content:
# Flask
# gunicorn

# app.py content:
# from flask import Flask

# app = Flask(__name__)

# @app.route('/')
# def hello_world():
#     return 'Hello, World!'
