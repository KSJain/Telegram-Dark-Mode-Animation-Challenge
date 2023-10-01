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
    }
}

#Preview {
    ContentView()
}
