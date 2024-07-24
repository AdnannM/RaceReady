//
//  RaceReadyWidget.swift
//  RaceReadyWidget
//
//  Created by Adnann Muratovic on 24.07.24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct RaceReadyWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        Group {
            switch family {
            case .systemMedium:
                MediumRaceReadyWidgetEntryView(entry: entry)
            case .systemLarge:
                LargeRaceReadyWidgetEntryView(entry: entry)
            default:
                MediumRaceReadyWidgetEntryView(entry: entry)
            }
        }
        
    }
}


struct RaceReadyWidget: Widget {
    let kind: String = "RaceReadyWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            RaceReadyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}



#Preview(as: .systemMedium) {
    RaceReadyWidget()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(date: .now)
}

#Preview(as: .systemLarge) {
    RaceReadyWidget()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(date: .now)
}




struct LargeRaceReadyWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Add your large widget content here
            // This can be an expanded version of your medium widget
            // or a completely different layout
            Text("Large Widget Content")
            // ... add more content for large widget
        }
    }
}


struct MediumRaceReadyWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Canadian Grand Prix")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("7-9 JUN")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                    
                    Text("Circuit Gilles Villeneuve")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Text("Round 09")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image("canadaCircuit")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 80)
                    .padding(.leading, 10)
            }
            
            Divider().background(.purple)
            
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .center, spacing: 2) {
                    Text("FRI")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack(spacing: 10) {
                        Text("FP1")
                            .font(.footnote)
                            .foregroundColor(.primary)
                        Text("19:30")
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                    
                    HStack(spacing: 10) {
                        Text("FP2")
                            .font(.footnote)
                            .foregroundColor(.primary)
                        Text("20:00")
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
                
                Divider()
                
                VStack(alignment: .center, spacing: 2) {
                    Text("SAT")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack(spacing: 10) {
                        Text("FP3")
                            .font(.footnote)
                            .foregroundColor(.primary)
                        Text("18:30")
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Quali")
                            .font(.footnote)
                            .foregroundColor(.primary)
                        Text("22:00")
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
                
                Divider()
                
                VStack(alignment: .center, spacing: 2) {
                    Text("SUN")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack(spacing: 10) {
                        Text("Race")
                            .font(.footnote)
                            .foregroundColor(.primary)
                        Text("20:00")
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}
