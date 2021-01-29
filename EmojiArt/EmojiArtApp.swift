//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by JJONAMI on 2021/01/25.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
//            EmojiArtDocumentView(document: EmojiArtDocument())
            EmojiArtDocumentChooser().environmentObject(EmojiArtDocumentStore(named: "Emoji Art"))
        }
    }
}
