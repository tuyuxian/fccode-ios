//
//  InputHelper.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct InputHelper: View {
    
    enum HelperType: Int {
        case info
        case error
    }
    
    /// Flag for helper
    /// Use .constant(false) for error type
    @Binding var isSatisfied: Bool
    /// Helper label
    @State var label: String
    /// Type of the helper
    @State var type: HelperType
    
    var body: some View {
        HStack(alignment: .top, spacing: 6.0) {
            switch type {
            case .info:
                Image("CheckCircle")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(isSatisfied ? Color.text : Color.surface1)
                Text(label)
                    .fontTemplate(.noteMedium)
                    .foregroundColor(isSatisfied ? Color.text : Color.surface1)
            case .error:
                Image("ErrorCircleRed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                Text(label)
                    .fontTemplate(.noteMedium)
                    .foregroundColor(Color.warning)
            }
        }
    }
}

struct InputHelper_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputHelper(
                isSatisfied: .constant(true),
                label: "Info",
                type: .info
            )
            InputHelper(
                isSatisfied: .constant(false),
                label: "Info",
                type: .info
            )
            InputHelper(
                isSatisfied: .constant(false),
                label: "Error",
                type: .error
            )
        }
    }
}
