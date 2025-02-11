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
