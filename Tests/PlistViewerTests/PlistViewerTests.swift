import Testing
import Foundation
@testable import PlistViewer

@Test func parseDictionary() throws {
    let dict: [String: Any] = ["key": "value"]
    let data = try PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)

    let node = try PlistParser().parse(data: data)

    guard case .dictionary(_, let items) = node else {
        #expect(Bool(false), "Expected dictionary")
        return
    }
    #expect(items.count == 1)
}

@Test func parseArray() throws {
    let array = ["one", "two", "three"]
    let data = try PropertyListSerialization.data(fromPropertyList: array, format: .xml, options: 0)

    let node = try PlistParser().parse(data: data)

    guard case .array(_, let items) = node else {
        #expect(Bool(false), "Expected array")
        return
    }
    #expect(items.count == 3)
}

@Test func parseNestedStructure() throws {
    let nested: [String: Any] = [
        "name": "Test",
        "items": [1, 2, 3],
        "config": ["enabled": true]
    ]
    let data = try PropertyListSerialization.data(fromPropertyList: nested, format: .xml, options: 0)

    let node = try PlistParser().parse(data: data)

    guard case .dictionary(_, let items) = node else {
        #expect(Bool(false), "Expected dictionary")
        return
    }
    #expect(items.count == 3)
}
