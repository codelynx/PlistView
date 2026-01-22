//
//  PlistViewDemoApp.swift
//  PlistViewDemo
//
//  Created by Kaz Yoshikawa on 2026/01/22.
//

import SwiftUI

@main
struct PlistViewDemoApp: App {
	@FocusedBinding(\.openFile) private var isFilePickerPresented

	var body: some Scene {
		WindowGroup {
			NavigationStack {
				ContentView()
			}
		}
		.commands {
			CommandGroup(after: .newItem) {
				Button("Open...") {
					isFilePickerPresented = true
				}
				.keyboardShortcut("o", modifiers: .command)
			}
		}
	}
}
