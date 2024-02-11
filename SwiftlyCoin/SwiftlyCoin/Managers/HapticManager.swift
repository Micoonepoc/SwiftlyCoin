//
//  HapticManager.swift
//  SwiftlyCoin
//
//  Created by Михаил on 11.02.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    
    private static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
