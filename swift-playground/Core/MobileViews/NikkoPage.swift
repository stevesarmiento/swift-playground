//
//  NikkoPage.swift
//  swift-portfolio
//
//  Created by Steven Sarmiento on 2/27/24.
//

import SwiftUI

struct NikkoPage: View {
    @Environment(\.presentationMode) var presentationMode
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

                Text("Content for Nikko")
                    .foregroundColor(.white)
            }
        }
    }
}
