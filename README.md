# Recipe Browser

## Project Overview

**Description:**  
This app allows users to browse dessert recipes fetched from the MealDB API. Users can view a list of desserts, sorted alphabetically, and see detailed information about each dessert, including ingredients, measurements, and cooking instructions.

**Technologies Used:**
- Swift
- SwiftUI
- URLSession for networking
- Codable for JSON parsing

## Setup Instructions

**Requirements:**
- macOS with Xcode 12.0 or later
- iOS 15.0 or later for deployment target

**Installation Steps:**
1. **Clone the repository:**
    ```sh
    git clone https://github.com/ahiraniket/ios-recipe-browser.git
    ```

2. **Open the Xcode project:**
    ```sh
    cd fetch-ios/fetch-ios-application
    open fetch-ios-application.xcodeproj
    ```

3. **Set up the iOS Simulator:**
    - Open Xcode and navigate to `Preferences` > `Components` to ensure the iOS 15.0 (or later) simulator is installed.
    - Select a simulator device (e.g., iPhone 15 running iOS 15.0 or later) from the toolbar or the `Product` > `Destination` menu.

4. **Build and run the project:**
    - Click the build button (the play icon) or press `Cmd + R` to build and run the project on the selected simulator.

## Architecture

**Description:**
The app follows the MVVM (Model-View-ViewModel) architecture, separating the UI code from the business logic and data handling.

**Main Components:**
- **Model:** Contains the data structures (`Meal`, `MealListResponse`) and network manager (`MealListResponse`).
- **View:** SwiftUI views (`ContentView`, `ListView`, `DetailView`) that define the UI layout.
- **ViewModel:** Not explicitly defined but integrated within the views using state management (`@State` and `@StateObject`).

## API Integration

**Endpoints Used:**
- **Fetch Dessert List:** `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`
- **Fetch Meal Details:** `https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID`

**Data Handling:**
- **Meal:** Represents individual meal data.
- **MealListResponse:** Represents the response structure from the API containing a list of meals.

## Features

**Main Features:**
1. **List of Desserts:** Displays a list of dessert meals fetched from the API.
2. **Meal Details:** Shows detailed information about a selected meal, including name, instructions, ingredients, and measurements.

**Detailed Explanation:**

### List of Desserts
- **View:** `ListView`
- **Functionality:** Fetches and displays a list of desserts. Each item in the list navigates to the `DetailView` for more information.

### Meal Details
- **View:** `DetailView`
- **Functionality:** Fetches and displays detailed information about a meal, including instructions and ingredients.

## Screens

**Overview:**

1. **ContentView:** Entry point of the app that hosts `ListView`.
2. **ListView:** Displays the list of dessert meals.
3. **DetailView:** Shows detailed information about a selected meal.

**Navigation Flow:**
- `ContentView` -> `ListView` -> `DetailView`

## Unit Testing

**Tests Implemented:**
- Currently, unit tests are not included in the project. However, tests can be added using XCTest to verify network responses and data parsing.

## Conclusion

This project demonstrates the ability to integrate with a third-party API using Swift and SwiftUI, handle asynchronous data fetching, and present the data in a user-friendly manner. The architecture and code organization adhere to best practices, making the app maintainable and extensible.

## Appendix

**References:**
- [TheMealDB API](https://themealdb.com/api.php)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [URLSession Documentation](https://developer.apple.com/documentation/foundation/urlsession)

<br>

## Note
If you encounter any issues or have any questions, please feel free to reach out at `aaahir@asu.edu`.
