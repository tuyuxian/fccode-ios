//
//  Spinner.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/16/23.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
        LottieView(lottieFile: "spinner.json")
            .frame(width: 24, height: 24)
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
