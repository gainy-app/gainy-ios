![Project version](https://img.shields.io/badge/version-0.1.2-brightgreen)
![Swift version](https://img.shields.io/static/v1?label=Swift&message=5.3&color=orange&logo=swift)
![iOS version](https://img.shields.io/static/v1?label=iOS&message=13.0&color=yellow&logo=apple)
![Xcode version](https://img.shields.io/static/v1?label=Xcode&message=12.4&color=blue&logo=xcode)

# Gainy iOS app

## Overview

The repo contains iOS application for [Gainy](https://www.gainy.app).

Gainy is a mobile app that helps you identify the right stock or cryptocurrency depends on your portfolio, personal goals, and fundamental analysis.
Digestible, adjustable, and on the go.

## How to get the app using TestFlight (currently, internal testing only)

<details>
<summary>&nbsp;&nbsp;How to get an invite</summary>
<p>

- Ask @dersim-davaod to invite you into AppStore Connect account (if you're not invited yet). You should provide a email associate with the Apple ID you're going to use;
- Wait for the invitation link into the TestFlight and then accept the invitation;
- Review https://testflight.apple.com to learn more about how to test the app (in case of any questions, direct them to @dersim-davaod)

</p>
</details>

## How to build and run the app

<details>
<summary>&nbsp;&nbsp;Prerequisites</summary>
<p>

1. Install `Xcode 12.4+` and `Command Line Tools for Xcode`;
1. Make sure you have a configuration file to store API keys at  `Gainy/Gainy/Resources/Config.xcconfig`. If no, please create it. **WARNING: ** do not put this file under the VSC tracking!
1. Obtain the `GraphQL API key`. To get the data from the remote server and to make network requests, you must provide GraphQL API key. To obrain the key, follow the next steps:
  - Open [Heroku's API explorer](https://gainy-dev.herokuapp.com/console/api-explorer). Contact @artem-vysotsky if you need an access.
  - Navigate to `GRAPHIQL` tab and find `Request Headers` section.
  - Next, in the `Request Headers` section find the `x-hasura-admin-secret-key` field, reveal its value and copy the value, you will need it later.
1. (optionally) Obtain the `AppsFlyer dev key`. If you want the app to send in-app events, you should provide an AppsFlyer dev key to uniquely identify your account and the app.
  - Log into the AppsFlyer dashboard.
  - Navigate to `Configuration` > `App Settings`.
  - Copy the dev key, you will need it later.
1. (optionally) Install [brew](https://brew.sh) package manager. It is required to run SwiftLint and SwiftFormat;
1. (optionally) Install [SwiftLint](https://github.com/realm/SwiftLint) and [SwiftFormat](https://github.com/nicklockwood/SwiftFormat):
```bash
brew install swiftlint
brew install swiftformat 
```
1. (optionally) iPhone device with `iOS13.0+` installed (You can build and run the app using an iOS simulator);

</p>
</details>

<details>
<summary>&nbsp;&nbsp;Running using Xcode</summary>
<p>

- Clone the project and navigate into the root dir;
- Provide the `GraphQL API key` required to get the data from the remote endpoint. Add the line `GRAPH_QL_API_KEY = API_KEY` into the `Gainy/Gainy/Resources/Config.xcconfig` file, replacing `API_KEY` with the GraphQL admin's secret you obtained at the previous steps;
- (optionally) Provide the `AppsFlyer dev key` required to send AppsFlyer analytics. Add the line `APPS_FLYER_DEV_KEY = DEV_KEY` into the `Gainy/Gainy/Resources/Config.xcconfig` file, replacing `DEV_KEY` with the AppsFlyer dev key you obtained at the previous steps;
- Open the Xcode workspace at `Gainy.xcworkspace`;
- Choose the `Gainy` scheme and select iOS simulator to run the app on;
- (optionally) Select a device to run the app on (you might need a development certificate, let @dersim-davaod know if you need it);
- Build and run the app;

</p>
</details>

## Contributing

Please see the [CONTRIBUTING file](CONTRIBUTING.md) to know how make a contribution.

## Versioning

Please see the [CONTRIBUTING file](CONTRIBUTING.md#versioning) to find more details about the versioning.

## Licensing

Please see the [license file](LICENSE.md).
