//
//  PageSpinner.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/2/23.
//

import SwiftUI

final class PageSpinnerManager: ObservableObject {
    
    @Published var isPresented: Bool = false
    
    public func dismiss() {
        if isPresented {
            isPresented = false
        }
    }
    
    public func show() {
        if !isPresented {
            isPresented = true
        }
    }
}

struct PageSpinner: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
                .opacity(0.6)
            LottieView(lottieFile: "loading.json")
                .frame(width: 110, height: 110)
        }
    }
}

struct PageSpinner_Previews: PreviewProvider {
    static var previews: some View {
        PageSpinner()
    }
}
