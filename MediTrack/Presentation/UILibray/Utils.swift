//
//  Utils.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 15/1/2026.
//
import SwiftUI

struct TextLengthLimiter: ViewModifier {
    let max: Int
    let onLimitReached: (() -> Void)?
    @Binding var text: String

    func body(content: Content) -> some View {
        content.onChange(of: text) { _, newValue in
            if newValue.count > max {
                text = String(newValue.prefix(max))
                onLimitReached?()
            }
        }
    }
}

extension View {
    func limitTextLength(
        _ text: Binding<String>,
        max: Int,
        onLimitReached: (() -> Void)? = nil
    ) -> some View {
        modifier(TextLengthLimiter(max: max, onLimitReached: onLimitReached, text: text))
    }
}
