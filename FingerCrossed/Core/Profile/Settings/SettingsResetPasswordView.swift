//
//  SettingsResetPasswordView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsResetPasswordView: View {
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Profile", childTitle: "Settings") {
            Box {
                VStack(alignment: .leading, spacing: 20.0) {
                    
                    VStack(alignment: .leading, spacing: 6.0){
                        Text("New Password")
                            .fontTemplate(.h3Medium)
                        .foregroundColor(.text)
                        PrimaryInputBar(isDisable: false, hasButton: true)
                    }
                    
                    VStack(alignment: .leading, spacing: 6.0) {
                        Text("Comfirm Password")
                            .fontTemplate(.h3Medium)
                        .foregroundColor(.text)
                        PrimaryInputBar(isDisable: false, hasButton: true)
                    }
            
                }
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                
                HStack {
                    VStack (alignment: .leading, spacing: 6.0){
                        InputHelper()
                        InputHelper(label: "At least one upper & one lowercase")
                        InputHelper(label: "At least one number & symbol")
                        InputHelper(label: "Match with password")
                    }
                    .padding(.horizontal, 24) //check position
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                
                
                Spacer()
                TabBar()
            }
        }
    }
    
    struct SettingsResetPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsResetPasswordView()
        }
    }
    
}
