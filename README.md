# NASA APOD Flutter App

## Overview
This Flutter application displays the Astronomy Picture of the Day (APOD) from NASA. Users can view a list of daily images, search by title or date, and view detailed information for each image. The app supports offline functionality and pagination.

## Features
- **Two Screens**: List of images and detailed view of each image.
- **Search**: Filter images by title or date.
- **Offline Support**: View previously loaded images without an internet connection.
- **Pagination**: Load more images as you scroll.
- **Pull-to-Refresh**: Refresh the list to fetch the latest images.
- **Responsive Design**: Adaptable to different screen sizes and resolutions.

## Getting Started

### Prerequisites
- Flutter SDK
- An IDE with Flutter support (Visual Studio Code or Android Studio)
- Git

### Installation
1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd nasa_apod
2. **Install dependencies:**
   ```sh
   flutter pub get
3. **Set up API key:**
- Obtain your API key from NASA API (https://api.nasa.gov/).
- Add the API key to your project (e.g., in a constants.dart file):
  ```dart
  const String apiKey = 'YOUR_API_KEY_HERE';

### Running the App
1. Run the app on an emulator or physical device:
   ```sh
   flutter run

### App Architecture
**Project Structure**

- lib/
- ├── model/
- │   └── apod_model.dart
- ├── modules/apod/
- │   ├── bloc/
- │   │   ├── apod_bloc.dart
- │   │   ├── apod_event.dart
- │   │   ├── apod_state.dart
- │   ├── apod_details.dart
- │   └── apod_home.dart
- ├── repositories/
- │   ├── local_storage_repository.dart
- │   ├── nasa_repository.dart
- │   └── response_handler.dart
- ├── services/
- │   ├── nasa_services.dart
- │   └── network_services.dart
- ├── utils/
- │   ├── simple_bloc_observer.dart
- │   └── theme_data.dart
- ├── widgets/
- │   ├── search_bar/
- │   │   ├── search_cubit/
- │   │   │   ├── search_cubit.dart
- │   │   │   ├── search_state.dart
- │   │   └── search_bar.dart
- │   ├── apod_tile.dart
- │   ├── custom_button.dart
- │   ├── custom_loader.dart
- ├── app.dart
- ├── home_screen.dart
- └── main.dart


# Libraries Used
- **http**: Networking
- **flutter_bloc**: State management
- **equatable**: Simplifying state comparison
- **sqflite**: Local storage
- **cached_network_image**: Image loading and caching
- **google_fonts**: Custom fonts
- **flutter_screenutil**: Responsive UI

# Offline Functionality
- **Local Storage**: Uses sqflite to store and retrieve images.
- **Caching**: Checks local database when offline and updates it when online.

# Testing
## Unit Tests
- **API Client**: Ensure proper data fetching and parsing.
- **Data Parsing**: Validate correct data structure.

## UI Tests
- **Navigation**: Verify navigation between list and detail screens.
- **Data Display**: Ensure correct display of data.
- **Offline Functionality**: Test app behavior without internet connection.

### Unit Tests
- You can run the tests without emulators and devices.
   ```sh
   flutter test

# Final Steps
- **Code Review**: Ensure code is clean, well-documented, and follows best practices.
- **Repository Preparation**: Remove unnecessary files, add documentation, and commit final changes.
- **Submission**: Compress the Git repository and submit it as required.

# Screenshots
Include relevant screenshots of your app here.

# Contact
**Daniyal Saeed**
daniyal.saeed7829@gmail.com
