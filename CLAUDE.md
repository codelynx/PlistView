# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Code Style

- Use tabs for indentation

## Build Commands

```bash
swift build          # Build the package
swift test           # Run all tests
swift test --filter PlistViewerTests.testName  # Run a single test
```

## Architecture

PlistViewer is a SwiftUI library for displaying plist files (XML and binary formats).

**Data flow:** `plist file/data` → `PlistParser` → `PlistNode` tree → `PlistView`

- **PlistNode** - Recursive enum representing plist value types (dictionary, array, string, number, bool, date, data). Conforms to `Identifiable` for SwiftUI and `Sendable` for concurrency.
- **PlistParser** - Converts raw plist data into a `PlistNode` tree using `PropertyListSerialization`.
- **PlistView** - SwiftUI view that renders `PlistNode` as a collapsible tree using `DisclosureGroup`.

## Usage

```swift
let node = try PlistParser().parse(url: fileURL)
PlistView(node: node)
```
