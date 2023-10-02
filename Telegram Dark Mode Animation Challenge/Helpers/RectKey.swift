//
//  RectKey.swift
//  Telegram Dark Mode Animation Challenge
//
//  Created by Kartikeya Saxena Jain on 10/1/23.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
