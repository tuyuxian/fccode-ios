//
//  CustomAlertButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/19/23.
//

import SwiftUI

struct CustomAlertButton: View {
    @State var title: LocalizedStringKey
    @State var textColor: Color = Color.systemBlue
    @State var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .fontTemplate(.h3Medium)
                .foregroundColor(textColor)
                .frame(minWidth: 110, minHeight: 24)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)

    }
}

struct CustomAlertButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertButton(title: "OK")
    }
}
