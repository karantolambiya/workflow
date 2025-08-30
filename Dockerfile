FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--workers=3", "--bind=0.0.0.0:8000", "app:app"]

# Create a dummy requirements.txt if one doesn't exist
RUN if [ ! -f requirements.txt ]; then touch requirements.txt && echo "flask==2.2.2" >> requirements.txt && echo "gunicorn==20.1.0" >> requirements.txt; fi

# Create a dummy app.py if one doesn't exist
RUN if [ ! -f app.py ]; then touch app.py && echo "from flask import Flask" >> app.py && echo "app = Flask(__name__)" >> app.py && echo "@app.route('/')" >> app.py && echo "def hello_world():" >> app.py && echo "    return 'Hello, World!'" >> app.py; fi
