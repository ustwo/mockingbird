#!/bin/bash

set -euo pipefail

docker build -t mockingbird ../.
docker run -it -d -P mockingbird
