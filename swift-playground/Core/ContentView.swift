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
    @State private var selectedContent: String? = nil

var body: some View {
    GeometryReader { _ in
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(red: 0.247, green: 0.106, blue: 0.153), Color(red: 0.133, green: 0.067, blue: 0.118)]), center: .trailing, startRadius: 5, endRadius: 400)
            
            RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]), center: .leading, startRadius: 2, endRadius: 500)
                .opacity(0.9)
            
            RadialGradient(gradient: Gradient(colors: [Color.green.opacity(0.4), Color.yellow.opacity(0.5)]), center: .bottom, startRadius: 1, endRadius: 600)
                .opacity(0.8)
            VStack {
                Spacer()
            }
            Image("mangolassi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotationAngle))
                .offset(position)
                .scaleEffect(isScaledUp ? 1.2 : 1)
                .shadow(color: isScaledUp ? Color.black.opacity(0.7) : Color.black.opacity(0.1), radius: isScaledUp ? 14 : 4, x: 0, y: 9)
                .gesture(
                    TapGesture()
                        .simultaneously(with: DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                withAnimation(.easeIn(duration: 0.2)) {
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
                ArcNavvy(selectedContent: $selectedContent)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
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
        
        //app switcher
            if let selectedContentName = selectedContent {
                 withAnimation {
                     contentView(for: selectedContentName)
                }
            }        
        }
    }
}

extension ContentView {

    func contentView(for name: String) -> some View {
        switch name {
        case "Aufn":
            return AnyView(AufnPage(onClose: closeContentPage))
        case "Toshi":
            return AnyView(ToshiPage(onClose: closeContentPage))
        case "Nikko":
            return AnyView(NikkoPage(onClose: closeContentPage))
         case "Nightlight":
            return AnyView(NightlightPage(onClose: closeContentPage))   
         case "Tidydesk":
            return AnyView(TidydeskPage(onClose: closeContentPage))  
         case "Mango":
            return AnyView(MangoPage(onClose: closeContentPage))  
         case "Triton":
            return AnyView(TritonPage(onClose: closeContentPage))  
        case "SHOW_CAROUSEL":
            return AnyView(ContentCarouselView(itemWidth: 280, spacing: 0, rotation: 0, onClose: closeContentPage))        
        default:
            return AnyView(Text("Page not found"))
        }
    }

    func closeContentPage() {
        withAnimation {
            selectedContent = nil
        }
    }
}
