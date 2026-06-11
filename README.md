# AJWA
A modern, SwiftUI weather client — clean, contextual, and location-aware. Built to deliver quick, glanceable forecasts with an adaptive UI that reflects time of day.

[![Build Status](https://img.shields.io/badge/build-unknown-lightgrey.svg)]() [![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)]()

---

## Table of Contents
- [Visuals](#visuals)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Getting Started / Installation](#getting-started--installation)
- [Project Structure & Architecture Overview](#project-structure--architecture-overview)
- [Common Workflows & Notes for Reviewers](#common-workflows--notes-for-reviewers)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Roadmap / Improvements](#roadmap--improvements)
- [Acknowledgments](#acknowledgments)

---

## Visuals
| Main Screen | Hourly Detail | Search / Saved Locations |
|---:|:---:|:---:|
| ![Main Screen Placeholder](./Ajwa/Assets.xcassets/Preview.png) | ![Hourly Screen Placeholder](./Ajwa/Assets.xcassets/Preview.png) | ![Search/Saved Placeholder](./Ajwa/Assets.xcassets/Preview.png) |

> Replace each placeholder image above with real screenshots captured from the app and commit them to `Ajwa/Assets.xcassets/screenshots/` or `./assets/screenshots/` as preferred.

---

## Key Features
- Dynamic UI that adapts visuals and text color based on time of day:
  - Morning mode: 05:00 — 18:00
  - Evening mode: 18:00 — 05:00
- Main Dashboard split into three clear sections:
  1. Top: Current location and temperature summary (with condition)
  2. Middle: 3-day forecast list (tap a day to see hourly breakdown)
  3. Bottom: Grid with Visibility, Humidity, Feels Like, and Pressure
- Hourly Details: Tap any forecast day to navigate to a detailed hourly timeline
- Location Management:
  - Global city search powered by WeatherAPI.com
  - "Saved Locations" list with local persistence for quick switching and offline access
- Background networking and asynchronous data handling (async/await)
- Local caching of saved/favourite locations for resilient UX

---

## Tech Stack
- UI: SwiftUI
- Architecture: MVVM (structured to enable Clean Architecture evolution)
- Networking: URLSession (code organized to allow easy swapping to Alamofire)
- Location: CoreLocation
- Persistence: SwiftData / local persistence for favourites (entities under `Model/`)
- Concurrency: Swift async/await
- Animations: Lottie (via Swift Package Manager)
- API: WeatherAPI.com (uses an API key / Basic HTTP auth style)

---

## Getting Started / Installation
### Prerequisites
- macOS with Xcode 14+ (or latest stable Xcode)
- An API key from WeatherAPI.com
- Git installed

### Clone the repository
```bash
git clone https://github.com/<your-org>/WeatherCast-App.git
cd WeatherCast-App
```

### Open the project
Prefer opening the workspace if present (resolves Swift packages automatically):
```bash
open Ajwa.xcworkspace
```
Or open the project file:
```bash
open Ajwa.xcodeproj
```

### Add your WeatherAPI key securely
Preferred: use the provided `Config.xcconfig` file.
1. Open `Ajwa/App/Config.xcconfig` and add a key (do NOT commit real keys):
```
WEATHERAPI_KEY = your_real_api_key_here
```
2. Ensure the target build settings include this xcconfig (the project already includes a `Config.xcconfig`).

Alternative (local dev only): add a `Secrets.swift` file (ignored by Git) with:
```swift
enum Secrets {
  static let weatherAPIKey = "your_real_api_key_here"
}
```
Make sure `Secrets.swift` is listed in `.gitignore` to avoid leaking credentials.

### Build & Run
- Select a simulator or physical device in Xcode and run (Cmd+R).

Notes:
- Do not commit API keys. Use environment variables or CI secrets for secure CI builds.

---

## Project Structure & Architecture Overview
The project follows MVVM and is organized for clarity and testability. Key folders and their responsibilities:

- Ajwa/
  - App/
    - `AjwaApp.swift` — App entry point and dependency composition
    - `Config.swift` / `Config.xcconfig` — Configuration bridge for API keys
  - Modules/
    - Splash/ — SplashView and initial animation
    - Home/ — Main dashboard and related modules
      - Presentation/
        - View/ — SwiftUI view files (HomeView, DetailsView, FavouritesView)
        - ViewModel/ — Observable ViewModels that own UI logic
      - Data/
        - Repository/ — Repositories mediating between services and ViewModels
        - Data Sources/ — Local/remote adapters (e.g., HomeLocalDataSource)
    - Search/ — City search UI and logic
  - Model/
    - API DTOs and application models (Forecast, CurrentWeather, HourWeather, etc.)
    - Persistence entities and mappers (ForecastDayEntity, HourEntity, etc.)
  - Services/
    - `WeatherApiService.swift` — Networking client for WeatherAPI.com
    - `WeatherLocalStorageService.swift` — Local persistence wrapper
    - `LocationService.swift` — CoreLocation convenience wrapper
    - `NetworkMonitor.swift` — Connectivity monitoring
  - Views/
    - Reusable SwiftUI components (NetworkBanner, Lottie wrapper, grid cells)
  - Core/Utilities/
    - Helpers, date/time utilities, formatters and icon mapping logic

Design principles:
- Views are declarative and lightweight. ViewModels handle state and side effects.
- Repositories abstract multiple data sources and make the app testable.
- Services follow single-responsibility and are injectable for mocking.

---

## Common Workflows & Notes for Reviewers
- Favourites are matched by a normalized name and by coordinates (when available) to avoid mismatches caused by differing name formats returned by APIs.
- Dynamic theming is implemented via date helpers that determine morning/evening windows and select gradients/backgrounds accordingly.
- Cached favourites are available offline and the app attempts graceful degradation when the network is unavailable.

---

## Testing
Manual tests to verify core flows:
- Add/remove a saved location and validate persistence in "Saved Locations".
- Search for a city and open its hourly detail screen.
- Change device time (simulator) to test morning/evening UI variations.

Suggested unit/integration test targets:
- ViewModel logic for favorite toggling and persistence
- Mappers that rehydrate model objects from persistence entities
- Date/time utility functions

---

## Troubleshooting
- If the build fails due to missing keys: verify `Config.xcconfig` and environment variables in the Xcode scheme.
- If favourites do not match UI state: inspect persisted entity fields (name, lat/lon) and verify normalization logic in `WeatherLocalStorageService`.

---

## Roadmap / Improvements
- Add CI (GitHub Actions) for build & test automation
- Introduce canonical location IDs (if provided by the API) to simplify matching logic
- Expand persistence schema to store more hourly/day fields for richer offline UX
- Improve accessibility (VoiceOver, Dynamic Type) and localization support

---

## Acknowledgments
Developed by Moaz Osama (ITI MAD46 Cohort).
Special thanks to Java™ Education and Technology Services (JETS) / Information Technology Institute (ITI) for learning and mentorship.

---

If you would like, I can also add:
- A `.env.example` and `.gitignore` snippet for secrets
- A CONTRIBUTING.md with branch/PR conventions
- A sample GitHub Actions workflow to validate Xcode build and run tests


---

*Last updated: June 11, 2026*
