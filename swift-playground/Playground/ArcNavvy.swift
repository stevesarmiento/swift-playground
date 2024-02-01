//
//  ArcNavvy.swift
//  swift-playground
//
//  Created by Steven Sarmiento on 1/31/24.
//

import SwiftUI

struct ArcNavvy: View {
    @State private var searchText = ""
    @State private var isExpanded = false
    @GestureState private var dragOffset = CGSize.zero
    @Namespace private var animation



    var body: some View {
        GeometryReader { _ in
            if isExpanded {
                Button(action: {
                    withAnimation {
                        isExpanded = false
                    }
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .edgesIgnoringSafeArea(.all)
                }
            }

        ZStack{
            VStack {
                Spacer()
                HStack {
                    if !isExpanded {
                        tabsButton
                        
                        Spacer()
                    }
                    
                    if !isExpanded {
                        searchButton
                        
                        Spacer()
                    }

                    if isExpanded { 
                        expandedOptions

                    } else {
                        chevButton
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .frame(maxWidth: .infinity)
                .frame(height: isExpanded ? 270 : 77)
                .background(
                    BlurBackground().clipShape(RoundedRectangle(cornerRadius: isExpanded ? 40 : 0))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: isExpanded ? 40 : 0)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0), value: isExpanded)

        
            }
            .offset(y: dragOffset.height)
            .edgesIgnoringSafeArea(.bottom)
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, transaction) in
                        if value.translation.height > 0 {
                            state = value.translation
                        }
                    })
                    .onEnded { value in
                        if value.translation.height > 5 {
                            withAnimation(.easeOut(duration: 0.3)) {
                                self.isExpanded = false
                            }
                        }
                    }
            )             
        }
        .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BlurBackground: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.1) 
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

extension ArcNavvy {
    private var tabsButton: some View {
                VStack{
                    Button(action: {
                        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                        impactFeedbackGenerator.prepare() 
                        impactFeedbackGenerator.impactOccurred()
                        // Action for Home
                    }) {
                        ZStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.251, green: 0.224, blue: 0.243))
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            }
                            .frame(width: 28, height: 30)
                            .rotationEffect(.degrees(-9))
                            .offset(x: 5, y: 10)

                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.251, green: 0.224, blue: 0.243))
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            }
                            .frame(width: 28, height: 30)
                            .rotationEffect(.degrees(7))
                            .offset(x: 15)
                        }
                        .offset(x:-25, y:-3)
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(PlainButtonStyle())
                    .pressAnimation()
                }

    }

    private var searchButton: some View {
                VStack{
                    Button(action: {
                        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                        impactFeedbackGenerator.prepare() 
                        impactFeedbackGenerator.impactOccurred()
                        // Action for Home
                    }) {
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(PlainButtonStyle())
                    .pressAnimation()

                    
                }

    }

    private var chevButton: some View {
                VStack{
                    Button(action: {
                        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                        impactFeedbackGenerator.prepare() 
                        impactFeedbackGenerator.impactOccurred()
                        self.isExpanded.toggle()
                    }) {
                        VStack {
                            Image(systemName: "chevron.up")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .bold()
                        }
                        .frame(width: 16, height: 16)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.white.opacity(0.1))
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)                           
                                .matchedGeometryEffect(id: "searchBarIcon", in: animation, anchor: .leading)
                        )
                        .offset(x:25)

                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(PlainButtonStyle())
                    .pressAnimation()                    
                }

    }

    private var expandedSearch: some View {
        
    }

    private var expandedOptions: some View {
                    VStack {
                        HStack {
                            Image(systemName: "chevron.left")
                                .frame(width: 18)
                                .bold()
                                .foregroundColor(Color.white.opacity(0.4))
                            Image(systemName: "chevron.right")
                                .frame(width: 18)
                                .bold()
                                .foregroundColor(Color.white.opacity(0.4))


                            
                            TextField("", text: $searchText)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        
                                        Image(systemName: "star")
                                            .resizable()
                                            .bold()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.white.opacity(0.4))
                                            .padding(.trailing, 5)
                                        
                                        Image(systemName: "arrow.clockwise")
                                            .resizable()
                                            .bold()
                                            .frame(width: 18, height: 20)
                                            .foregroundColor(Color.white.opacity(0.4))
                                    }
                                )
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.1))
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                .matchedGeometryEffect(id: "searchBarIcon", in: animation, anchor: .leading)
                        )

                        HStack(spacing: 20) { 
                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.05))
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Image(systemName: "book.pages")
                                            .foregroundColor(.white.opacity(0.3))
                                            .font(.system(size: 24))
                                    )
                                Text("Reader Mode")
                                    .font(.system(size: 11))
                                    .bold()
                                    .foregroundColor(.white.opacity(0.3))
                            }

                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.05))
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Image(systemName: "doc.text.magnifyingglass")
                                            .foregroundColor(.white.opacity(0.3))
                                            .font(.system(size: 24))
                                    )
                                Text("Find on Page")
                                    .font(.system(size: 11))
                                    .bold()                                    
                                    .foregroundColor(.white.opacity(0.3))
                            }

                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.05))
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Image(systemName: "link")
                                            .foregroundColor(.white.opacity(0.3))
                                            .font(.system(size: 24))
                                    )
                                Text("Copy URL")
                                    .font(.system(size: 11))
                                     .bold()                                   
                                    .foregroundColor(.white.opacity(0.3))
                                    
                            }

                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.05))
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Image(systemName: "paperplane")
                                            .foregroundColor(.white.opacity(0.3))
                                            .font(.system(size: 24))
                                    )
                                Text("Share")
                                    .font(.system(size: 11))
                                     .bold()                                   
                                    .foregroundColor(.white.opacity(0.3))
                            }
                        }
                        .padding(.top, 10)    

                        HStack() { 
                            Button(action: {
                                // Button 1 action
                            }) {
                                HStack {
                                    Image(systemName: "app.gift") 
                                        .font(.system(size: 20))
                                        .foregroundColor(.white.opacity(1))
                                    Text("Gift Arc") 
                                        .font(.system(size: 14))
                                        .foregroundColor(.white.opacity(1))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .pressAnimation()

                            Button(action: {
                                // Button 2 action
                            }) {
                                HStack {
                                    Image(systemName: "gear") 
                                        .font(.system(size: 20))
                                        .foregroundColor(.white.opacity(1))
                                    Text("Settings") 
                                        .font(.system(size: 14))
                                        .foregroundColor(.white.opacity(1))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .pressAnimation()                            
                        }
                        .padding(.top, 10)               
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
    }
    
}
