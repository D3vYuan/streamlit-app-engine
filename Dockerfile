#FROM python:3.11-slim
FROM gcr.io/google-appengine/python

RUN apt-get update -y && apt-get upgrade -y

# Create a virtualenv for dependencies. This isolates these packages from
# system-level packages.
# Use -p python3 or -p python3.7 to select python version. Default is version 2.
RUN virtualenv /env -p python3

# Setting these environment variables are the same as running
# source /env/bin/activate.
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

WORKDIR /app

# RUN apt-get update && apt-get install -y \
#     build-essential \
#     curl \
#     software-properties-common \
#     git \
#     && rm -rf /var/lib/apt/lists/*

# RUN git clone https://github.com/streamlit/streamlit-example.git .
COPY . ./

RUN pip install --upgrade pip
RUN pip install --upgrade -r requirements.txt

EXPOSE 8080
# EXPOSE 8501

# HEALTHCHECK CMD curl --fail http://localhost:8080/_stcore/health

# ENTRYPOINT ["streamlit", "run", "streamlit_101.py", "--server.port=8080", "--server.address=0.0.0.0", "--server.enableCORS=false", "--server.enableWebsocketCompression=false", "server.enableXsrfProtection=false"]
ENTRYPOINT ["streamlit", "run", "streamlit_101.py", "--server.port=8080", "--server.address=0.0.0.0"]
# ENTRYPOINT ["streamlit", "run", "streamlit_101.py", "--server.port=8501", "--server.address=0.0.0.0"]