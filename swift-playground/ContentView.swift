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
    // @State private var lastHapticAngle = 0.0
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
                                        self.hapticFeedbackTriggered = false // Reset for the next gesture
                                    }
                                }
                            )
                    )
                    // .gesture(
                    //     DragGesture()
                    //         .onChanged { gesture in
                    //             self.position = gesture.translation
                    //         }
                    //         .onEnded { _ in
                    //             withAnimation {
                    //                 self.position = .zero
                    //             }
                    //         }
                    // )
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

                            // let hapticThreshold = 10.0
                            // let rotationDifference = abs(self.rotationAngle - self.lastHapticAngle)
                            // if rotationDifference >= hapticThreshold {
                            //     let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
                            //     impactFeedbackGenerator.impactOccurred()
                            //     self.lastHapticAngle = self.rotationAngle
                            // }
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
