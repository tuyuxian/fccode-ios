//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct VoiceMessageEditSheet: View {
    @State private var isStatisfied: Bool = true
    
    @State private var isLoading: Bool = false
    
    @State var hasVoiceMessage: Bool = true
    // TODO(Lawrence): apply new design
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                Text("Voice Message")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .padding(.top, 30)
                Text("01:00")
                    .fontTemplate(.h3Bold)
                    .foregroundColor(Color.surface1)
                    .padding(.bottom, 50)
                
                if hasVoiceMessage {
                    HStack(
                        alignment: .center,
                        spacing: 16
                    ) {
                        Button {
                            
                        } label: {
                            Image("play")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 18, height: 18)
                                .background(
                                    Circle()
                                        .fill(Color.yellow100)
                                        .frame(width: 50, height: 50)
                                )
                        }
                        
                        VStack {
                            LottieView(lottieFile: "soundwave.json")
                                .frame(width: 233.05, height: 50)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 80, trailing: 24))
                } else {
                    LottieView(lottieFile: "soundwave.json")
                        .frame(width: 233.05, height: 50)
                        .padding(.bottom, 50)
                }
                
                if hasVoiceMessage {
                    PrimaryButton(
                        label: "Save",
                        isTappable: $isStatisfied,
                        isLoading: $isLoading
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                } else {
                    Button {
                        
                    } label: {
                        Image("Mic")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 38.4, height: 38.4)
                            .foregroundColor(Color.white)
                            .background(
                                Circle()
                                    .fill(Color.yellow100)
                                    .frame(width: 80, height: 80)
                            )
                    }
                    .padding(.bottom, 62)
                }
                
            }
            .background(Color.white)
            .presentationDetents([.height(402)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet()
    }
}
