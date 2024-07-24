//
//  RaceReadyWidgetLiveActivity.swift
//  RaceReadyWidget
//
//  Created by Adnann Muratovic on 24.07.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RaceReadyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RaceReadyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RaceReadyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RaceReadyWidgetAttributes {
    fileprivate static var preview: RaceReadyWidgetAttributes {
        RaceReadyWidgetAttributes(name: "World")
    }
}

extension RaceReadyWidgetAttributes.ContentState {
    fileprivate static var smiley: RaceReadyWidgetAttributes.ContentState {
        RaceReadyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RaceReadyWidgetAttributes.ContentState {
         RaceReadyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RaceReadyWidgetAttributes.preview) {
   RaceReadyWidgetLiveActivity()
} contentStates: {
    RaceReadyWidgetAttributes.ContentState.smiley
    RaceReadyWidgetAttributes.ContentState.starEyes
}
