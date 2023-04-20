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
            Image("BG")
            VStack(spacing: 6.0) {
                Image("EntryLogo") // TODO(Lawrence): image resolution
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 199, height: 145)
                Text("Finger Crossed")
                    .fontTemplate(.h1Medium)
                Text("Where you can find perfect match with a little bit of luck.")
                    .fontTemplate(.pMedium)
                    .foregroundColor(.description)
                    .frame(width: 223)
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
