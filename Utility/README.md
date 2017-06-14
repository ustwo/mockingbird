# Utility Scripts

Below are brief descriptions of each of the scripts in the `Utility` folder.

## Details

### swiftlint_xcode.sh

This script runs Swiftlint and should be called from within a Build Script Phase inside the Xcode project. If you generated the Xcode project using the `generate_xcodeproj.sh` script than this will have already been configured.

### xcodeproj_after_install.rb

This script modifies the generated Xcode project to add linting, tweak the build settings, and add resources.
