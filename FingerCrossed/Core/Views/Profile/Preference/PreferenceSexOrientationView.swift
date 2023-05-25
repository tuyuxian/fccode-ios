//
//  PreferenceSexOrientationView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceSexOrientationView: View {
    /// Observed Profile view model
    @ObservedObject var vm: ProfileViewModel
    
    let sexOrientationOptions: [String] = [
        "Open to all",
        "Heterosexuality",
        "Bisexuality",
        "Homosexuality"
    ]
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Sex Orientation",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(items: sexOrientationOptions) { list in
                        vm.sexOrientation.removeAll()
                        for item in list {
                            vm.sexOrientation.append(item)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    
                    Spacer()
                }
            }
        }
    }
}

struct PreferenceSexOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceSexOrientationView(vm: ProfileViewModel())
    }
}
