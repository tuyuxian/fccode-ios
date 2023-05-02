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
            
            VStack(spacing: 12.96) {
                VStack (spacing: -6.0){
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)// TODO(Lawrence): image resolution
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 22))
                    
                    Image("FCHorizontal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 220, height: 35.04)
                }
                .frame(width: 220)
                
                
                
                Text("Where you can find perfect match with a little bit of luck.")
                    .fontTemplate(.noteMedium)
                    .foregroundColor(Color.surface1)
                    .frame(width: 220)
                    .multilineTextAlignment(.center)

                }
            }
            
        }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
