//
//  ContentView.swift
//  PlistViewDemo
//
//  Created by Kaz Yoshikawa on 2026/01/22.
//

import SwiftUI
import PlistViewer
import UniformTypeIdentifiers

struct ContentView: View {
	@State private var node: PlistNode?
	@State private var errorMessage: String?
	@State private var isFilePickerPresented = false
	@State private var fileName: String?

	var body: some View {
		Group {
			if let node {
				PlistView(node: node)
			} else if let errorMessage {
				ContentUnavailableView {
					Label("Error", systemImage: "exclamationmark.triangle")
				} description: {
					Text(errorMessage)
				}
			} else {
				ContentUnavailableView {
					Label("No Plist", systemImage: "doc")
				} description: {
					Text("Open a plist file from the File menu")
				}
			}
		}
		.navigationTitle(fileName ?? "PlistViewDemo")
		.fileImporter(
			isPresented: $isFilePickerPresented,
			allowedContentTypes: [UTType.propertyList],
			allowsMultipleSelection: false
		) { result in
			handleFileImport(result)
		}
		.onOpenURL { url in
			loadPlist(from: url)
		}
		.focusedSceneValue(\.openFile, $isFilePickerPresented)
	}

	private func handleFileImport(_ result: Result<[URL], Error>) {
		switch result {
		case .success(let urls):
			if let url = urls.first {
				loadPlist(from: url)
			}
		case .failure(let error):
			errorMessage = error.localizedDescription
		}
	}

	private func loadPlist(from url: URL) {
		do {
			let accessing = url.startAccessingSecurityScopedResource()
			defer {
				if accessing {
					url.stopAccessingSecurityScopedResource()
				}
			}
			node = try PlistParser().parse(url: url)
			fileName = url.lastPathComponent
			errorMessage = nil
		} catch {
			errorMessage = error.localizedDescription
			node = nil
		}
	}
}

struct OpenFileFocusedKey: FocusedValueKey {
	typealias Value = Binding<Bool>
}

extension FocusedValues {
	var openFile: Binding<Bool>? {
		get { self[OpenFileFocusedKey.self] }
		set { self[OpenFileFocusedKey.self] = newValue }
	}
}

#Preview {
	ContentView()
}
