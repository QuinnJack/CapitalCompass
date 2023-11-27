import Foundation
import SwiftUI

extension LinearGradient {
    static let gradientWalk = LinearGradient(
        colors: [
            Color(red: 0.56, green: 0.00, blue: 0.10),
            Color(red: 0.90, green: 0.22, blue: 0.32),
            Color(red: 0.90, green: 0.22, blue: 0.32)
        ],
        startPoint: .leading, endPoint: .trailing)
    
    static let gradientDrive = LinearGradient(
        colors: [.blue, .green],
        startPoint: .leading, endPoint: .trailing)
}

extension RadialGradient {
    static let gradientDoneSteps = RadialGradient(
        colors: [
            Color(red: 0.56, green: 0.00, blue: 0.10),
            Color(red: 0.90, green: 0.22, blue: 0.32),
            Color(red: 0.90, green: 0.22, blue: 0.32)
        ],
        center: .center, startRadius: 0, endRadius: 64)
    
    static let gradientWaitedSteps = RadialGradient(
        colors: [
            .gray,
            Color(red: 0.7, green: 0.7, blue: 0.7)
            ],
        center: .center,startRadius: 0,endRadius: 64)
}
extension StrokeStyle {
    static let strokeWalk = StrokeStyle(
        lineWidth: 5,
        lineCap: .round, lineJoin: .bevel, dash: [10, 10])
}
