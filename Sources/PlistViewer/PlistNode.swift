import Foundation

/// Represents a node in a plist structure
public enum PlistNode: Identifiable, Sendable {
    case dictionary(key: String?, items: [PlistNode])
    case array(key: String?, items: [PlistNode])
    case string(key: String?, value: String)
    case number(key: String?, value: NSNumber)
    case bool(key: String?, value: Bool)
    case date(key: String?, value: Date)
    case data(key: String?, value: Data)

    public var id: String {
        let keyPart = key ?? "root"
        switch self {
        case .dictionary(_, let items):
            return "\(keyPart)-dict-\(items.count)"
        case .array(_, let items):
            return "\(keyPart)-array-\(items.count)"
        case .string(_, let value):
            return "\(keyPart)-string-\(value.hashValue)"
        case .number(_, let value):
            return "\(keyPart)-number-\(value)"
        case .bool(_, let value):
            return "\(keyPart)-bool-\(value)"
        case .date(_, let value):
            return "\(keyPart)-date-\(value.hashValue)"
        case .data(_, let value):
            return "\(keyPart)-data-\(value.count)"
        }
    }

    public var key: String? {
        switch self {
        case .dictionary(let key, _),
             .array(let key, _),
             .string(let key, _),
             .number(let key, _),
             .bool(let key, _),
             .date(let key, _),
             .data(let key, _):
            return key
        }
    }

    public var children: [PlistNode]? {
        switch self {
        case .dictionary(_, let items), .array(_, let items):
            return items
        default:
            return nil
        }
    }

    public var displayValue: String {
        switch self {
        case .dictionary(_, let items):
            return "Dictionary (\(items.count) items)"
        case .array(_, let items):
            return "Array (\(items.count) items)"
        case .string(_, let value):
            return value
        case .number(_, let value):
            return value.stringValue
        case .bool(_, let value):
            return value ? "true" : "false"
        case .date(_, let value):
            return value.formatted()
        case .data(_, let value):
            return "Data (\(value.count) bytes)"
        }
    }

    public var typeName: String {
        switch self {
        case .dictionary: return "Dictionary"
        case .array: return "Array"
        case .string: return "String"
        case .number: return "Number"
        case .bool: return "Boolean"
        case .date: return "Date"
        case .data: return "Data"
        }
    }
}
