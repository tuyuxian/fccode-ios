//
//  Shimmer.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/28/23.
//

import SwiftUI

struct Shimmer: View {
    
    @State var color: Color
    
    @State var show: Bool = false
    
    var center = (UIScreen.main.bounds.width / 2) + 110
    
    var body: some View {
        ZStack {
            color
            
            Color.surface2
                .mask(
                    Rectangle()
                        .fill(
                            // TODO(): adjust the color
                            LinearGradient(
                                gradient: .init(
                                    colors: [
                                        .clear,
                                        Color.surface2.opacity(0.48),
                                        .clear
                                    ]
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .offset(
                            x:
                                self.show
                                ? self.center
                                : -self.center
                        )
                )
        }
        .onAppear{
            withAnimation(
                .default
                    .speed(0.25)
                    .delay(0)
                    .repeatForever(autoreverses: false)
            ) {
                self.show.toggle()
            }
        }
    }
}

struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        Shimmer(color: Color.surface1)
    }
}
