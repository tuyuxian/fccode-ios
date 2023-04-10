//
//  ViewLink.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/2/23.
//

import SwiftUI

struct ViewLink <targetView: View>: View {
    var view: targetView = ResetPasswordEmailCheckView() as! targetView
    var label: String = "Forgot password"
    
    var body: some View {
        NavigationLink(destination: view, label: {
            Text(label)
                .foregroundColor(Color.orange100)
                .font(.pMedium)
                .frame(maxWidth: .infinity)
        })
    }
}

struct ViewLink_Previews: PreviewProvider {
    static var previews: some View {
        ViewLink<ResetPasswordEmailCheckView>()
    }
}
