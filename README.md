Setup notes and tests:

weather_app
This is a Flutter app for displaying weather condition of your current location as well as based on the userinput location.

Getting Started:
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

Prerequisites:
Before you begin, ensure you have Flutter and Dart installed on your machine.

Installing:
Clone the repository to your local machine:
git clone https://github.com/Sabinkc/weather_app

Change directory to the project folder:
cd weather_app

Install dependencies:
flutter pub get
Once you have the dependencies installed, you can run the app on an emulator or physical device.

On Emulator:
Start an emulator with Android Studio or Visual Studio Code.

Run the app:
flutter run
On Physical Device:
Connect your device to your machine via USB.
Enable USB debugging on your device.

Run the app:
flutter run

To build the app for release, use the following command:
flutter build apk
This will generate an APK file that can be distributed and installed on Android devices.

Project Structure:
flutter-weather_app/
├── android/
├── ios/
├── lib/
│   ├── assets/
│   ├── models/
│   ├── screens/
│   ├── services/
│   └── main.dart
├── test/
├── pubspec.yaml
└── README.md

Running Tests:
flutter test

Built With:
Flutter - The framework used
Dart - The language used

Authors:
Sabin KC






