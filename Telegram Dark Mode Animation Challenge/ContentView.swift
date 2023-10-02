//
//  ContentView.swift
//  Telegram Dark Mode Animation Challenge
//
//  Created by Kartikeya Saxena Jain on 9/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Int = 0
    @State private var toggles: [Bool] = Array(repeating: false, count: 10)
    
    @State private var toggleDarkMode: Bool = false // flag triggers create image ext func
    @State private var activateDarkMode: Bool = false
    
    @State private var buttonRect: CGRect = .zero
    
    @State private var previousImage: UIImage?
    @State private var currentImage: UIImage?
    
    var body: some View {
        TabView(selection: $activeTab,
                content:  {
            // TAB 1
            NavigationStack {
                List {
                    Section("Text Section") {
                        Toggle("Large Display", isOn: $toggles[0])
                        Toggle("Bold Text", isOn: $toggles[1])
                    }
                    
                    Section {
                        Toggle("Night Light", isOn: $toggles[2])
                        Toggle("True Tone", isOn: $toggles[3])
                    } header: {
                        Text("Display Section")
                    } footer: {
                        Text("Footer Text")
                    }
                }
                .navigationTitle("Dark Mode")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            // TAB 2
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        })
        .overlay(alignment: .topTrailing) {
            Button(action: {
                toggleDarkMode.toggle()
            }, label: {
                Image(systemName: toggleDarkMode ? "sun.max.fill" : "moon.fill")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                    .symbolEffect(.bounce, value: toggleDarkMode)
                    .frame(width: 40, height: 40)
            })
            .rect { rect in
                buttonRect = rect
            }
            .padding(10)
        }
        .overlay(alignment: .topLeading) {
            if buttonRect != .zero {
                Circle()
                    .fill(.red)
                    .frame(width: buttonRect.width, height: buttonRect.height)
                    .offset(x: buttonRect.minX, y: buttonRect.minY)
                    .ignoresSafeArea()
                    .hidden()
            }
        }
        .createViewImageGrab(toggleDarkMode: toggleDarkMode,
                               currentImage: $currentImage,
                             previousImage: $previousImage, activateDarkMode: $activateDarkMode)
        .overlay {
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                if let previousImage, let currentImage {
                    VStack {
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            })
        }
        .preferredColorScheme(activateDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
