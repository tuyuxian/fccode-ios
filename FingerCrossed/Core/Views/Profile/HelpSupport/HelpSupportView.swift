//
//  HelpSupportView.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/22/23.
//

import SwiftUI

struct HelpSupportView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Help & Support",
            showSaveButton: false
        ) {
            Box {
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {
                        Spacer()
                            .frame(height: 30)
                        
                        // Contact Us
                        ContactUs()
                        // Terms of Service
                        TermsOfService()
                        // Privacy
                        Privacy()
                        
                        Spacer()
                            .frame(height: 30)

                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 24)
            }
        }
    }
}

struct HelpSupportView_Previews: PreviewProvider {
    static var previews: some View {
        HelpSupportView(
            vm: ProfileViewModel()
        )
    }
}

// swiftlint: disable line_length
private struct ContactUs: View {
    var body: some View {
        Group {
            Text("Contact Us")
                .foregroundColor(Color.warning)
                .fontTemplate(.pSemibold)
            
            Text("If you have any questions or concerns about this privacy policy, please contact us via our email: ")
                .foregroundColor(Color.text)
                .fontTemplate(.noteMedium)
            
            Text(.init("[fingercrossed.work@gmail.com](mailto:fingercrossed.work@gmail.com)"))
                .accentColor(Color.text)
                .fontTemplate(.noteMedium)
                .underline()
            
            Spacer()
                .frame(height: 24)
        }
    }
}
// swiftlint: enable line_length
