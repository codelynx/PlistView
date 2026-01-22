import SwiftUI

/// A SwiftUI view that displays a plist node and its children
public struct PlistView: View {
    let node: PlistNode

    public init(node: PlistNode) {
        self.node = node
    }

    public var body: some View {
        List {
            PlistNodeView(node: node)
        }
    }
}

struct PlistNodeView: View {
    let node: PlistNode

    var body: some View {
        if let children = node.children {
            DisclosureGroup {
                ForEach(children) { child in
                    PlistNodeView(node: child)
                }
            } label: {
                nodeLabel
            }
        } else {
            nodeLabel
        }
    }

    private var nodeLabel: some View {
        HStack {
            if let key = node.key {
                Text(key)
                    .fontWeight(.medium)
                Spacer()
            }
            Text(node.displayValue)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    let sampleDict: [String: Any] = [
        "name": "Sample",
        "version": 1.0,
        "enabled": true,
        "items": ["one", "two", "three"],
        "nested": ["key": "value"]
    ]
    let data = try! PropertyListSerialization.data(
        fromPropertyList: sampleDict,
        format: .xml,
        options: 0
    )
    let node = try! PlistParser().parse(data: data)
    return PlistView(node: node)
}
