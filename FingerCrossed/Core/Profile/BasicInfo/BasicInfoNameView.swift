//
//  BasicInfoNameView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoNameView: View {
    
    @State var name: String = "Test"
<<<<<<< HEAD
    @State var remainCharacters: Int = 24
    @State var isQualified = false
=======
>>>>>>> release
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Name") {
            Box {
                VStack(alignment: .trailing, spacing: 6.0) {
                    // input bar
<<<<<<< HEAD
                    PrimaryInputBar(value: $name, isDisable: false, hasButton: false, isQualified: $isQualified) // TODO(Sam): replace the hint with name
                    // characters remain
                    Text("\(30 - remainCharacters)/30")
=======
                    PrimaryInputBar(isDisable: false, hasButton: false) // TODO(Sam): replace the hint with name

                    Text("\(name.count)/30")
>>>>>>> release
                        .fontTemplate(.captionRegular)
                        .foregroundColor(Color.textHelper)
                }
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                
                Spacer()
            }
        }
    }
}

struct BasicInfoNameView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoNameView()
    }
}
