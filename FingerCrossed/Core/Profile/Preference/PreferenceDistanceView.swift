//
//  PreferenceDistanceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceDistanceView: View {
    
    let distanceOptions:[String] = [
        "25 miles",
        "50 miles",
        "75 miles",
        "100 miles",
    ]
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Preference", childTitle: "Distance") {
            Box {
                VStack(spacing: 0) {
                    ForEach(Array(distanceOptions.enumerated()), id: \.element.self) { index, distance in
                        
                        RadioButtonRow(label: distance)
                        
                        index != distanceOptions.count - 1
                        ? Divider().foregroundColor(Color.surface2) // TODO(Sam): use surface3
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

struct PreferenceDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceDistanceView()
    }
}
