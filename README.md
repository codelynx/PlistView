# PlistViewer

A SwiftUI package for viewing property list (plist) files.

## Features

- Parse XML and binary plist formats
- Display plist contents as a collapsible tree
- Support for all plist value types: Dictionary, Array, String, Number, Boolean, Date, Data

## Requirements

- macOS 13+ / iOS 16+
- Swift 6.2+

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/codelynx/PlistView.git", from: "0.1.0")
]
```

Or in Xcode: File > Add Package Dependencies and enter the repository URL.

## Usage

```swift
import PlistViewer

// Parse from URL
let node = try PlistParser().parse(url: fileURL)

// Parse from Data
let node = try PlistParser().parse(data: plistData)

// Display in SwiftUI
PlistView(node: node)
```

## Demo

A demo macOS app is included in `Demo/PlistViewDemo/`. Open the Xcode project and add the local PlistViewer package to run it.

## License

MIT License. See [LICENSE](LICENSE) for details.
