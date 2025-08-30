FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "app:app"]

# Create a dummy requirements.txt if one doesn't exist
RUN touch requirements.txt
# Create a dummy app.py if one doesn't exist.
RUN echo "from flask import Flask\napp = Flask(__name__)\n\n@app.route('/')\ndef hello_world():\n    return 'Hello, World!'" > app.py
