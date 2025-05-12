# Verwende ein offizielles Python-Image als Basis
FROM python:3.12-slim

# Setze das Arbeitsverzeichnis auf /app
WORKDIR /app

# Kopiere die pyproject.toml und uv.lock in das Container-Verzeichnis
COPY pyproject.toml uv.lock /app/

# Installiere die Pakete, die in der pyproject.toml definiert sind
RUN pip install --upgrade pip \
    && pip install . --use-pep517

# Kopiere das gesamte Projekt (einschließlich data_preprocessing.py und das data-Verzeichnis)
COPY . /app/

# Mache den Port 8501 für die Außenwelt verfügbar
EXPOSE 8501

# Starte die Streamlit-Anwendung beim Start des Containers
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
