#!/bin/bash

# Reference: https://medium.com/@faizififita1/how-to-deploy-your-streamlit-web-app-to-google-cloud-run-ba776487c5fe
image_name="streamlit-app"
docker build -t ${image_name} .