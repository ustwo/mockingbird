BREW := $(shell which brew)
BUNDLER := $(shell which bundler)
DOCKER := $(shell which docker)
RUBY := $(shell which ruby)
SWIFT := $(shell which swift)
SWIFTLINT := $(shell which swiftlint)
XCODEBUILD := $(shell which xcodebuild)

repo_name := mockingbird
package_name := Mockingbird


# - Build & Set Up

# Builds the project using the Swift package manager
build:
	$(SWIFT) build
.PHONY: build

# Generates an Xcode project for the package
xcodeproj:
	$(SWIFT) package generate-xcodeproj --enable-code-coverage
	$(RUBY) ./Utility/xcodeproj_after_install.rb
.PHONY: xcodeproj

# Sets up the workspace (typically used after a fresh clone)
# - Installs dependencies, builds the project, and generates an Xcode project.
setup: dependencies
	$(MAKE) build
	$(MAKE) xcodeproj
.PHONY: setup

# - Docker

# Builds a docker image with the server
build-docker:
	$(DOCKER) build -t $(repo_name) .
	$(DOCKER) run -it -d -P $(repo_name)
.PHONY: build-docker

# Starts the server (command should be executed from within the Docker container)
run-docker:
	./.build/debug/MockServer
.PHONY: run-docker

# - Lint

# Lints the source files and generates HTML reports
lint:
	mkdir -p Reports
	$(SWIFTLINT) lint --reporter html > ./Reports/lint_results_swift.html
	bundle exec rubocop utility/ --format html -o ./Reports/lint_results_ruby.html
.PHONY: lint

# Lints the source files and outputs the results to the CLI
lint-cli:
	$(SWIFTLINT) lint
	bundle exec rubocop utility/
.PHONY: lint-cli

# - Test

# Runs the test suite using the Swift Package Manager
test:
	$(SWIFT) test
.PHONY: test

# Runs the test suite from within Xcode
test-xcode:
	$(XCODEBUILD) test -project $(package_name).xcodeproj -scheme $(package_name) | xcpretty
.PHONY: test-xcode

# - Dependencies

# Installs the dependencies
dependencies:
ifndef RUBY
	$(error "Couldn't find Ruby installed.")
endif
	@$(MAKE) install-bundler install-homebrew install-swiftlint

# Installs homebrew (or runs update if already installed)
install-homebrew:
ifndef BREW
	$(RUBY) -e "$($(CURL) -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	$(BREW) update
endif

# Installs bundler (or installs the gems if already installed)
install-bundler:
ifndef BUNDLER
	gem install bundler
	bundler install
else
	$(BUNDLER) install
endif

# Installs SwiftLint (or updates if already installed)
install-swiftlint:
ifndef SWIFTLINT
	$(BREW) install swiftlint
else
	$(BREW) outdated swiftlint || $(BREW) upgrade swiftlint
endif
