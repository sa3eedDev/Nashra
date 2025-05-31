# Baloot Counter

A Flutter application for counting scores in the Baloot card game.

## Features

- Track scores for two teams
- Count rounds played by each team
- View score history
- Undo last move
- Reset game
- Automatic winner detection when a team reaches 152 points
- Support for both Arabic and English numbers

## Getting Started

### Prerequisites

- Flutter SDK (2.17.0 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone this repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Usage

1. Enter the score for each team in the input fields
2. Press the "سجل" (Record) button to add the scores
3. Use the back arrow button to undo the last move if needed
4. Use the settings button to start a new game

## Structure

- `lib/main.dart` - Entry point of the application
- `lib/home_screen.dart` - Main screen with the score counter UI

## License

This project is open source and available under the MIT License. 