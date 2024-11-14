//
//  PollChartView.swift
//  LiveChange
//
//  Created by YOUZONGYAN on 2024/11/2.
//

import SwiftUI
import Charts

struct PollChartView: View {
    
    let options: [Option]
    
    var body: some View {
        Chart {
            ForEach(options) { option in
                SectorMark(
                    angle: .value("Count", option.count),
                    innerRadius: .ratio(0.6),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", option.name))
                
            }
        }
    }
}

#Preview {
    PollChartView(
        options: [
            .init(count: 2, name: "PS5"),
            .init(count: 1, name: "XBox"),
            .init(count: 2, name: "Switch"),
            .init(count: 1, name: "PC")
        ]
    )
    
}
