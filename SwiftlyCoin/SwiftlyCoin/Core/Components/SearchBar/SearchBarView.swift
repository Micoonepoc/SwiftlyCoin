//
//  SearchBarView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 05.01.2024.
//

import SwiftUI
import Combine

struct SearchBarView: View {
    
    @Binding var textFieldText: String
    
    let textLimit = 10
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(textFieldText.isEmpty ? Color.colorTheme.secondaryText : Color.colorTheme.accent)
            
            TextField("Type some coin...", text: $textFieldText)
                .foregroundStyle(Color.colorTheme.accent)
                .overlay(alignment: .trailing) {
                    Image(systemName: "x.circle")
                        .padding()
                        .offset(x: 10.0)
                        .opacity(textFieldText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            textFieldText = ""
                            UIApplication.shared.endTextEditing()
                        }
                        .onReceive(Just(textFieldText), perform: { _ in
                            limitText(textLimit)
                        })
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.colorTheme.background)
                .shadow(color: Color.colorTheme.accent.opacity(0.15), radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
    
    func limitText(_ upper: Int) {
            if textFieldText.count > upper {
                textFieldText = String(textFieldText.prefix(upper))
            }
        }
    
}


#Preview {
    SearchBarView(textFieldText: .constant(""))
}
