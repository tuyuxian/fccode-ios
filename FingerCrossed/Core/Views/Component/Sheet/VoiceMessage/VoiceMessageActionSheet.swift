//
//  VoiceMessageActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI
import AVFoundation

struct VoiceMessageActionSheet: View {
        
    @State var showEditModal: Bool = false
    
    @State var showAlert: Bool = false
        
    let alertTitle: String = "Allow microphone access in device settings"
    // swiftlint: disable line_length
    let alertMessage: String = "Finger Crossed uses your device's microphone so that you can record voice message."
    // swiftlint: enable line_length
    
    private func checkAudioPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { allowed in
            if !allowed {
                showAlert.toggle()
            }
            showEditModal = true
        }
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
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
                    checkAudioPermission()
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
                .sheet(isPresented: $showEditModal) {
                    VoiceMessageEditSheet()
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)
            .background(Color.white)
            .presentationDetents([.height(138)])
            .presentationDragIndicator(.visible)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title:
                    Text(alertTitle)
                        .font(Font.system(size: 18, weight: .medium)),
                message:
                    Text(alertMessage)
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
