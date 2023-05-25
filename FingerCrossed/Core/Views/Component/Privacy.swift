//
//  Privacy.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/23/23.
//

import SwiftUI
// swiftlint: disable line_length
struct Privacy: View {
    var body: some View {
        Group {
            Text("Privacy")
                .foregroundColor(Color.text)
                .fontTemplate(.h3Bold)
            
            Text("Welcome to Fingercrossed Privacy Policy!")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 16)
            // Introduction
            Group {
                Text("Introduction")
                    .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
                
                Text("We respect the privacy of our users and are committed to protecting their personal information. This privacy policy explains how we collect, use, and disclose user data when you use our dating app. By using our app, you agree to the terms of this privacy policy.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Spacer()
                    .frame(height: 32)
            }
           
            Group {
                // Information We Collect
                InformationWeCollect()
                // Use of Information
                UseOfInformation()
                // Sharing of Information
                SharingOfInformation()
                // Data Security
                DataSecurity()
                // User Control
                UserControl()
                // Children's Privacy
                ChildrensPrivacy()
                // Changes to Privacy Policy
                ChangesToPrivacyPolicy()
            }
        }
    }
}

struct Privacy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy()
    }
}

private struct InformationWeCollect: View {
    var body: some View {
        Group {
            Text("Information We Collect")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We collect various types of information from our users, including:")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("User-provided information: When you create a user account, you provide us with certain personal information, such as your name, email address, gender, and date of birth.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("User-generated content: You may upload photos, videos, or other content to your user profile or in messages to other users.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Usage information: We collect information about how you use our app, such as your search queries, messages, and interactions with other users.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Device information: We may collect information about the device you use to access our app, such as your device type, operating system, and IP address.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Location information: We may collect your location information through your device or IP address, but only with your consent..")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct UseOfInformation: View {
    var body: some View {
        Group {
            Text("Use of Information")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We use the information we collect for various purposes, including:")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Providing and improving our app: We use user information to provide and personalize our app, and to improve our app's features and functionality.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Communication with users: We may use user information to communicate with you about your account, our app, or related services.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Research and analytics: We use user data for research and analytics purposes, such as analyzing user behavior and trends.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Advertising and marketing: We may use user data to serve relevant ads and promotions, and to promote our app or related services.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct SharingOfInformation: View {
    var body: some View {
        Group {
            Text("Sharing of Information")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We do not sell, rent, or share user information with third parties for their own marketing purposes. However, we may share user data with our affiliates, partners, or service providers for the following purposes:")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Providing and improving our app: We may share user data with third-party service providers who assist us in providing and improving our app.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Legal purposes: We may disclose user data if required by law, or if we believe such disclosure is necessary to protect our rights, property, or safety, or that of our users or others.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Business purposes: We may disclose user data in connection with a merger, acquisition, or other business transaction.hts, property, or safety, or that of our users or others.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct UserControl: View {
    var body: some View {
        Group {
            Text("User Control")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("You have certain rights and controls over your personal information, including:")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Access and update: You can access and update your personal information through your user account settings.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Deletion: You can delete your user account and personal information at any time.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            HStack(alignment: .top, spacing: 2) {
                Text(" • ")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
                
                Text("Opt-out: You can opt-out of certain types of communications or data processing, such as marketing emails or location tracking.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pRegular)
            }
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct ChangesToPrivacyPolicy: View {
    var body: some View {
        Group {
            Text("Changes to Privacy Policy")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We may modify or update this privacy policy at any time, without prior notice. Your continued use of our app after any such changes constitutes your acceptance of the revised privacy policy.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct ChildrensPrivacy: View {
    var body: some View {
        Group {
            Text("Children's Privacy")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("Our app is not intended for children under the age of 18, and we do not knowingly collect personal information from children under 18. If we become aware that we have collected personal information from a child under 18, we will take steps to delete the information as soon as possible.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct DataSecurity: View {
    var body: some View {
        Group {
            Text("Data Security")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We take reasonable measures to protect user data from unauthorized access, disclosure, alteration, or destruction. However, we cannot guarantee the security of user data, and you acknowledge that any transmission or storage of data is at your own rik.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}
// swiftlint: enable line_length
