#!/bin/bash

cd ../ || exit
set -o pipefail && xcodebuild test -project Mockingbird.xcodeproj -scheme Mockingbird | xcpretty
