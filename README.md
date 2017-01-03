# Mockingbird

[![Build Status](https://travis-ci.org/ustwo/mockingbird.svg?branch=master)](https://travis-ci.org/ustwo/mockingbird)
[![Twitter](https://img.shields.io/badge/twitter-@ustwo-blue.svg?style=flat)](http://twitter.com/ustwo)

This project is a demonstration of using the [Swift Package Manager][swiftpm] and writing Swift code to run on both Linux and macOS. It is built by developers at [ustwo][ustwo].

## Usage

### Installing & Running

Ensure you have the latest version of [Xcode][xcode] and [Docker][docker] installed.

Run the setup script to install depedencies and perform an initial local build.

```bash
bash setup.sh
```

To setup a Docker container with the server, run the following command. Alternatively, if you have cloned this repository directly onto a Linux machine, you can [install Swift by following Apple's instructions][swiftlinux].

```bash
cd Utility && bash setup_docker_server.sh
```

To start the server, from within the Docker container (or your Linux server) run the following command:

```bash
cd Utility && bash start_server.sh
```

### Testing & Linting

The `Utility` folder contains bash scripts for testing (`test.sh`) and linting (`lint.sh`). Linting will check Ruby, Shell, and Swift files and output them into a `reports` folder in the main directory.

## Architecture

### Organization

This repository is organised as specified by the [Swift Package Manager][swiftpm]. All source files for the mock server and client are included in the `Sources` folder with the corresponding tests in the `Tests` folder. A variety of useful scripts are in the `Utility` folder. The project's resources are housed within the `Resources` folder.

### Libraries and Executables

Each of the top level folders in `Sources` and `Tests` define a module. Each framework and test module is suffixed with *Kit* and *Tests* respectively. Following Swift Package Manager convention, test modules use the same name as their corresponding module and add the *Tests* suffix. Executables do not contain any suffix. Below is a brief description of each core module:

- **MockServer**: This is the server executable. It runs a basic HTTP server built with the `MockServerKit`.
- **MockServerKit**: This houses the business logic of the server. This is in a separate module from `MockServer` in order to make it testable. See [SR-3033][sr3033].
- **ResourceKit**: This contains helper files for managing resources as the Swift Package Manager does not currently have a good way to include them within a package. See [SR-2866][sr2866].
- **SwaggerKit**: This module parses a Swagger file and has convience methods to build the HTTP server endpoints.
- **TestKit**: This library contains helper files for writting tests.

### Dependencies

The Swift package is dependent on (as shown in [`Package.swift`][package]):

- [**HeliumLogger**][heliumlogger]: This package provides additional logging functionality.
- [**Kitura**][kitura]: This framework provides the core of building an HTTP server.
- [**Swift-cenv**][swiftcenv]: This library provides convenience methods for determining the environment on which the server is running.

### Logging

By default, logging has been set at the verbose level for both the server and the tests. To adjust this, edit the line:

```swift
HeliumLogger.use(LoggerMessageType.verbose)
```

in the `ServerController.swift` for the server and `LoggedTestCase.swift` for the tests.

## Open Swift Tickets & PR's

- [**SR-2866**][sr2866]: The Swift Package Manager currently does not have a way to specify resources (such as assets, test files, etc.) to be included in the package. Mockingbird works around this by adding a `COPY` command in the `Dockerfile` and providing an absolute path to the resources in the code. To provide better support in Xcode, part of the `xcodeproj_after_install.rb` script adds the resources to a Copy Files Build Script Phase for the `ResourceKit` target. Thus `ResourceKit` has three ways for generating the appropriate file url for a given resource - absolute path using Linux (Docker) file layout when building on Linux, absolute path using the macOS file layout when using the Swift compiler on a Mac (i.e. `swift build` and `swift test`), or a resource bundle when using Xcode on a Mac.
- [**SR-3033**][sr3033]: The Swift Package Manager currently cannot test an executable package (i.e. one with a `main.swift` file). Mockingbird works around this by placing as much code as possible within a library (`MockServerKit`) and only a minimal `main.swift` file in the executable (`MockServer`).
- [**GitHub PR #807**][github807]: The Swift Package Manager creates a `.build` folder when building. No distinction is made for the operating system when building. So if the `.build` folder is copied from a macOS build to a Linux server and run, it may or may not compile or test correctly. This GitHub PR seeks to either warn the user or place the build artifacts inside a top-level folder specifying the operating system. Mockingbird works around this by adding the `.build` folder to the `.dockerignore` file and doing a clean build on the Linux server.

## License

Mockingbird is released under the MIT license. See [LICENSE.md][license] for details. Note that while Mock Mockingbird is licensed under the MIT license, not all of its dependencies are. Please check the depedencies listed in the [`Package.swift`][package] file and their respective licesnses.

## Maintainers

* Aaron McTavish ([@aamctustwo][aamctustwo])

## Contact

* [open.source@ustwo.com](mailto:open.source@ustwo.com)

<!-- Links -->

[aamctustwo]: https://github.com/aamctustwo
[docker]: https://www.docker.com/
[github807]: https://github.com/apple/swift-package-manager/pull/807
[heliumlogger]: https://github.com/IBM-Swift/HeliumLogger
[kitura]: https://github.com/IBM-Swift/Kitura
[license]: LICENSE.md
[package]: Package.swift
[sr2866]: https://bugs.swift.org/browse/SR-2866
[sr3033]: https://bugs.swift.org/browse/SR-3033
[swiftcenv]: https://github.com/IBM-Swift/Swift-cfenv
[swiftlinux]: https://swift.org/download/
[swiftpm]: https://github.com/apple/swift-package-manager
[ustwo]: https://ustwo.com/
[xcode]: https://itunes.apple.com/gb/app/xcode/id497799835?mt=12#
