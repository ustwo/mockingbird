#!/bin/bash

set -euo pipefail

brew update

if brew ls --versions swiftlint > /dev/null; then
  brew outdated swiftlint || brew upgrade swiftlint
else
  brew install swiftlint
fi

if brew ls --versions shellcheck > /dev/null; then
  brew outdated shellcheck || brew upgrade shellcheck
else
  brew install shellcheck
fi

brew list
