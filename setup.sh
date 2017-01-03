#!/bin/bash

echo "Ruby version:"
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
cd Utility || exit
bash brew_update.sh

echo 'Building Project...'
bash build.sh

echo 'Setting Up Xcode Project...'
bash generate_xcodeproj.sh

echo 'Set Up Complete!'
