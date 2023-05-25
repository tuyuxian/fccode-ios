//
//  ContentView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/22/23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            Image("LandingBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 12) {
                VStack(spacing: -5.04) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: 180,
                            height: 180
                        )
                    Image("FCHorizontal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: 220,
                            height: 35.04
                        )
                }
                .frame(width: 220)
                Text("Where you can find perfect match with a little bit of luck")
                    .fontTemplate(.h4Medium)
                    .foregroundColor(Color.surface1)
                    .multilineTextAlignment(.center)
                    .frame(width: 220)
                    .kerning(-0.4)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
