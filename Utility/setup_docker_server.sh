#!/bin/bash

docker build -t mockingbird ../.
docker run -it -d -P mockingbird
