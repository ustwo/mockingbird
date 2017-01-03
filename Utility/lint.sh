#!/bin/bash

set -eo pipefail

CLI=false
if [ "$1" = 'cli' ]; then
  CLI=true
fi

cd ../ || exit
if [ "$CLI" = false ]; then
  mkdir -p Reports
fi

echo 'Linting Swift...'
if [ "$CLI" = true ]; then
  swiftlint lint
else
  swiftlint lint --reporter html > ./Reports/lint_results_swift.html
fi

echo 'Linting Ruby...'
if [ "$CLI" = true ]; then
  bundle exec rubocop utility/
else
  bundle exec rubocop utility/ --format html -o ./Reports/lint_results_ruby.html
fi

echo 'Linting Shell...'
if [ "$CLI" = true ]; then
  shellcheck -- **/*.sh
else
  shellcheck -f json -- **/*.sh > ./Reports/lint_results_shell.json
fi

echo 'Linting Complete!'
