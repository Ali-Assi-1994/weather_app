# Weather App - Flutte

This project is a Flutter application that displays weather information for a given city using the [OpenWeatherMap API](https://openweathermap.org/api).

## Table of Contents
1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Setup and Installation](#setup-and-installation)
4. [State Management](#state-management)
5. [Testing](#testing)
6. [Future Enhancements](#future-enhancements)

## Project Overview

This app provides weather details using the OpenWeatherMap API. It displays a list of weather forecasts and detailed information for a selected day. Users can view the current temperature, humidity, pressure, wind speed, and weather conditions through icons and descriptions.

## Features

The application satisfies the following acceptance criteria:

### Basic Features
- **Loading Indicator**: A loading indicator is displayed when data is being fetched from the API.
- **Weather List**: Displays a list of weather items with day abbreviations and weather condition icons.
- **Weather Details**: Includes detailed weather information such as day, condition name, icon, temperature, humidity, pressure, and wind speed.
- **Item Selection**: Selecting a weather item from the list updates the weather details.
- **Pull-to-Refresh**: Users can refresh the weather data by pulling down on the list.
- **Error Handling**: Shows an error screen with a retry button if data fetching fails.

### Additional Features
- **Support for Horizontal and Vertical Layouts**: The app adapts to different screen orientations.
- **Temperature Unit Switcher**: Users can toggle between Celsius and Fahrenheit for temperature display.

## Setup and Installation

**Flutter SDK** is required to run the mobile app. **Flutter 3.24.3 • channel stable** has been used for this app, with **Dart 3.5.3**

   - Tested on simulators: 
      **iPhone 16 Pro Max (iOS 18.1)**
      **iPhone 15 (iOS 17.5)**

To run the project, follow these steps:

1. **Clone the repository**.
2. **Install dependencies** using `flutter pub get`.
3. **Run the app** on a connected device or emulator.
4. **API Key Setup**: Replace the `appid` with your OpenWeatherMap API key in the `WeatherRepository` file. You can pass the API key during the build using `flutter run --dart-define=appid=YOUR_API_KEY`.


## State Management

This project uses [Riverpod](https://pub.dev/packages/flutter_riverpod) for state management:

## Testing

Unit  tests have been written to ensure the app functions as expected:

1. **Unit Tests**: Tests the data layer and providers.
  
## Future Enhancements

Some potential future improvements include:

1. **Localization**: Support for multiple languages.
2. **Widget Tests**: Ensures the UI components behave correctly.
3. **Integration Tests**
4. **flutter_screenutil** to support dynamic design sizes for all screens.


