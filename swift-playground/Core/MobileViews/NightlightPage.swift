//
//  NightlightPage.swift
//  swift-portfolio
//
//  Created by Steven Sarmiento on 2/27/24.
//

import SwiftUI

struct NightlightPage: View {
    @Environment(\.presentationMode) var presentationMode
    var onClose: () -> Void

    var body: some View {
        ZStack {
            Color.black
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

                Text("Content for Nightlight")
                    .foregroundColor(.white)
            }
        }
    }
}
