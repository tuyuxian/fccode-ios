//
//  PreferenceEthnicityView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceEthnicityView: View {
    
    @State var userEthnicity = [Ethnicity]()
    let ethnicityOptions:[String] = [
        "Open to all",
        "Asian",
        "Black/African-descent",
        "Hispanic/Latino",
        "Native American",
        "Pacifci Islander",
        "South Asian",
        "White/Caucasian",
    ]

    var body: some View {
        ContainerWithHeaderView(parentTitle: "Preference", childTitle: "Ethnicity") {
            Box {
                VStack(spacing: 0) {
                    ForEach(Array(ethnicityOptions.enumerated()), id: \.element.self) { index, ethnicity in
                        HStack {
                            CheckboxButton(label: ethnicity) // TODO(Sam): add click state
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                       
                        
                        index != ethnicityOptions.count - 1
                        ? Divider().foregroundColor(Color.surface2) // TODO(Sam): use surface3
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        : nil
                        
                    }
                }
                
//                CheckBoxEthnicityGroup(hasDivider: true, ethnicityList: $userEthnicity) { selected in
//                    print("\(selected)")
//                    print("Ethnicity: \(userEthnicity.count)")
//                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
        }
    }
}

struct PreferenceEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceEthnicityView()
    }
}
