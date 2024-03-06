//
//  ToshiPage.swift
//  swift-portfolio
//
//  Created by Steven Sarmiento on 2/27/24.
//

import SwiftUI

struct ToshiPage: View {
    @Environment(\.presentationMode) var presentationMode
    // @GestureState private var dragOffset: CGFloat = 0

    var onClose: () -> Void

    var body: some View {
        ZStack {
            Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))       
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                         onClose()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.5))
                            .clipShape(Circle())
                    }
                }
                .padding()

                Text("Content for Toshi")
                    .foregroundColor(.white)
            }
        }
        // .scaleEffect(1 - dragOffset / 2000)
        // .gesture(
        //     DragGesture()
        //         .updating($dragOffset) { value, state, _ in
        //             state = value.translation.height
        //         }
        //         .onEnded { value in
        //             if value.translation.height > 50 {
        //                 onClose()
        //             }
        //         }
        // )
    }
}
