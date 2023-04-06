//
//  PrimaryInputBar.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct PrimaryInputBar: View {
    @State private var emailAccount: String = ""
    var hint: String = "Log in or sign up with email"
    var iconName: String = "ArrowDownCircleBased"
    var isDisable: Bool
    var hasButton: Bool
    
    var body: some View {
        HStack {
            TextField("" , text: $emailAccount, prompt: Text(hint)
                .foregroundColor(isDisable ? Color.surface1 : Color.textHelper))
                .font(.pRegular)
                .foregroundColor(Color.text)
                .frame(height: 56)
            
            if hasButton {
                Button {
                    print("hasButton")
                } label: {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                        .rotationEffect(.degrees(-90)) //TODO(Lawrence): new icon replacement
                }
            }else {
                Button {
                    print("hasNoButton")
                } label: {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 0)
                }
            }
            
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.surface2, lineWidth: 1)
                .background(
                    VStack {
                        if isDisable {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.surface2)
                        } else {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.white)
                        }
                    }
                )
        )
    }
}

struct PrimaryInputBar_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryInputBar(isDisable: false, hasButton: true)
    }
}
