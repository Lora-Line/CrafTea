//
//  Fonts.swift
//
//
//  Created by apprenant75 on 27/10/2025.
//

import SwiftUI


extension View {
    
    func mainTitle(color: Color = Color.textPrimary) -> some View {
        return self.font(.custom("Manrope-Bold", size: 28))
    }
    func secondaryTitle(color: Color = Color.textPrimary) -> some View {
        return self.font(.custom("Manrope-Bold", size: 21))
    }
    func tertiaryTitle(color: Color = Color.textPrimary) -> some View {
        return self.font(.custom("Manrope-Bold", size: 16))
    }
    func mainText(color: Color = .textPrimary, bold: Bool = false) -> some View {
        return bold ? self.font(.custom("Inter24pt-SemiBold", size: 16)) : self.font(.custom("Inter24pt-Regular", size: 16))
    }
    func secondaryText(color: Color = Color.textSecondary) -> some View {
        return self.font(.custom("Inter24pt-Regular", size: 14))
    }
    func categoryText(color: Color = Color.secondaryOrange) -> some View {
        return self.font(.custom("Manrope-ExtraBold", size: 12))
    }
    func buttonLabel(color: Color = Color.textPrimary) -> some View {
        return self.font(.custom("Manrope-SemiBold", size: 14))
    }
}



