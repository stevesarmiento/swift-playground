//
//  ContentView.swift
//  swift-playground
//
//  Created by Steven Sarmiento on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var position = CGSize.zero
    @State private var rotationAngle = 0.0
    @State private var isSpinning = false
    @State private var isScaledUp = false
    @State private var hapticFeedbackTriggered = false

var body: some View {
        GeometryReader { _ in
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color(red: 0.247, green: 0.106, blue: 0.153), Color(red: 0.133, green: 0.067, blue: 0.118)]), center: .trailing, startRadius: 5, endRadius: 400)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                }
                Image("mangolassi")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .offset(position)
                    .rotationEffect(.degrees(rotationAngle))
                    .scaleEffect(isScaledUp ? 1.2 : 1)
                    .shadow(color: isScaledUp ? Color.black.opacity(1) : Color.black.opacity(0.2), radius: isScaledUp ? 10 : 2, x: 0, y: 5)                    
                    .gesture(
                        TapGesture()
                            .simultaneously(with: DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    withAnimation(.easeIn(duration: 0.1)) {
                                        self.isScaledUp = true
                                        self.position = gesture.translation
                                        if !self.hapticFeedbackTriggered {
                                            let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                                            impactFeedbackGenerator.impactOccurred()
                                            self.hapticFeedbackTriggered = true
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeOut) {
                                        self.isScaledUp = false
                                        self.position = .zero
                                        self.hapticFeedbackTriggered = false
                                    }
                                }
                            )
                    )
                VStack {
                    Spacer()
                    ArcNavvy()
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { gesture in
                        let swipeDistance = gesture.translation.width
                        let rotationDegrees = swipeDistance / 2
                        self.rotationAngle = -rotationDegrees
                    }
                    .onEnded { gesture in
                        let swipeVelocity = gesture.predictedEndTranslation.width - gesture.translation.width
                        let additionalRotation = swipeVelocity * 5
                        let finalRotation = self.rotationAngle + -additionalRotation
                        let normalizedRotation = ((finalRotation / 360).rounded()) * 360
                        withAnimation(Animation.easeOut(duration: 3)) {
                            self.rotationAngle = normalizedRotation
                        }
                    }
            )
    }
    .edgesIgnoringSafeArea(.all)

}
}
