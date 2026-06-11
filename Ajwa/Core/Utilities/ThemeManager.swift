//
//  ThemeManager.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import SwiftUI

struct AppTheme {
    let backgroundImage: String
    let contentColor: Color
    let colorScheme: ColorScheme
}

class ThemeManager {

    static let shared = ThemeManager()
    private init() {}

    var current: AppTheme {
        isMorning ? morning : evening
    }

    private var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 5 && hour < 18
    }

    private var morning: AppTheme {
        AppTheme(
            backgroundImage: "morning-background",
            contentColor: .black,
            colorScheme: .light
        )
    }

    private var evening: AppTheme {
        AppTheme(
            backgroundImage: "evening-background",
            contentColor: .white,
            colorScheme: .dark
        )
    }
}
