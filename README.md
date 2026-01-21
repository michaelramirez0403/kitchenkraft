# ReciMe iOS --- Coding Challenge

## 📘 Overview

ReciMe iOS is a native SwiftUI application that allows users to browse,
search, and filter a curated collection of cooking recipes. The app
loads recipe data from a local mock API response (JSON file) and
presents it using a clean, responsive grid-based UI with real-time
search and filtering capabilities.

The project is structured to simulate a production-ready architecture,
making it easy to replace the local data source with a real backend API
in the future.

## ✨ Features

-   Browse recipes in a responsive grid layout
-   Recipe detail view with ingredients and step-by-step instructions
-   Live search with instant filtering
-   Advanced filters:
    -   Vegetarian-only toggle
    -   Servings filter
    -   Include / exclude ingredients
    -   Instruction keyword search
-   Local mock API integration using bundled JSON
-   Modern SwiftUI navigation and previews
-   Fully native performance (no third-party UI frameworks)

## 🛠 Tech Stack

-   Language: Swift 6+
-   UI Framework: SwiftUI
-   Concurrency: async/await
-   State Management: ObservableObject + Combine
-   Architecture: MVVM + Coordinator
-   Target OS: iOS 26+
-   Data Source: Local JSON mock API

## 🚀 Setup Instructions

### Requirements

-   Xcode 16+
-   macOS Sonoma or later
-   iOS Simulator (iPhone 16 recommended)

### Steps

1.  Clone the repository:

git clone https://github.com/your-username/recime-ios.git

2.  Open the project:

open ReciMe.xcodeproj

3.  Select a simulator and run the project:

Command + R

No additional setup is required. The app uses a bundled mock JSON file.

## 🏗 Architecture Overview

The project follows MVVM with a Repository pattern:

View -\> ViewModel -\> Repository -\> Mock API (JSON)

This structure allows easy migration to real APIs and improves
testability.

## 🧩 Key Design Decisions

### Fixed Grid Layout

Cards use normalized image height and text blocks to ensure consistent
spacing and avoid uneven grid rows.

### Repository Pattern

Abstracts data access and simulates production-ready networking
behavior.

### Local Filtering

Recipes are loaded once and filtered locally for smooth performance and
instant UI updates.

### SwiftUI Best Practices

Uses NavigationStack, LazyVGrid, async/await, SwiftUI previews, and
environment-driven navigation.

## ⚠ Assumptions

-   Data is static and bundled locally
-   Dietary attributes are predefined
-   Search uses case-insensitive substring matching
-   Ingredient filtering is keyword-based

## ⚖ Tradeoffs

-   Local filtering instead of real API calls for speed and simplicity
-   Fixed card height for layout consistency
-   No third-party UI libraries for maintainability

## 🚧 Known Limitations

-   No pagination
-   No backend networking
-   No persistence layer
-   No analytics integration

## 🔮 Future Improvements

-   API integration
-   Pagination and infinite scroll
-   Favorites and local persistence
-   Image caching
-   Accessibility enhancements
-   Unit and UI testing

## 📤 Submission

Submit repository or ZIP to:

nic@recime.app\
christine@recime.app
