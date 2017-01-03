#!/bin/bash

set -euo pipefail

echo 'Ruby version:'
ruby -v

echo 'Installing Ruby Dependencies...'
if ! which -s bundle
then
    # https://bundler.io/
    echo 'Installing Bundler...'
    gem install bundler
fi
bundle install

echo 'Installing Homebrew Dependencies...'
if ! which -s brew
then
    # http://brew.sh/
    echo 'Installing Homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if cd Utility
then
    bash brew_update.sh
else
    echo 'Error: Unable to find `Utility` folder. Exiting.' 1>&2
    exit 1
fi

echo 'Building Project...'
bash build.sh

echo 'Setting Up Xcode Project...'
bash generate_xcodeproj.sh

echo 'Set Up Complete!'
