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

if [ ! -d Utility ]
then
    echo 'Error: Unable to find `Utility` folder. Exiting.' 1>&2
    exit 1
fi

cd Utility
./brew_update.sh

echo 'Building Project...'
./build.sh

echo 'Setting Up Xcode Project...'
./generate_xcodeproj.sh

echo 'Set Up Complete!'
