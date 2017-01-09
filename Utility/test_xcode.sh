#!/bin/bash

set -euo pipefail

cd ../ || exit
xcodebuild test -project Mockingbird.xcodeproj -scheme Mockingbird | xcpretty
