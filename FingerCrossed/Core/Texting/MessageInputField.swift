//
//  MessageInputField.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct MessageInputField: View {
    
    var message: String = ""
    
    // for state control usage
    @State private var isFocused: Bool = false
    @State var inputBarWidth: CGFloat = 206
    @State var inputBarLineLimit: Int = 1
    
    var body: some View {
        HStack(
            alignment: self.isFocused ? .bottom : .center,
            spacing: 12
        ){
            if(self.isFocused){
                FocusButtonSection(
                    isFocused: $isFocused,
                    inputBarWidth: $inputBarWidth,
                    inputBarLineLimit: $inputBarLineLimit
                )
            } else {
                UnFocusButtonSection()
            }
            MessageInputBar(
                text: message,
                isFocused: $isFocused,
                inputBarWidth: $inputBarWidth,
                inputBarLineLimit: $inputBarLineLimit
            )
            .onTapGesture {
                self.isFocused = true
                self.inputBarWidth = self.isFocused ? 278 : 206
                self.inputBarLineLimit = self.isFocused ? 4 : 1
            }
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
        .background(Color.background)
    }
}

private struct MessageInputBar: View {
    
    @State var text = ""
    // control input layout
    @Binding var isFocused: Bool
    @Binding var inputBarWidth: CGFloat
    @Binding var inputBarLineLimit: Int
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            HStack(alignment: .bottom) {
                ZStack(alignment: .leading){
                    text.isEmpty
                    ? Text("Aa")
                            .font(.pMedium)
                            .foregroundColor(Color.textHelper)
                    : nil
                    TextField("", text: $text, axis: .vertical)
                        .textFieldStyle(.plain)
                        .font(.pMedium)
                        .foregroundColor(Color.text)
                        .frame(minHeight: 24)
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 4))
                        .lineLimit(self.inputBarLineLimit)
                        
                }
                HStack(alignment: .center){
                    IconButton(name: "Sent", action: {})
                }.frame(width: 24, height: 32)
            }
            .padding(.leading, 14)
            .padding(.trailing, 14)
            .padding(.vertical, 4)
            .background(Color.white)
            .cornerRadius(self.inputBarWidth == 206 ? 50 : 16)

        }
        .overlay(
              RoundedRectangle(cornerRadius: self.inputBarWidth == 206 ? 50 : 16)
                .stroke(Color.surface2, lineWidth: 1)
        )
        
    }
}

private struct UnFocusButtonSection: View {
    var body: some View {
        IconButton(name: "CameraBased", action: {})
        IconButton(name: "PictureBased", action: {})
        IconButton(name: "Mic", action: {})
    }
}

private struct FocusButtonSection: View {
    @Binding var isFocused: Bool
    @Binding var inputBarWidth: CGFloat
    @Binding var inputBarLineLimit: Int
    var body: some View {
        IconButton(name:"ArrowRightBased", action: {
            self.isFocused.toggle()
            self.inputBarWidth = self.isFocused ? 278 : 206
            self.inputBarLineLimit = self.isFocused ? 4 : 1
        })
        .padding(.vertical, 6)
    }
}

struct MessageInputField_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputField()
    }
}
