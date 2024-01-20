//
//  ContentView.swift
//  swift-playground
//
//  Created by Steven Sarmiento on 1/19/24.
//

import SwiftUI

struct ContentView: View {
        @State private var isMenuOpen = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.631, green: 0.173, blue: 1.0)
, Color(red: 0.2, green: 0.067, blue: 1.0)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        VStack {
            FloatingMenuView(isMenuOpen: $isMenuOpen)
           }
           .padding()
        }
    }
}

#Preview {
    ContentView()
}
