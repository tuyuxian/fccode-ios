//
//  BasicInfoBirthdayView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoBirthdayView: View {
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Birthday") {
            Box {
                // TODO(Sam): Date Picker
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
