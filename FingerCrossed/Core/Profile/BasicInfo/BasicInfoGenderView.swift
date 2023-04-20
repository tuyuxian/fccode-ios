//
//  BasicInfoGenderView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoGenderView: View {
    
    let genderOptions:[String] = [
        "Male",
        "Female",
        "Transgender",
        "Nonbinary",
        "Prefer not to say",
    ]
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Gender") {
            Box {
                VStack(spacing: 0) {
                    ForEach(Array(genderOptions.enumerated()), id: \.element.self) { index, gender in
                        
                        RadioButtonRow(label: gender)
                        
                        index != genderOptions.count - 1
                        ? Divider().foregroundColor(Color.surface3)
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        : nil
                        
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
        }
    }
}

struct BasicInfoGenderView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoGenderView()
    }
}
