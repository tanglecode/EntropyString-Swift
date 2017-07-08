#!/usr/bin/env bash

set -e -o pipefail

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    for version in $SWIFT_VERSIONS; do
        swiftenv global "$version"
        swiftenv version

        swift test
    done
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    xcodebuild -version

    xcodebuild \
        -project $FRAMEWORK_NAME.xcodeproj \
        -scheme "$FRAMEWORK_NAME-iOS" \
        -sdk iphonesimulator \
        -destination "platform=iOS Simulator,name=iPhone 7,OS=10.0" \
        ONLY_ACTIVE_ARCH=NO \
        test | xcpretty

#    pod lib lint --quick
fi