//
//  ViewLink.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/2/23.
//

import SwiftUI

struct ViewLink <TargetView: View>: View {
    var view: TargetView = ResetPasswordEmailCheckView() as! TargetView
    var label: String = "Forgot password"
    
    var body: some View {
        NavigationLink(destination: view
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    VStack(alignment: .center) {
                        NavigationBarBackButton()
                    }
                    .frame(height: 40)
                    .padding(.top, 24)
                    .padding(.leading, 14)
            ), label: {
            Text(label)
                .foregroundColor(Color.gold)
                .fontTemplate(.pMedium)
                .frame(maxWidth: .infinity)
        })
    }
}

struct ViewLink_Previews: PreviewProvider {
    static var previews: some View {
        ViewLink<ResetPasswordEmailCheckView>()
    }
}
