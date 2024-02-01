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
            RadialGradient(gradient: Gradient(colors: [Color(red: 0.247, green: 0.106, blue: 0.153), Color(red: 0.133, green: 0.067, blue: 0.118)]), center: .trailing, startRadius: 5, endRadius: 400)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ArcNavvy()
            }
        }
    }
}
