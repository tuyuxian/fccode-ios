//
//  HelpSupportView.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/22/23.
//

import SwiftUI

struct HelpSupportView: View {
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Help & Support",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {
                        Spacer()
                            .frame(height: 30)
                        
                        ContactUs()
                        
                        TermsOfService()

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
        HelpSupportView()
    }
}

// swiftlint: disable line_length
private struct ContactUs: View {
    var body: some View {
        Group {
            Text("Contact Us")
                .foregroundColor(Color.text)
                .fontTemplate(.h3Bold)
            
            Text("If you have any questions or concerns about this privacy policy, please contact us via our email: ")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Text(.init("[fingercrossed.work@gmail.com](mailto:fingercrossed.work@gmail.com)"))
                .accentColor(Color.text)
                .fontTemplate(.pRegular)
                .underline()
            
            Spacer()
                .frame(height: 24)
        }
    }
}
// swiftlint: enable line_length
