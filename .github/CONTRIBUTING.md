# Contributing

First, thanks for taking the time to submit a pull request! These are the few notes and guidelines to keep things coherent.

## Overview

1. Read and abide by the [Code of Conduct][code-of-conduct].
1. [Fork the project](https://github.com/ustwo/mockingbird/fork) and clone.
1. Check you have all [requirements](#requirements) in place.
1. Create your [_feature_ branch](#feature-branch).
1. [Install](#install) the project dependencies for development.
1. [Test](#test).
1. If you have more than trivial changes (e.g. fixing typo's), then you must include a description in the [CHANGELOG.md][changelog].
1. Push your branch and submit a [Pull Request](https://github.com/ustwo/mockingbird/compare/).

We will review the changes as soon as possible.

## Requirements

- [Swift][swift] (It is included with Xcode)
- [Bundler][bundler]
- [SwiftLint][swiftlint]

## Feature Branch

Please use a descriptive and concise name for your feature branch. Below is a snippet to show how to create a branch with git.

```sh
git checkout -b feature/feature-name
```

## Install

After installing [Swift][swift] (or Xcode), [Bundler][bundler], and [SwiftLint][swiftlint] run the following terminal command from the project folder to install the remaining gems to be able to run all the tests and scripts as you would on the CI:

```sh
bundle install
```

## Test

You can quickly run the test suite. From the `Utility` directory, use the following terminal command:

```sh
bash test_server.sh
```

<!--- Links --->

[bundler]: http://bundler.io/
[changelog]: ../CHANGELOG.md
[code-of-conduct]: ../CODE_OF_CONDUCT.md
[swift]: https://github.com/apple/swift
[swiftlint]: https://github.com/realm/SwiftLint
