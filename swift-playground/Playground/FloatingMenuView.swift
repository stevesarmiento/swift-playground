//
//  FloatingMenuView.swift
//  swift-playground
//
//  Created by Steven Sarmiento on 1/19/24.
//

import SwiftUI

// struct FloatingMenuView: View {
//     @Binding var isMenuOpen: Bool

//     var body: some View {
//         VStack {
//             Spacer()

//             ZStack {
//                 Button(action: {
//                     print("Button 1 tapped")
//                 }) {
//                     CircleButton(iconName: "1.circle", isMenuOpen: isMenuOpen)
//                 }
//                 .offset(x: isMenuOpen ? -70 : 0, y: 0)
//                 .opacity(isMenuOpen ? 1 : 0)
//                 .animation(.spring().speed(0.9), value: isMenuOpen)

//                 Button(action: {
//                     print("Button 2 tapped")
//                 }) {
//                     CircleButton(iconName: "2.circle", isMenuOpen: isMenuOpen)
//                 }
//                 .offset(x: isMenuOpen ? 70 : 0, y: 0)
//                 .opacity(isMenuOpen ? 1 : 0)
//                 .animation(.spring().speed(0.9), value: isMenuOpen)

//                 Button(action: {
//                     print("Button 3 tapped")
//                 }) {
//                     CircleButton(iconName: "3.circle", isMenuOpen: isMenuOpen)
//                 }
//                 .offset(y: isMenuOpen ? -70 : 0)
//                 .opacity(isMenuOpen ? 1 : 0)
//                 .animation(.spring().speed(0.9), value: isMenuOpen)

//                 Button(action: {
//                     withAnimation {
//                         isMenuOpen.toggle()
//                     }
//                 }) {
//                     CircleButton(iconName: isMenuOpen ? "xmark" : "plus", isMenuOpen: isMenuOpen)
//                 }
//             }
//             .padding()
//         }
//     }
// }

struct FloatingMenuView: View {
    @Binding var isMenuOpen: Bool

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                // Gooey effect background
                if isMenuOpen {
                    Circle()
                        .frame(width: 250, height: 250)
//                        .foregroundColor(Color.white.opacity(0.1))
//                        .blur(radius: 10)
                        .scaleEffect(isMenuOpen ? 1 : 0.1)
                        .animation(.spring().speed(0.9), value: isMenuOpen)
                }

                // Buttons
                Button(action: {
                    print("Button 1 tapped")
                }) {
                    QuarterCircleButton(iconName: "1.circle", isMenuOpen: isMenuOpen, quarter: .topLeft)
                }
                .offset(x: isMenuOpen ? -70 : 0, y: 0)
                .opacity(isMenuOpen ? 1 : 0)
                .animation(.spring().speed(0.9), value: isMenuOpen)

                Button(action: {
                    print("Button 2 tapped")
                }) {
                    CircleButton(iconName: "2.circle", isMenuOpen: isMenuOpen)
                }
                .offset(x: isMenuOpen ? 70 : 0, y: 0)
                .opacity(isMenuOpen ? 1 : 0)
                .animation(.spring().speed(0.9), value: isMenuOpen)

                Button(action: {
                    print("Button 3 tapped")
                }) {
                    CircleButton(iconName: "3.circle", isMenuOpen: isMenuOpen)
                }
                .offset(y: isMenuOpen ? -70 : 0)
                .opacity(isMenuOpen ? 1 : 0)
                .animation(.spring().speed(0.9), value: isMenuOpen)
                
                Button(action: {
                    print("Button 3 tapped")
                }) {
                    CircleButton(iconName: "3.circle", isMenuOpen: isMenuOpen)
                }
                .offset(y: isMenuOpen ? 70 : 0)
                .opacity(isMenuOpen ? 1 : 0)
                .animation(.spring().speed(0.9), value: isMenuOpen)

                // Main button
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
                    //.transition(.symbolEffect(.appear))
                    .padding(6)
                    .background(Color.clear)
                    .clipShape(Circle())
        }
    }
}

struct QuarterCircleButton: View {
    let iconName: String
    let isMenuOpen: Bool
    let quarter: Quarter

    enum Quarter {
        case topLeft, topRight, bottomLeft, bottomRight
    }

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.white.opacity(0.5))
                .frame(width: 57, height: 57)
                .clipShape(Path { path in
                    switch quarter {
                    case .topLeft:
                        path.addArc(center: CGPoint(x: 57, y: 57), radius: 57, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
                    case .topRight:
                        path.addArc(center: CGPoint(x: 0, y: 57), radius: 57, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
                    case .bottomLeft:
                        path.addArc(center: CGPoint(x: 57, y: 0), radius: 57, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
                    case .bottomRight:
                        path.addArc(center: CGPoint(x: 0, y: 0), radius: 57, startAngle: .degrees(-180), endAngle: .degrees(-90), clockwise: false)
                    }
                })
           
            Image(systemName: iconName)
                .font(.system(size: 30))
                .foregroundColor(Color.white.opacity(1))
                .symbolEffect(.bounce, value: isMenuOpen)
                .padding(6)
                .background(Color.clear)
                .clipShape(Circle())
        }
    }
}
