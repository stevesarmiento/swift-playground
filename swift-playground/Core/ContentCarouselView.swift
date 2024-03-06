//
//  ContentCarouselView.swift
//  swift-portfolio
//
//  Created by Steven Sarmiento on 2/28/24.
//

import SwiftUI

struct ContentCarouselView: View {
    var itemWidth: CGFloat
    var spacing: CGFloat = 0
    var rotation: Double
    
    @Environment(\.presentationMode) var presentationMode
    var onClose: () -> Void
    
    let contentPages = ["Mango", "Triton", "Aufn", "Nikko", "Toshi", "Nightlight", "Tidydesk"]
    let closeContentPage: () -> Void = {
        print("Content page closed")
    }

    var body: some View {
        ZStack {
                BlurBackground() 
            
            VStack{
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(contentPages, id: \.self) { pageName in
                                    contentView(for: pageName)
                                        .frame(width: itemWidth, height: 600)
                                        .cornerRadius(30)
                                        .shadow(color: Color.black.opacity(0.2), radius: 14 , x: 0, y: 9)
                                        .contentShape(Rectangle())
                                        .onTapGesture {}
                                        .pressAnimation()
                                        .visualEffect { content, geometryProxy in
                                            content
                                                .rotation3DEffect(.init(degrees: rotation(geometryProxy)), axis: (x: 0, y: 0, z: 0), anchor: .center)
                                        }
                            }
                            .padding(.trailing, 15)
                        }
                        .padding(.horizontal, (size.width - itemWidth) / 2)
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .scrollClipDisabled()
                }
            }
        }
        .edgesIgnoringSafeArea(.all) 
        .onTapGesture {
           withAnimation {
             onClose()

           }
        }       
    }
    
    @ViewBuilder
    func contentView(for name: String) -> some View {
        switch name {
            case "Aufn":
                AnyView(AufnPage(onClose: closeContentPage))
            case "Toshi":
                AnyView(ToshiPage(onClose: closeContentPage))
            case "Nikko":
                AnyView(NikkoPage(onClose: closeContentPage))
            case "Nightlight":
                AnyView(NightlightPage(onClose: closeContentPage))
            case "Tidydesk":
                AnyView(TidydeskPage(onClose: closeContentPage))
            case "Mango":
                AnyView(MangoPage(onClose: closeContentPage))
            case "Triton":
                AnyView(TritonPage(onClose: closeContentPage)) 
        default:
            Text("Page not found")
        }
    }
}

extension ContentCarouselView {
    func rotation(_ proxy: GeometryProxy) -> Double {
        let scrollViewWidth = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let midX = proxy.frame(in: .scrollView(axis: .horizontal)).midX
        let progress = midX / scrollViewWidth
        let cappedProgress = max(min(progress, 1), 0)
        let degree = cappedProgress * (rotation * 2)
        
        return rotation - degree
    }

    struct BlurBackground: View {
        var body: some View {
            ZStack {
                Color.black.opacity(0.8)
                VisualEffectBlur(blurStyle: .systemThinMaterialDark)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

    struct VisualEffectBlur: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        }
        
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            uiView.effect = UIBlurEffect(style: blurStyle)
        }
    }
    
}
