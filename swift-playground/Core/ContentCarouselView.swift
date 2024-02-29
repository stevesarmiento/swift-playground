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
    
    
    //dismiss view
    @Environment(\.presentationMode) var presentationMode
    var onClose: () -> Void
    
    let contentPages = ["Mango", "Triton", "Aufn", "Nikko", "Toshi", "Nightlight", "Tidydesk"]
    let closeContentPage: () -> Void = {
        print("Content page closed")
    }

    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack{
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(contentPages, id: \.self) { pageName in
                                    contentView(for: pageName)
                                        .frame(width: itemWidth, height: 600)
                                        .cornerRadius(30)
                                        .visualEffect { content, geometryProxy in
                                            content
                                                .rotation3DEffect(.init(degrees: rotation(geometryProxy)), axis: (x: 0, y: 0, z: 0), anchor: .center)
                                        }
                            }
                        }
                        .padding(.horizontal, (size.width - itemWidth) / 2)
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .scrollClipDisabled()
                }

                
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
            }
        }
        .edgesIgnoringSafeArea(.all) 
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
    
}
