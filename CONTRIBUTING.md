# Contributing

See [README.md file](README.md) to know how to biuld the app.

Additionaly make sure:
- to nstall [brew](https://brew.sh) package manager. It is required to run SwiftLint and SwiftFormat;
- to install [SwiftLint](https://github.com/realm/SwiftLint) and [SwiftFormat](https://github.com/nicklockwood/SwiftFormat):
```bash
brew install swiftlint
brew install swiftformat 
```

## Submitting code

Before submitting any code, make sure the code is compilable (there are no warnings or errors), there are no runtime issues (use TSAN, ASAN, UBSAN checks) and all tests pass.

## Versioning

Currently, the project uses [semver v2.0](https://semver.org).

For the initial `0.x.y` development phase the initial release is `0.1.0` and then the minor version for each subsequent release is incremented.
