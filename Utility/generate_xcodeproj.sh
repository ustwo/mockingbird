#!/bin/bash

swift package generate-xcodeproj \
  --chdir ../ \
  --enable-code-coverage

ruby xcodeproj_after_install.rb
