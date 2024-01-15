//
//  HomeStatisticView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 15.01.2024.
//

import SwiftUI

struct HomeStatisticView: View {
    
    let statistics: [StatisticModel] = [
        StatisticModel(title: "Market Cap", value: "$18.5Bn", percentage: 2.5),
    StatisticModel(title: "Total Value", value: "$20Tr"),
    StatisticModel(title: "BTC Dominance", value: "50.24%"),
        StatisticModel(title: "Portfolio", value: "$43.565", percentage: -2.5)
    ]
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(statistics) { stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatisticView(showPortfolio: .constant(false))
}
