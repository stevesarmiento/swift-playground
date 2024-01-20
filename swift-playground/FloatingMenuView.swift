//
//  FloatingMenuView.swift
//  swift-playground
//
//  Created by Steven Sarmiento on 1/19/24.
//

import SwiftUI

struct FloatingMenuView: View {
    @Binding var isMenuOpen: Bool

    var body: some View {
        GeometryReader { geometry in 
         VStack {
            Spacer()

            if isMenuOpen {
                Button(action: {
                    print("Button 1 tapped")
                }) {
                    CircleButton(iconName: "1.circle", isMenuOpen: isMenuOpen)
                }

                Button(action: {
                    print("Button 2 tapped")
                }) {
                    CircleButton(iconName: "2.circle", isMenuOpen: isMenuOpen)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)


                Button(action: {
                    print("Button 3 tapped")
                }) {
                    CircleButton(iconName: "3.circle", isMenuOpen: isMenuOpen)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 60)

            }

            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                CircleButton(iconName: isMenuOpen ? "xmark" : "plus", isMenuOpen: isMenuOpen)
            }
        }
        .padding()       
        }
    }
}

struct CircleButton: View {
    let iconName: String
    let isMenuOpen: Bool

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.white.opacity(0.5))
                .frame(width: 57, height: 57)
           
            Image(systemName: iconName)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white.opacity(1))
                    .symbolEffect(.bounce, value: isMenuOpen)
                    .transition(.symbolEffect(.appear))
                    .padding(6)
                    .background(Color.clear)
                    .clipShape(Circle())
        }
    }
}
