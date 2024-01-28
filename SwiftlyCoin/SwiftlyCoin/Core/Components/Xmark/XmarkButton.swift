//
//  XmarkButton.swift
//  SwiftlyCoin
//
//  Created by Михаил on 26.01.2024.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .bold()
        })
    }
}

#Preview {
    XmarkButton()
}
