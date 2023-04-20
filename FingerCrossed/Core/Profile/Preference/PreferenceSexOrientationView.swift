//
//  PreferenceSexOrientationView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceSexOrientationView: View {
    
    let sexOrientationOptions:[String] = [
        "Heterosexuality",
        "Bisexuality",
        "Homosexuality",
        "All",
    ]
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Preference", childTitle: "Sex Orientation") {
            Box {
                VStack(spacing: 0) {
                    ForEach(Array(sexOrientationOptions.enumerated()), id: \.element.self) { index, sexOrientation in
                        
                        CheckboxButtonRow(label: sexOrientation)
                        
                        index != sexOrientationOptions.count - 1
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

struct PreferenceSexOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceSexOrientationView()
    }
}
