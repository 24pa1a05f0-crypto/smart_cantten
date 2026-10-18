# Smart Canteen (Flutter)

A student-friendly college canteen demo app with Home, Menu search/category filtering, My Orders, and Profile screens.

## Run the project

1. Install Flutter and Android Studio (or use a Flutter-compatible IDE).
2. Open this project folder in your IDE.
3. Run `flutter pub get`.
4. Run `flutter analyze` to check the project.
5. Run `flutter run`.

The Flutter entry point is `lib/main.dart`.

## Notes

- This is currently a UI/demo project. Menu items are sample data in `lib/data/demo_menu.dart`.
- Cart checkout, pickup slots, live order tracking, authentication, and Firebase integration are not implemented in this version.

## Android platform folder

This archive includes an Android Gradle project scaffold under `android/` so platforms that require the Android folder can recognize it as a Flutter project. Open the project using a Flutter SDK installed locally, then run `flutter pub get` and `flutter run`. Flutter can regenerate platform-specific files if needed with `flutter create --platforms=android .`.
