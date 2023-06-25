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
    
    @Binding var isValid: Bool
    
    @State var isDisable: Bool = false
    
    @State var isSecureMode: Bool = true
    
    @FocusState var isFocus: Bool
    
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
                                .foregroundColor(
                                    isValid
                                    ? isDisable
                                        ? Color.surface1
                                        : Color.textHelper
                                    : Color.warning
                                )
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                case .password:
                    if isSecureMode {
                        SecureField(
                            "",
                            text: $value,
                            prompt: Text(hint)
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(
                                        isValid
                                        ? isDisable
                                            ? Color.surface1
                                            : Color.textHelper
                                        : Color.warning
                                    )
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    } else {
                        TextField(
                            "",
                            text: $value,
                            prompt: Text(hint)
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(
                                        isValid
                                        ? isDisable
                                            ? Color.surface1
                                            : Color.textHelper
                                        : Color.warning
                                    )
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                    }
                case .text:
                    TextField(
                        "",
                        text: $value,
                        prompt: Text(hint)
                                .font(Font.system(size: 16, weight: .regular))
                                .foregroundColor(
                                    isValid
                                    ? isDisable
                                        ? Color.surface1
                                        : Color.textHelper
                                    : Color.warning
                                )
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                }
            }
            .fontTemplate(.pRegular)
            .foregroundColor(isDisable ? Color.surface1 : Color.text)
            .disabled(isDisable)
            .focused($isFocus)
            .onTapGesture {
                isFocus = true
            }

            switch input {
            case .email:
                EmptyView()
            case .password:
                // swiftlint: disable void_function_in_ternary
                isSecureMode
                ? FCIcon.eyeClose
                    .onTapGesture {
                        isSecureMode.toggle()
                    }
                : FCIcon.eyeOpen
                    .onTapGesture {
                        isSecureMode.toggle()
                    }
                // swiftlint: enable void_function_in_ternary
            case .text:
                EmptyView()
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder(
                    isValid ? Color.surface2 : Color.warning,
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
                value: .constant("Value"),
                isValid: .constant(true)
            )
            PrimaryInputBar(
                input: .password,
                value: .constant("Value"),
                isValid: .constant(true)
            )
            PrimaryInputBar(
                input: .text,
                value: .constant("Value"),
                isValid: .constant(true),
                isDisable: true
            )
            PrimaryInputBar(
                input: .text,
                value: .constant(""),
                hint: "hint",
                isValid: .constant(false)
            )
        }
        .padding(.horizontal, 24)
    }
}
