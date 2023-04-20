//
//  BasicInfoBirthdayView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoBirthdayView: View {
    
    @State var birthday: String = "04/08/2023"
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Birthday") {
            Box {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(birthday)
                            .fontTemplate(.pRegular)
                            .foregroundColor(Color.surface1)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                        Spacer()
                        IconButton(name: "ArrowDownBased", action: {})
                            .padding(.trailing, 16)
                    }
                    .background(Color.surface2)
                    .cornerRadius(50)
                    
                }
                .overlay(
                      RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.surface2, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))

                Spacer()
            }
        }
    }
}

struct BasicInfoBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoBirthdayView()
    }
}
