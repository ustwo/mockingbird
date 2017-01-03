#!/bin/bash

brew update
brew outdated swiftlint || brew upgrade swiftlint
brew outdated shellcheck || brew upgrade shellcheck
