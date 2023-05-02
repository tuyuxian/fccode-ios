//
//  Logo.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/1/23.
//

import SwiftUI

struct Logo: Shape {
    func path(in rect: CGRect) -> Path {
        var path1 = Path()
        var path2 = Path()
        var path3 = Path()
        let width = rect.size.width
        let height = rect.size.height
        path1.move(to: CGPoint(x: 0.73781*width, y: 0.77385*height))
        path1.addCurve(to: CGPoint(x: 0.63043*width, y: 0.5004*height), control1: CGPoint(x: 0.67763*width, y: 0.669*height), control2: CGPoint(x: 0.64671*width, y: 0.56392*height))
        path1.addCurve(to: CGPoint(x: 0.62405*width, y: 0.21776*height), control1: CGPoint(x: 0.58602*width, y: 0.32713*height), control2: CGPoint(x: 0.60319*width, y: 0.2678*height))
        path1.addCurve(to: CGPoint(x: 0.87655*width, y: 0.19957*height), control1: CGPoint(x: 0.65025*width, y: 0.15497*height), control2: CGPoint(x: 0.75996*width, y: 0.07943*height))
        path1.addCurve(to: CGPoint(x: 0.96872*width, y: 0.45444*height), control1: CGPoint(x: 0.9699*width, y: 0.29575*height), control2: CGPoint(x: 0.96898*width, y: 0.42692*height))
        path1.addCurve(to: CGPoint(x: 0.82901*width, y: 0.75648*height), control1: CGPoint(x: 0.96787*width, y: 0.5364*height), control2: CGPoint(x: 0.92553*width, y: 0.67973*height))
        path1.addCurve(to: CGPoint(x: 0.73781*width, y: 0.77382*height), control1: CGPoint(x: 0.75406*width, y: 0.81607*height), control2: CGPoint(x: 0.73781*width, y: 0.77382*height))
        path1.addLine(to: CGPoint(x: 0.73781*width, y: 0.77385*height))
        path1.closeSubpath()
        path2.move(to: CGPoint(x: 0.65522*width, y: 0.81758*height))
        path2.addCurve(to: CGPoint(x: 0.53936*width, y: 0.44437*height), control1: CGPoint(x: 0.63053*width, y: 0.65875*height), control2: CGPoint(x: 0.57526*width, y: 0.52387*height))
        path2.addCurve(to: CGPoint(x: 0.31078*width, y: 0.14516*height), control1: CGPoint(x: 0.44134*width, y: 0.22745*height), control2: CGPoint(x: 0.37412*width, y: 0.17995*height))
        path2.addCurve(to: CGPoint(x: 0.03303*width, y: 0.33514*height), control1: CGPoint(x: 0.23125*width, y: 0.10151*height), control2: CGPoint(x: 0.05433*width, y: 0.11374*height))
        path2.addCurve(to: CGPoint(x: 0.1493*width, y: 0.67642*height), control1: CGPoint(x: 0.01601*width, y: 0.51241*height), control2: CGPoint(x: 0.12608*width, y: 0.64802*height))
        path2.addCurve(to: CGPoint(x: 0.54592*width, y: 0.875*height), control1: CGPoint(x: 0.21839*width, y: 0.76096*height), control2: CGPoint(x: 0.38171*width, y: 0.875*height))
        path2.addCurve(to: CGPoint(x: 0.65522*width, y: 0.81758*height), control1: CGPoint(x: 0.67346*width, y: 0.875*height), control2: CGPoint(x: 0.65522*width, y: 0.81758*height))
        path2.closeSubpath()
        path3.move(to: CGPoint(x: 0.46891*width, y: 0.38986*height))
        path3.addCurve(to: CGPoint(x: 0.3264*width, y: 0.4295*height), control1: CGPoint(x: 0.45894*width, y: 0.44324*height), control2: CGPoint(x: 0.37779*width, y: 0.44405*height))
        path3.addCurve(to: CGPoint(x: 0.13677*width, y: 0.23424*height), control1: CGPoint(x: 0.24593*width, y: 0.40671*height), control2: CGPoint(x: 0.14075*width, y: 0.31856*height))
        path3.addCurve(to: CGPoint(x: 0.24566*width, y: 0.12506*height), control1: CGPoint(x: 0.13374*width, y: 0.16975*height), control2: CGPoint(x: 0.19071*width, y: 0.12429*height))
        path3.addCurve(to: CGPoint(x: 0.46891*width, y: 0.3899*height), control1: CGPoint(x: 0.35596*width, y: 0.12655*height), control2: CGPoint(x: 0.48301*width, y: 0.31435*height))
        path3.addLine(to: CGPoint(x: 0.46891*width, y: 0.38986*height))
        path3.closeSubpath()
        return path1
    }
}
