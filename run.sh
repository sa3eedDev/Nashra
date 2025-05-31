#!/bin/bash

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "Flutter is not installed or not in PATH."
    echo "Please install Flutter from https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter version
FLUTTER_VERSION=$(flutter --version | head -n 1)
echo "Using $FLUTTER_VERSION"

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Run the app
echo "Starting Baloot Counter app..."
flutter run 