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
    var entry: Provider.Entry // Assuming you have a Provider and Entry type defined
     
     let standings = [
         ("Verstappen", "169"),
         ("Leclerc", "138"),
         ("Norris", "113"),
         ("Sainz", "108"),
         ("Pérez", "107"),
         ("Piastri", "71"),
         ("Russell", "54"),
         ("Hamilton", "42"),
         ("Alonso", "33"),
         ("Tsunoda", "19")
     ]
     
     var body: some View {
         VStack(spacing: 10) {
             // F1 Standings part
             HStack(spacing: 10) {
                 VStack(spacing: 10) {
                     ForEach(0..<5) { index in
                         driverRow(position: index + 1, driver: standings[index])
                     }
                 }
                 
                 VStack(spacing: 10) {
                     ForEach(5..<10) { index in
                         driverRow(position: index + 1, driver: standings[index])
                     }
                 }
             }
             .padding(8)
             .background(Color.black)
             .cornerRadius(12)
             
             Spacer()
             Divider().background(.purple)
             MediumRaceReadyWidgetEntryView(entry: entry)
         }
     }
     
     func driverRow(position: Int, driver: (String, String)) -> some View {
         HStack {
             Text("\(position) \(driver.0)")
                 .font(.system(size: 12, weight: .medium))
                 .foregroundColor(.white)
                 .frame(maxWidth: .infinity, alignment: .leading)
             
             Text(driver.1)
                 .font(.system(size: 12, weight: .bold))
                 .foregroundColor(.white)
         }
         .padding(.horizontal, 6)
         .padding(.vertical, 3)
         .background(backgroundColorFor(position: position))
         .cornerRadius(4)
     }
     
     func backgroundColorFor(position: Int) -> Color {
         switch position {
         case 1: return Color.blue.opacity(0.8)
         case 2: return Color.red.opacity(0.8)
         case 3: return Color.orange.opacity(0.8)
         case 4: return Color.red.opacity(0.8)
         case 5: return Color.blue.opacity(0.8)
         case 6: return Color.orange.opacity(0.8)
         case 7: return Color.teal.opacity(0.8)
         case 8: return Color.teal.opacity(0.8)
         case 9: return Color.green.opacity(0.8)
         case 10: return Color.blue.opacity(0.8)
         default: return Color.gray.opacity(1)
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
