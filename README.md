# API Data List with Search Filter

This Flutter application fetches data from an API, displays it in a searchable ListView, and includes a dynamic search filter that allows users to quickly find data based on titles. It uses `jsonplaceholder.typicode.com` as a sample data source and includes an enhanced user interface with a search bar and loading indicator.

## Features
- Fetches data from an external API and displays it in a scrollable ListView.
- Includes a search bar to filter data dynamically as the user types.
- Displays a loading indicator while data is being fetched.
- Error handling for unsuccessful API requests.

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- A code editor, such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installing Dependencies
This project requires the `http` package to make HTTP requests. Add it to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
After adding it, run:


flutter pub get
Running the App
Clone the Repository:


git clone <repository_url>
cd <repository_directory>

Run the App:
To run on an Android emulator or iOS simulator:

flutter run
To run on a connected device:

flutter devices
flutter run -d <device_id>

API Data Handling
Data Fetching: Data is fetched from https://jsonplaceholder.typicode.com/posts and parsed from JSON format.
Displaying Data: Each item in the ListView displays the title and body of a post.
Search Filter: A TextField allows for dynamic search, filtering items by title as the user types.

Dependencies
http package: For handling HTTP requests to fetch data from the API.
flutter/material.dart: Provides foundational Flutter widgets and material design.

App Preview
The app has a clean, minimalistic UI with a search bar and loading indicator
