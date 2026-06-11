//
//  ThemedBackgroundModifier.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import SwiftUI

struct ThemedBackgroundModifier: ViewModifier {
    private let theme = ThemeManager.shared.current

    func body(content: Content) -> some View {
        ZStack {
            Image(theme.backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            content
                .padding(.top,48)
                .foregroundStyle(theme.contentColor)
        }
        .toolbarColorScheme(theme.colorScheme == .dark ? .dark : .light, for: .navigationBar)
    }

    }


extension View {
    func themedBackground() -> some View {
        modifier(ThemedBackgroundModifier())
    }
}
	
