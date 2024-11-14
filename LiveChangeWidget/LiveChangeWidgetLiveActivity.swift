//
//  LiveChangeWidgetLiveActivity.swift
//  LiveChangeWidget
//
//  Created by YOUZONGYAN on 2024/11/4.
//

import ActivityKit
import WidgetKit
import SwiftUI



struct LiveChangeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveChangeWidgetAttributes.self) { context in
            VStack {
                HStack {
                    Text(context.state.name)
                    Spacer()
                    Image(systemName: "chart.bar.xaxis")
                    Text(String(context.state.totalCount))
                    
                    if let updatedAt = context.state.updatedAt {
                        Image(systemName: "clock.fill")
                        Text(updatedAt, style: .time)
                    }
                }.frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .padding(.bottom, 4)
                
                PollChartView(options: context.state.options)
            }.padding()
                .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.state.name).lineLimit(1)
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack(alignment: .top) {
                        Image(systemName: "chart.bar.xaxis")
                        Text(String(context.state.totalCount))
                    }.lineLimit(1)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    PollChartView(options: context.state.options)
                }
            } compactLeading: {
                Text(context.state.lastUpdatedOption?.name ?? "-")
            } compactTrailing: {
                HStack {
                    Image(systemName: "chart.bar.xaxis")
                    Text(String(context.state.lastUpdatedOption?.count ?? 0))
                }.lineLimit(1)
            } minimal: {
                HStack {
                    Image(systemName: "chart.bar.xaxis")
                    Text(String(context.state.totalCount))
                }.lineLimit(1)
            }
        }
    }
}

extension LiveChangeWidgetAttributes {
    fileprivate static var preview: LiveChangeWidgetAttributes {
        LiveChangeWidgetAttributes(pollId: "console")
    }
}

extension LiveChangeWidgetAttributes.ContentState {
    
    fileprivate static var first: LiveChangeWidgetAttributes.ContentState {
        LiveChangeWidgetAttributes.ContentState(updatedAt: Date(), name: "Favorite Console", totalCount: 100, options: [Option(count: 20, name: "XBOX S|X"), Option(id: "ps5", count: 80, name: "PS5")], lastUpdatedOptionId: "ps5")
         }
     
     fileprivate static var second: LiveChangeWidgetAttributes.ContentState {
         LiveChangeWidgetAttributes.ContentState(updatedAt: Date().addingTimeInterval(3600), name: "Favorite Console", totalCount: 160, options: [Option(count: 20, name: "XBOX S|X"), Option(id: "ps5", count: 140, name: "PS5")], lastUpdatedOptionId: "ps5")
     }
    
}

#Preview("Notification", as: .content, using: LiveChangeWidgetAttributes.preview) {
   LiveChangeWidgetLiveActivity()
} contentStates: {
    LiveChangeWidgetAttributes.ContentState.first
    LiveChangeWidgetAttributes.ContentState.second
}
