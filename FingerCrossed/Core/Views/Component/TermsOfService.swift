//
//  TermsOfService.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/23/23.
//

import SwiftUI
// swiftlint: disable line_length
struct TermsOfService: View {
    var body: some View {
        Group {
            Text("Terms of Service")
                .foregroundColor(Color.text)
                .fontTemplate(.h3Bold)
            
            Text("Welcome to Finger Crossed Dating App! The app is provided and operated by Finger Crossed Team. By clicking yes to the checkbox, you are agreeing to comply with and be bound by the following terms and conditions of use agreement, including our Privacy Policy.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
            
            Group {
                // Eligibility
                Eligibility()
                
                // User Content and Profiles
                UserContentAndProfiles()
                
                // User Conduct
                UserConduct()
                
                // Safety
                Safety()
                
                // Reporting and Blocking
                ReportingAndBlocking()
                
                // Intellectual Property
                IntellectualProperty()
                
                // Limitation of Liability
                LimitationOfLiability()
                
                // Termination
                Termination()
                
                // Chandes to Terms and Conditions
                ChandesToTermsAndConditions()
            }
        }
    }
}

struct TermsOfService_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfService()
    }
}

private struct Eligibility: View {
    var body: some View {
        Group {
            Text("Eligibility")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("You must be at least 18 years of age to use our app. By using our app, you represent and warrant that you are at least 18 years old.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct UserContentAndProfiles: View {
    var body: some View {
        Group {
            Text("User Content and Profiles")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("You are responsible for creating and maintaining your user profile and all content submitted by you or through your account. You agree to provide accurate and complete information in your profile, and to promptly update any information that may have changed.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 16)
            
            Text("You are solely responsible for the content you post or transmit through our app, and you acknowledge that we have no obligation to monitor or control such content. However, we reserve the right to remove or edit any content that violates our policies or is deemed inappropriate, offensive, or illegal.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct UserConduct: View {
    var body: some View {
        Group {
            Text("User Coduct")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("By using our app, you agree to comply with all applicable laws and regulations. You may not use our app for any illegal or unauthorized purpose, including but not limited to violating intellectual property rights, harassment, or spreading viruses or malware, etc.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 16)
            
            Text("You agree to treat other users with respect and courtesy, and not to engage in any behavior that may be considered offensive or threatening. You acknowledge that we are not responsible for any interactions or relationships between users, and that any communication or contact between users is at their own risk.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct Safety: View {
    var body: some View {
        Group {
            Text("Safety")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We take the safety of our users seriously and provide various features and resources to promote safe and responsible behavior. However, we cannot guarantee the safety of our users, and you acknowledge that any communication or interaction between users is at your own risk.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 16)
            
            Text("Fingercrossed is not responsible for the conduct of any member on or off of the Service. You agree to use caution in all interactions with other members.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct ReportingAndBlocking: View {
    var body: some View {
        Group {
            Text("Reporting and Blocking")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("If you encounter any behavior that violates our policies or makes you feel uncomfortable or unsafe, you should report it to us immediately by sending an email to ")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Text(.init("[fingercrossed.work@gmail.com](mailto:fingercrossed.work@gmail.com)"))
                .accentColor(Color.text)
                .fontTemplate(.pRegular)
                .underline()
            
            Spacer()
                .frame(height: 16)
            
            Text("We reserve the right to investigate any reported behavior and take appropriate action, including but not limited to suspending or terminating user accounts. We reserve the right to suspend or terminate user accounts that have been reported if a case is found out to be valid.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 16)
            
            Text("We respect the privacy of our users and collect, store, and use personal data in accordance with our Privacy Policy. By using our app, you agree to the terms of our Privacy Policy.\n")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Text("For more detailed information, please check out our")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Text(.init("[Privacy Policy](https://docs.google.com/document/d/108EumZe9hkL9r3eixZt1FQaca1u_TQALirWta9sK8hE/edit?usp=sharing)"))
                .accentColor(Color.text)
                .fontTemplate(.pRegular)
                .underline()
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct IntellectualProperty: View {
    var body: some View {
        Group {
            Text("Intellectual Property")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("Our app and all content and features are owned by us or our licensors and are protected by copyright, trademark, and other intellectual property laws. You may not reproduce, distribute, or modify any content from our app without our prior written consent.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct LimitationOfLiability: View {
    var body: some View {
        Group {
            Text("Limitation of Liability")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("To the extent permitted by law, we disclaim all warranties and liability for any damages arising from your use of our app, including but not limited to direct, indirect, incidental, or consequential damages. In no event shall our liability exceed the total amount paid by you, if any, for use of our app.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct Termination: View {
    var body: some View {
        Group {
            Text("Termination")
                .foregroundColor(Color.text)
                .fontTemplate(.pSemibold)
            
            Text("We reserve the right to suspend or terminate your user account and access to our app at any time, with or without cause or notice.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}

private struct ChandesToTermsAndConditions: View {
    var body: some View {
        Group {
            Text("Changes to Terms and Conditions")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Text("We may modify or update these terms and conditions at any time, without prior notice. Your continued use of our app after any such changes constitutes your acceptance of the revised terms and conditions.")
                .foregroundColor(Color.text)
                .fontTemplate(.pRegular)
            
            Spacer()
                .frame(height: 32)
        }
    }
}
// swiftlint: enable line_length
