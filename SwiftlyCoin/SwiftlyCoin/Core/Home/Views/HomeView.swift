//
//  HomeView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 30.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.colorTheme.background
                .ignoresSafeArea()
                        
            VStack {
                HStack {
                    CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                        .animation(.none, value: showPortfolio)
                        .background(CircleButtonAnimationView(animate: $showPortfolio))

                    Spacer()
                    
                    Text(showPortfolio ? "Portfolio" : "Live Prices")
                        .animation(.none)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.colorTheme.accent)
                    
                    Spacer()

                    CircleButtonView(imageName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring) {
                                showPortfolio.toggle()
                            }
                        }
                }
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    HomeView()
        .toolbar(.hidden)
}
