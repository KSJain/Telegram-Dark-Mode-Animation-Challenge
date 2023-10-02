//
//  View+Extensions.swift
//  Telegram Dark Mode Animation Challenge
//
//  Created by Kartikeya Saxena Jain on 10/1/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func rect(value: @escaping (CGRect) -> () ) -> some View {
        self
            .overlay {
                GeometryReader(content: { geometry in
                    let rect = geometry.frame(in: .global)
                    
                    Color.clear
                        .preference(key: RectKey.self, value: rect)
                        .onPreferenceChange(RectKey.self, perform: { rect in
                            value(rect)
                        })
                   
                })
            }
    }
    
    @MainActor
    @ViewBuilder
    func createViewImageGrab(toggleDarkMode: Bool, currentImage: Binding<UIImage?>, previousImage: Binding<UIImage?>, activateDarkMode: Binding<Bool>) -> some View {
        self
            .onChange(of: toggleDarkMode) { oldValue, newValue in
                Task {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        
                        let windows = windowScene.windows
                        var window = windows.first
                        if !(window?.isKeyWindow ?? false) { window = nil }
                        if let rootView = window?.rootViewController?.view {
                            let frameSize = rootView.frame.size
                            
                            activateDarkMode.wrappedValue = !newValue
                            previousImage.wrappedValue = rootView.captureImage(ofSize: frameSize)
                            
                            activateDarkMode.wrappedValue = newValue
                            try await Task.sleep(for: .seconds(1))
                            currentImage.wrappedValue = rootView.captureImage(ofSize: frameSize)
                        }
                        
                    }
                }
            }
    }
}

extension UIView {
    func captureImage(ofSize size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size),
                          afterScreenUpdates: true)
        }
    }
}
