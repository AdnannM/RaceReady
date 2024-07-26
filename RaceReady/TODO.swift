//
//  TODO.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 23.07.24.
//

/*
 
 ### TODO List with Detailed Instructions and Helpers

 ---

 **1. Create Cache for Races - Upcoming and Finished**
    - **Goal**: Store data for upcoming and finished races locally to display when the API is not available.
    - **Steps**:
      1. **Implement Local Storage**: Use UserDefaults or a local database like Core Data or SQLite.
      2. **Fetch and Save Data**: Fetch race data from the API, save it locally upon successful fetch.
      3. **Load from Cache**: When the API is not available, load the data from local storage.
    - **Helper**:
      ```swift
      func saveRacesToCache(_ races: [Race]) {
          // Encode and save to UserDefaults or Core Data
      }
      
      func loadRacesFromCache() -> [Race]? {
          // Decode and return data from UserDefaults or Core Data
      }
      ```

 ---

 **2. Create Cache for Driver Standings and Teams Standings**
    - **Goal**: Cache all results for driver and team standings and display when the API is not working.
    - **Steps**:
      1. **Implement Local Storage**: Similar to race caching, use UserDefaults or Core Data.
      2. **Fetch and Save Data**: Fetch standings data from the API, save it locally upon successful fetch.
      3. **Load from Cache**: Load the data from local storage when the API is not available.
    - **Helper**:
      ```swift
      func saveStandingsToCache(_ standings: [Standing]) {
          // Encode and save to UserDefaults or Core Data
      }
      
      func loadStandingsFromCache() -> [Standing]? {
          // Decode and return data from UserDefaults or Core Data
      }
      ```

 ---

 **3. Fix the Date and Time in Upcoming Races**
    - **Goal**: Format time from UTC (Z) to Central European Time (CET).
    - **Steps**:
      1. **Date Formatter**: Use `DateFormatter` to convert and format the date.
      2. **Convert Time Zone**: Set the time zone to CET.
    - **Helper**:
      ```swift
      func formatToCET(_ utcDate: String) -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          formatter.timeZone = TimeZone(abbreviation: "UTC")
          if let date = formatter.date(from: utcDate) {
              formatter.timeZone = TimeZone(identifier: "CET")
              formatter.dateFormat = "yyyy-MM-dd HH:mm"
              return formatter.string(from: date)
          }
          return utcDate
      }
      ```

 ---

 **4. Create Widget for Upcoming Races**
    - **Goal**: Display upcoming races in medium and large widget sizes.
    - **Steps**:
      1. **WidgetKit Integration**: Create a widget extension in your app.
      2. **Configure Widget**: Define the timeline and views for the widget.
      3. **Fetch Data**: Load data from the cache or API.
    - **Helper**:
      - Follow Apple’s [WidgetKit documentation](https://developer.apple.com/documentation/widgetkit) for setup.

 ---

 **5. Create Widget for Drivers and Teams Standings**
    - **Goal**: Display driver and team standings in widgets.
    - **Steps**:
      1. **WidgetKit Integration**: Similar to the races widget, create another widget extension.
      2. **Configure Widget**: Define the timeline and views for the widget.
      3. **Fetch Data**: Load data from the cache or API.
    - **Helper**:
      - Follow Apple’s [WidgetKit documentation](https://developer.apple.com/documentation/widgetkit) for setup.

 ---

 **6. Request User Notification Permission**
    - **Goal**: Request permission to send notifications when the app is first run.
    - **Steps**:
      1. **UNUserNotificationCenter**: Use this framework to request permission.
      2. **Prompt User**: Show a prompt to the user on the main view.
    - **Helper**:
      ```swift
      func requestNotificationPermission() {
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
              // Handle permission
          }
      }
      ```

 ---

 **7. Add Push Notification for Upcoming Races**
    - **Goal**: Notify users 30 and 15 minutes before a race.
    - **Steps**:
      1. **Schedule Notifications**: Use `UNUserNotificationCenter` to schedule notifications.
      2. **Trigger Notifications**: Set triggers based on race times.
    - **Helper**:
      ```swift
      func scheduleRaceNotifications(race: Race) {
          let content = UNMutableNotificationContent()
          content.title = "Upcoming Race"
          content.body = "The race starts in 30 minutes!"
          
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30*60, repeats: false)
          let request = UNNotificationRequest(identifier: race.id, content: content, trigger: trigger)
          
          UNUserNotificationCenter.current().add(request)
      }
      ```

 ---

 **8. Create Different UI for Finished Races**
    - **Goal**: Display all results with time and laps for finished races.
    - **Steps**:
      1. **UI Design**: Create a different view for finished races.
      2. **Data Presentation**: Display detailed results including times and laps.
    - **Helper**:
      - Use SwiftUI to create a detailed view.

 ---

 **9. Implement Correct Links in Settings View**
    - **Goal**: Add real links for social media accounts.
    - **Steps**:
      1. **URL Links**: Add actual URLs for Instagram, Twitter, etc.
      2. **Link Buttons**: Use `Link` or `Button` in SwiftUI.
    - **Helper**:
      ```swift
      Link("Twitter", destination: URL(string: "https://twitter.com/yourProfile")!)
      ```

 ---

 **10. Handle Errors in a Better Way**
    - **Goal**: Display an error view when the user is not connected to the internet.
    - **Steps**:
      1. **Network Check**: Check for network availability.
      2. **Error View**: Show a user-friendly error view.
    - **Helper**:
      - Use Reachability to check for network connectivity.

 ---

 **11. Show Onboarding Screen Only First Time**
    - **Goal**: Display an onboarding screen on the first app launch.
    - **Steps**:
      1. **UserDefaults**: Store a key to check if the user has seen the onboarding screen.
      2. **Conditional View**: Show onboarding if the key is not set.
    - **Helper**:
      ```swift
      if !UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
          // Show onboarding screen
          UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
      }
      ```

 ---

 **12. Create and Add More UI for Upcoming Races**
    - **Goal**: Enhance the UI for upcoming races.
    - **Steps**:
      1. **Design Improvements**: Add more visual elements like images, countdown timers, etc.
      2. **User Interaction**: Provide more details and interaction options.
    - **Helper**:
      - Use SwiftUI views like `VStack`, `HStack`, `Image`, and `Text` to create a rich UI.

 ---
 
 ---

 **13. Format date and time in Race View**
    - **Goal**: Make it clean.
    - **Steps**:
      1. **Design Improvements**: Divide date and time, etc.
      2. **Design Improvements**: Make it Grind 2 in row and display it 
 ---
 
 /**/*/
