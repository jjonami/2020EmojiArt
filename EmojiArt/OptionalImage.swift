//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by JJONAMI on 2021/01/27.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
