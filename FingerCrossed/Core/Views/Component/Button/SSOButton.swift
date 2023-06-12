//
//  SSOButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI

struct SSOButton: View {

    enum Platform: Int {
        case apple
        case facebook
        case google
    }
    // Platform type
    @State var platform: Platform
    // Callback handler of SSO button
    @State var handler: () -> Void
    
    var body: some View {
        Button {
            handler()
        } label: {
            switch platform {
            case .apple:
                Circle()
                    .fill(Color.text)
                    .frame(width: 52, height: 52)
                    .overlay(
                        FCIcon.apple
                            .resizable()
                            .frame(width: 30, height: 30)
                    )
            case .facebook:
                Circle()
                    .fill(Color.facebook)
                    .frame(width: 52, height: 52)
                    .overlay(
                        FCIcon.facebook
                            .resizable()
                            .frame(width: 30, height: 30)
                    )
            case .google:
                Circle()
                    .fill(Color.white)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Circle()
                            .stroke(Color.textHelper, lineWidth: 1)
                    )
                    .overlay(
                        FCIcon.google
                            .resizable()
                            .frame(width: 30, height: 30)
                    )
            }
        }
    }
}

struct SSOButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SSOButton(platform: .apple, handler: {})
            SSOButton(platform: .facebook, handler: {})
            SSOButton(platform: .google, handler: {})
        }
    }
}
