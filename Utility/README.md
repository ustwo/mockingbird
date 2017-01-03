# Utility Scripts

Below are brief descriptions of each of the scripts in the `Utility` folder.

## Details

### brew_update.sh

This installs/updates all Homebrew dependencies.

### build.sh

This builds the Swift project using the [Swift Package Manager][swift-pm].

### generate_xcodeproj.sh

This generates an Xcode project file (`xcodeproj`) for the Swift project using the [Swift Package Manager][swift-pm].

### lint.sh

This lints all Ruby, Shell, and Swift files in the repository using [Rubocop][rubocop], [Shellcheck][shellcheck], and [Swiftlint][swiftlint] respectively. By default, the results are outputed into a `Reports` folder in the top level directory. To print the output to the terminal instead, use `bash lint.sh cli`.

### setup_docker_server.sh

This generates a Docker container and starts it with the Swift project. Note that this **does not** start the server itself, only the Docker container. To start the server, run the `start_server.sh` script from within the container.

### start_server.sh

This starts the mock server. This script should be run from within the Docker container.

### swiftlint_xcode.sh

This script runs Swiftlint and should be called from within a Build Script Phase inside the Xcode project. If you generated the Xcode project using the `generate_xcodeproj.sh` script than this will have already been configured.

### test.sh

This script tests the Swift project using the [Swift Package Manager][swift-pm].

### test_xcode.sh

This script tests the project using `xcodebuild`. Note that you should run `generate_xcodeproj.sh` to create the Xcode project before running this script.

### xcodeproj_after_install.rb

This script modifies the generated Xcode project to add linting, tweak the build settings, and add resources.

<!-- Links -->

[rubocop]: https://github.com/bbatsov/rubocop
[shellcheck]: https://github.com/koalaman/shellcheck
[swiftlint]: https://github.com/realm/SwiftLint
[swift-pm]: https://github.com/apple/swift-package-manager
