//
//  VoiceMessageActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI
import AVFoundation

struct VoiceMessageActionSheet: View {
        
    @State var showEditSheet: Bool = false
    
    @State var showAlert: Bool = false
    
    @State var hasVoiceMessage: Bool = false
        
    let audioPermissionManager = AudioPermissionManager()
    
    private func buttonOnTap() {
        switch audioPermissionManager.permissionStatus {
        case .notDetermined:
            audioPermissionManager.requestPermission { granted, _ in
                guard granted else { return }
                showEditSheet = true
            }
        case .denied:
            showAlert.toggle()
        default:
            showEditSheet = true
        }
    }
    
    var body: some View {
        Sheet(
            size: [.height(138)],
            hasHeader: false,
            hasFooter: false,
            content: {
                VStack(
                    alignment: .leading,
                    spacing: 30
                ) {
                    Button {
                        // TODO(Sam): add delete method
                    } label: {
                        HStack(spacing: 20) {
                            Image("Trash")
                                .resizable()
                                .frame(width: 24, height: 24)

                            Text("Delete")
                                .fontTemplate(.h3Medium)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    
                    Button {
                        buttonOnTap()
                    } label: {
                        HStack(spacing: 20) {
                            Image("Edit")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Edit Voice Message")
                                .fontTemplate(.h3Medium)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showEditSheet) {
                        VoiceMessageEditSheet()
                    }
                }
                .padding(.top, 15) // 30 - 15
            },
            footer: {}
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title:
                    Text(audioPermissionManager.alertTitle)
                        .font(Font.system(size: 18, weight: .medium)),
                message:
                    Text(audioPermissionManager.alertMessage)
                        .font(Font.system(size: 12, weight: .medium)),
                primaryButton: .default(Text("Cancel")),
                secondaryButton: .default(
                    Text("Settings"),
                    action: {
                        UIApplication.shared.open(
                            URL(string: UIApplication.openSettingsURLString)!
                        )
                    }
                )
            )
        }
    }
}

struct VoiceMessageActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageActionSheet()
    }
}
