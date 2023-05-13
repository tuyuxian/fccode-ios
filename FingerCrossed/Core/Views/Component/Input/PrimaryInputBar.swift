//
//  PrimaryInputBar.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 4/8/23.
//

import SwiftUI

struct PrimaryInputBar: View {
    
    enum Input: Int {
        case email
        case password
        case text
    }
    @State var input: Input
    @Binding var value: String
    @State var hint: String = ""
    @State var isError: Bool = false
    @State var isDisable: Bool = false
    @State var isPasswordVisible: Bool = false
    @FocusState var isFocus: Bool
    @State var action: () -> Void = {}
    
    var body: some View {
        HStack {
            Group {
                switch input {
                case .email:
                    TextField(
                        "",
                        text: $value,
                        prompt: Text(hint)
                                .font(Font.system(size: 16, weight: .regular))
                                .foregroundColor(isDisable ? Color.surface1 : Color.textHelper)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                case .password:
                    SecureField(
                        "",
                        text: $value,
                        prompt: Text(hint)
                                .font(Font.system(size: 16, weight: .regular))
                                .foregroundColor(isDisable ? Color.surface1 : Color.textHelper)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                case .text:
                    TextField(
                        "",
                        text: $value,
                        prompt: Text(hint)
                                .font(Font.system(size: 16, weight: .regular))
                                .foregroundColor(isDisable ? Color.surface1 : Color.textHelper)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                }
            }
            .fontTemplate(.pRegular)
            .foregroundColor(isDisable ? Color.surface1 : Color.text)
            .disabled(isDisable)
            .focused($isFocus)
            
            switch input {
            case .email:
                Button {
                    action()
                } label: {
                    Image("ArrowRightCircleBased")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(value.isEmpty ? Color.surface1 : Color.text)
                        .frame(width: 24, height: 24)
                }
                .disabled(value.isEmpty)
            case .password:
                Button {
                    withAnimation(
                        .easeInOut(duration: 0.1)
                    ) {
                        self.isPasswordVisible.toggle()
                    }
                } label: {
                    Image(self.isPasswordVisible ? "EyeShow" : "EyeClose")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            case .text:
                EmptyView()
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder(
                    isError ? Color.warning : Color.surface2,
                    lineWidth: 1
                )
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(isDisable ? Color.surface2 : Color.white)
                )
        )
    }
}

struct PrimaryInputBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryInputBar(
                input: .email,
                value: .constant("Value")
            )
            PrimaryInputBar(
                input: .password,
                value: .constant("Value")
            )
            PrimaryInputBar(
                input: .text,
                value: .constant("Value"),
                isDisable: true
            )
            PrimaryInputBar(
                input: .text,
                value: .constant("Value"),
                isError: true
            )
        }
        .padding(.horizontal, 24)
    }
}
