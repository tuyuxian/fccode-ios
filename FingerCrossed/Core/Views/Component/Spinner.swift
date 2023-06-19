//
//  Spinner.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/16/23.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
        LottieView(
            lottieFile: "spinner.json"
        )
        .frame(
            width: 24,
            height: 24
        )
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.yellow100)
                .frame(width: 200, height: 50)
            Spinner()
        }
    }
}
