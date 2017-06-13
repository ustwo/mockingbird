#!/bin/bash

set -euo pipefail

(
  cd ../
  swift package generate-xcodeproj \
    --enable-code-coverage
)

ruby xcodeproj_after_install.rb
