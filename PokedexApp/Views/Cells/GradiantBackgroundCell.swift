//
//  GradiantBackgroundCell.swift
//  PokedexApp
//
//  Created by user224392 on 10/20/22.
//

import SwiftUI

struct GradiantBackgroundCell: View {
    @State var start = UnitPoint(x: 0, y: 0)
    @State var end = UnitPoint(x: 0, y: 2)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    var colors: [Color] = [Color(.systemIndigo), Color(.systemPurple)]
    
    var body: some View {
        
    LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
        .animation(Animation.easeInOut(duration: 6).repeatForever())
        .onReceive(timer, perform: { _ in
            
            self.start = UnitPoint(x: -1, y: -2)
            self.end = UnitPoint(x: 0, y: 0)
        })

    }
}

struct GradiantBackgroundCell_Previews: PreviewProvider {
    static var previews: some View {
        GradiantBackgroundCell(colors: [Color(.systemIndigo), Color(.systemPurple)])
    }
}
