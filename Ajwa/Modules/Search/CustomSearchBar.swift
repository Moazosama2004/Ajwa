//
//  CustomSearchBar.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Enter cities"
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.35).opacity(0.6))
                .padding(.leading, 20)
            
            TextField("", text: $text, prompt:
                Text(placeholder)
                    .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.35).opacity(0.5))
            )
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.35))
            .padding(.vertical, 16)
            .padding(.leading, 10)
            .padding(.trailing, 20)
            .autocorrectionDisabled()
        }
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
        }
    }
}

#Preview {
    CustomSearchBar(text: .constant("Hi"), placeholder: "a")
}
