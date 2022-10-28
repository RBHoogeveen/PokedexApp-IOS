//
//  BackgroundCell.swift
//  PokedexApp
//
//  Created by user224392 on 10/20/22.
//

import SwiftUI

struct BackgroundCell: View {
    var colors: [Color] = [Color(.systemIndigo), Color(.systemPurple)]
    @Environment(\.colorScheme) var scheme
    let blur: CGFloat = 30
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                colors.first
                ZStack {
                    Cloud(proxy: proxy,
                          color: colors.last ?? .indigo,
                          rotationStart: 0,
                          duration: 30,
                          alignment: .bottomTrailing)
                    Cloud(proxy: proxy,
                          color: colors.last ?? .indigo,
                          rotationStart: 240,
                          duration: 20,
                          alignment: .topTrailing)
                    Cloud(proxy: proxy,
                          color: colors.last ?? .indigo,
                          rotationStart: 120,
                          duration: 50,
                          alignment: .bottomLeading)
                    Cloud(proxy: proxy,
                          color: colors.last ?? .indigo,
                          rotationStart: 180,
                          duration: 40,
                          alignment: .topLeading)
                }
                .blur(radius: blur)
            }
            .ignoresSafeArea()
        }
    }
}

struct Cloud: View {
    @StateObject var provider = CloudProvider()
    @State var move = false
    let proxy: GeometryProxy
    let color: Color
    let rotationStart: Double
    let duration: Double
    let alignment: Alignment

    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360) )
            .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear {
                move.toggle()
            }
    }
}

class CloudProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat

    init() {
        frameHeightRatio = CGFloat.random(in: 0.7 ..< 1.4)
        offset = CGSize(width: CGFloat.random(in: -150 ..< 150),
                        height: CGFloat.random(in: -150 ..< 150))
    }
}

struct BackgroundCell_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCell()
    }
}
