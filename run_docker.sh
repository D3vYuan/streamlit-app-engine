#!/bin/bash

image_name="streamlit-app"
source_port=8080
#destination_port=8501
destination_port=8080

echo "docker run -itd --rm -p ${source_port}:${destination_port} ${image_name}"
docker run -itd --rm -p ${source_port}:${destination_port} ${image_name}