//
//  StatisticView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 15.01.2024.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.colorTheme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(Color.colorTheme.accent)
            HStack(spacing: 4) {
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (statistic.percentage ?? 0) >= 0 ? 0 : 180))
                
                Text(statistic.percentage?.asStringPercent() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((statistic.percentage ?? 0) >= 0 ? Color.colorTheme.green : Color.colorTheme.red)
            .opacity(statistic.percentage == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {
    StatisticView(statistic: StatisticModel(title: "Market Cap", value: "$12.5Bn", percentage: 25.3))
}
#Preview {
    StatisticView(statistic: StatisticModel(title: "Total Value", value: "$120Tr"))
}
#Preview {
    StatisticView(statistic: StatisticModel(title: "Portfolio", value: "$50k", percentage: -15.78))
}
