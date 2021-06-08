![Project version](https://img.shields.io/badge/version-0.1.2-brightgreen)
![Swift version](https://img.shields.io/static/v1?label=Swift&message=5.3&color=orange&logo=swift)
![iOS version](https://img.shields.io/static/v1?label=iOS&message=13.0&color=yellow&logo=apple)
![Xcode version](https://img.shields.io/static/v1?label=Xcode&message=12.4&color=blue&logo=xcode)

# Gainy iOS app

## Overview

The repo contains iOS application for [Gainy](https://www.gainy.app).

Gainy is a mobile app that helps you identify the right stock or cryptocurrency depends on your portfolio, personal goals, and fundamental analysis. Digestible, adjustable, and on the go.

## How to get the app in TestFlight (currently, internal testing only)

- Ask @dersim-davaod to invite you into AppStore Connect account (if you're not invited yet). You should provide a email associate with the Apple ID you're going to use;
- Wait for the invitation link into the TestFlight and then accept the invitation;
- Review https://testflight.apple.com to learn more about how to test the app (in case of any questions, direct them to @dersim-davaod)

## How to build and run the app

<details>
<summary>&nbsp;&nbsp;Prerequisites</summary>
<p>

- Install Xcode 12.4+ and Command Line tools;
- (optionally) Install [brew](https://brew.sh) package manager. It is required to run SwiftLint and SwiftFormat;
- (optionally) Install [SwiftLint](https://github.com/realm/SwiftLint) and [SwiftFormat](https://github.com/nicklockwood/SwiftFormat):
```bash
brew install swiftlint
brew install swiftformat 
```
- (optionally) iPhone device with iOS13.0+ installed (You can build and run the app using iOS simulator);

</p>
</details>

<details>
<summary>&nbsp;&nbsp;Running using Xcode</summary>
<p>

- Clone the project and navigate into the root dir;
- Open Xcode workspace at `Gainy.xcworkspace`;
- Choose `Gainy` scheme and select iOS simulator to run the app on;
- (optionally) Select device to run the app on (you might need a development certificate, let @dersim-davaod know if you need it);
- Build and run the app;

</p>
</details>

## Contributing

Please see the [CONTRIBUTING file](CONTRIBUTING.md) to know how make a contribution.

## Versioning

Please see the [CONTRIBUTING file](CONTRIBUTING.md#versioning) to find more details about the versioning.

## Licensing

Please see the [license file](LICENSE.md).
