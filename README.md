<div align="center">
  <h2 align="center">Weather Aware</h2>
  <div align="left">
	
![Repo Views](https://visitor-badge.laobi.icu/badge?page_id=SpencerVJones/Weather-Aware)
</div>

  <p align="center">
   An iOS application built with SwiftUI that delivers real-time weather forecasts and smart outfit recommendations. Integrated with Core Data, Firebase, and OpenWeather API, WeatherAware makes dressing for the day effortless.
    <br />
    <br />
    <a href="https://github.com/SpencerVJones/Weather-Aware/issues">Report Bug</a>
    ·
    <a href="https://github.com/SpencerVJones/Weather-Aware/issues">Request Feature</a>
  </p>
</div>


<!-- PROJECT SHIELDS -->
<div align="center">


![License](https://img.shields.io/github/license/SpencerVJones/Weather-Aware?style=for-the-badge)
![Contributors](https://img.shields.io/github/contributors/SpencerVJones/Weather-Aware?style=for-the-badge)
![Forks](https://img.shields.io/github/forks/SpencerVJones/Weather-Aware?style=for-the-badge)
![Stargazers](https://img.shields.io/github/stars/SpencerVJones/Weather-Aware?style=for-the-badge)
![Issues](https://img.shields.io/github/issues/SpencerVJones/Weather-Aware?style=for-the-badge)
![Last Commit](https://img.shields.io/github/last-commit/SpencerVJones/Weather-Aware?style=for-the-badge)
![Repo Size](https://img.shields.io/github/repo-size/SpencerVJones/Weather-Aware?style=for-the-badge)

![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg?style=for-the-badge&logo=apple)
![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge&logo=swift&logoColor=white)
![CoreData](https://img.shields.io/badge/CoreData-%E2%9C%94%EF%B8%8F-blue?style=for-the-badge)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![OpenWeather](https://img.shields.io/badge/OpenWeather-API-orange?style=for-the-badge)

</div>



## 📑 Table of Contents
- [Overview](#overview)
- [Technologies Used](#technologies-used)
- [Architecture](#architecture)
- [Features](#features)
- [Demo](#demo)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [API Keys](#api-keys)
  - [How to Run](#how-to-run)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
	- [Contributors](#contributors)
- [License](#license)
- [Contact](#contact)

## Overview
**Weather Aware** is an intelligent iOS weather application that not only provides accurate forecasts but also suggests outfit recommendations based on current conditions.  
The app uses **OpenWeather API** for real-time weather data, **Core Data** for local storage of clothing items, and **Firebase** for backend services.  

Whether it’s sunny, rainy, snowy, or windy, Weather Aware helps you pick the right clothes every time.  


## Technologies Used
- **Swift 5.9+**
- **SwiftUI**
- **Combine (Observer pattern via @Published, @ObservedObject, @EnvironmentObject)**
- **Core Data** for persistence
- **Firebase (Authentication, Analytics)**
- **OpenWeather API**
- **XCTest / XCTestCase** for unit & UI testing

## Architecture
- **MVVM (Model-View-ViewModel)** design pattern  
- **Observer Pattern** for reactive updates between weather service, recommendation engine, and UI  
- **Persistence Layer:** Core Data manages user’s clothing items  
- **Networking Layer:** Fetches data from OpenWeather API  

## Features
- 🌤️ Real-time weather updates using OpenWeather API  
- 👕 Outfit recommendations based on temperature, weather type, and occasion  
- 🎨 Clothing management system (add, categorize, and store clothes)  
- 📊 Clothing suitability scoring (versatility & layerability)  
- 💾 Persistent storage with Core Data  
- 🔔 Seamless UI updates via Combine  
- 🧪 Unit tests & UI tests for reliability  

## Demo
Coming Soon!

## Project Structure
```bash
WeatherAware/
├── WeatherAwareApp.swift        # Entry point
├── Models/                      # Data models (Weather, Clothing, Recommendations)
├── Services/                    # API + Recommendation logic
├── ViewModels/                  # State management (Wardrobe, Weather)
├── Views/                       # SwiftUI screens + reusable components
├── Extensions/                  # Helpers for SwiftUI, Colors, Errors
├── Utilities/                   # Utility functions (icons, temp utils, etc.)
├── Config/                      # API keys & secrets
├── WeatherAwareTest/            # Unit tests
├── WeatherAwareUITest/          # UI tests
└── Assets.xcassets              # App icons & colors
```
## Testing
WeatherAware includes **unit tests and UI tests** written with `XCTest`:
-   `WeatherErrorTests` (validates custom error messages)
-   `LoadingStateViewTests` (ensures UI state messages render correctly)
-   `WeatherServiceTests` (validates API fetch & parsing logic)
-   `RecommendationEngineTests` (ensures correct outfit suggestions)

Run via: `⌘ + U # in Xcode`

## Getting Started
### Prerequisites
-  Xcode 15+
-   iOS 17+ deployment target
-   Swift Package Manager (SPM) for dependencies

### Installation
- git clone https://github.com/SpencerVJones/Weather-Aware.git
- cd Weather-Aware
- open WeatherAware.xcodeproj


### API Keys
1.  Sign up at OpenWeather.
2.  Create an API key.
3.  Add your key to `WeatherService.swift`: 

`private  let apiKey =  "YOUR_API_KEY"`
 
### How to Run
-   Select an iOS Simulator (or your device) in Xcode.
-   Run with `Cmd + R`.

## Usage
-   Open the app and allow location access.
-   View the current weather forecast.
-   Browse suggested outfits tailored to conditions.
-   Manage your clothing items via Core Data.
 
## Roadmap
 - [ ] Add push notifications for daily outfit tips
 - [ ] Integrate with Apple Watch
 - [ ] Machine learning-based clothing recommendation engine
 - [ ] Share outfit suggestions with friends
 - [ ] Dark Mode custom UI
 - [ ] Thermal insulation measure to determine what weather each piece of clothing is good for

See open issues for a full list of proposed features (and known issues).
 
 
## Contributing
Contributions are welcome! Feel free to submit issues or pull requests with bug fixes, improvements, or new features.
- Fork the Project
- Create your Feature Branch (git checkout -b feature/AmazingFeature)
- Commit your Changes (git commit -m 'Add some AmazingFeature')
- Push to the Branch (git push origin feature/AmazingFeature)
- Open a Pull Request

### Contributors
<a href="https://github.com/SpencerVJones/Weather-Aware/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=SpencerVJones/Weather-Aware"/>
</a>


## License
Distributed under the MIT License. See LICENSE for more information.



## Contact
Spencer Jones
📧 [SpencerVJones@outlook.com](mailto:SpencerVJones@outlook.com)  
🔗 [GitHub Profile](https://github.com/SpencerVJones)  
🔗 [Project Repository](https://github.com/SpencerVJones/Weather-Aware)
