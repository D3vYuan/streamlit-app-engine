#!/bin/bash

image_name="streamlit-app"
source_port=8051
destination_port=8501

echo "docker run -itd --rm -p ${source_port}:${destination_port} ${image_name}"
docker run -itd --rm -p ${source_port}:${destination_port} ${image_name}