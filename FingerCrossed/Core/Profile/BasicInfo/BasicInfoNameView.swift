//
//  BasicInfoNameView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoNameView: View {
    
    @State var name: String = "Test"
    @State var remainCharacters: Int = 24
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Name") {
            Box {
                VStack(alignment: .trailing, spacing: 6.0) {
                    // input bar
                    PrimaryInputBar(isDisable: false, hasButton: false) // TODO(Sam): replace the hint with name
                    // characters remain
                    Text("\(30 - remainCharacters)/30")
                        .font(.captionRegular)
                        .foregroundColor(Color.textHelper)
                }
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                
                Spacer()
                TabBar()
            }
        }
    }
}

struct BasicInfoNameView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoNameView()
    }
}
