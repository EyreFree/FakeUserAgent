# FakeUserAgent

[![Version](https://img.shields.io/cocoapods/v/FakeUserAgent.svg?style=flat)](https://cocoapods.org/pods/FakeUserAgent)
[![License](https://img.shields.io/cocoapods/l/FakeUserAgent.svg?style=flat)](https://cocoapods.org/pods/FakeUserAgent)
[![Platform](https://img.shields.io/cocoapods/p/FakeUserAgent.svg?style=flat)](https://cocoapods.org/pods/FakeUserAgent)
[![SPM](https://img.shields.io/badge/SPM-ready-orange.svg)](https://swiftpackageindex.com/EyreFree/FakeUserAgent)

Up-to-date simple useragent faker with real world database in Swift, inspired by [fake-useragent](https://github.com/fake-useragent/fake-useragent).

## Features

- Data is pre-downloaded from useragentstring.com and the data is part of the package;
- Retrieves user-agent strings locally.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11+
- macOS 10.13+
- tvOS 11+
- watchOS 6+

## Installation

### CocoaPods

FakeUserAgent is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'FakeUserAgent'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

Once you have your Swift package set up, adding FakeUserAgent as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/EyreFree/FakeUserAgent", .upToNextMinor(from: "0.2.0"))
]
```

## Use

```swift
import FakeUserAgent

FakeUserAgent.shared.pickALot(count: 5, browser: .chrome, filter: { userAgent in
    return userAgent.contains("Macintosh; Intel Mac OS X 10_")
}, completion: { result in
    print(result.joined(separator: "\n"))
})
```

Will show:

```bash
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.803.0 Safari/535.1
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Safari/537.36
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_7) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.68 Safari/534.24
```

## Update

1. Get data file from [fake_useragent/../browsers.json](https://github.com/fake-useragent/fake-useragent/blob/master/src/fake_useragent/data/browsers.json);
2. Replace `"internet explorer"` to `"internetExplorer"` in file;
3. Replace `}{` to `,` in file;
4. Move to `FakeUserAgent/Assets`

## Author

EyreFree, eyrefree@eyrefree.org

## License

FakeUserAgent is available under the MIT license. See the LICENSE file for more info.
