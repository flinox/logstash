#!/bin/bash

docker build -t flinox/backbone-logger:latest .

# docker run --rm -it --hostname backbone-logger --name backbone-logger \
# --mount type=bind,source="$(pwd)/config",target=/app/logger/ \
# --security-opt label=disable \
# flinox/backbone-logger:latest 
