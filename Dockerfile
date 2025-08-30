FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]

# requirements.txt content:
# flask
# gunicorn

# app.py content:
# from flask import Flask
# app = Flask(__name__)

# @app.route("/")
# def hello():
#     return "Hello, World!"
