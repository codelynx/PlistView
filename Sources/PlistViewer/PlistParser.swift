import Foundation

/// Parses plist data into PlistNode tree
public struct PlistParser: Sendable {

    public init() {}

    public func parse(data: Data) throws -> PlistNode {
        let plist = try PropertyListSerialization.propertyList(
            from: data,
            options: [],
            format: nil
        )
        return convert(value: plist, key: nil)
    }

    public func parse(url: URL) throws -> PlistNode {
        let data = try Data(contentsOf: url)
        return try parse(data: data)
    }

    private func convert(value: Any, key: String?) -> PlistNode {
        switch value {
        case let dict as [String: Any]:
            let items = dict.sorted { $0.key < $1.key }.map { k, v in
                convert(value: v, key: k)
            }
            return .dictionary(key: key, items: items)

        case let array as [Any]:
            let items = array.enumerated().map { index, v in
                convert(value: v, key: "[\(index)]")
            }
            return .array(key: key, items: items)

        case let string as String:
            return .string(key: key, value: string)

        case let bool as Bool:
            return .bool(key: key, value: bool)

        case let number as NSNumber:
            return .number(key: key, value: number)

        case let date as Date:
            return .date(key: key, value: date)

        case let data as Data:
            return .data(key: key, value: data)

        default:
            return .string(key: key, value: String(describing: value))
        }
    }
}
