//
//  BasicInfoNameView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoNameView: View {
    
    @State var name: String = "Test"
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Name") {
            Box {
                VStack(alignment: .trailing, spacing: 6.0) {
                    // input bar
                    PrimaryInputBar(
                        value: $name,
                        isDisable: false,
                        hasButton: false,
                        isQualified: .constant(false)
                    )

                    Text("\(name.count)/30")
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
