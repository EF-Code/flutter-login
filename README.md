# Flutter Login

A clean, responsive login screen built with Flutter and Material 3. The interface pairs a dark teal header with mint accents, clear form labels, and a focused sign-in flow.

## Preview

<img src="screenshots/login.png" alt="Forma login screen with a dark teal welcome header, email and password fields, and a sign-in button" width="390">

Captured directly from the Flutter widget renderer at 390 × 844 pixels. The app bundles its fonts so the preview matches the interface without relying on external font services.

## Features

- Email validation and a six-character minimum for the demo password.
- Password visibility toggle with accessible control labels.
- Autofill hints, keyboard navigation, and submission from the password field.
- Scrollable layout for smaller screens and the on-screen keyboard.
- Local validation feedback through a confirmation message.

This project demonstrates a login interface. It does not authenticate users or send or persist credentials. Any valid email and password of six or more characters will pass the demo validation. Connect an authentication service in `_signIn` before using it in a production application.

## Getting started

Install the [Flutter SDK](https://docs.flutter.dev/install) and the development tools for your target platform. The project was verified with Flutter 3.47.9 and Dart 3.13.7.

```sh
git clone https://github.com/EF-Code/flutter-login.git
cd flutter-login
flutter pub get
flutter run
```

Android, iOS, and web project files are included. iOS development requires macOS and Xcode. For a browser preview:

```sh
flutter run -d chrome
```

## Project structure

```text
lib/main.dart             App theme, login screen, and form validation
assets/fonts/             Bundled Roboto fonts and license
screenshots/login.png     README preview
test/login_test.dart      Form, keyboard, and layout checks
test/screenshot_test.dart  Reproducible screenshot check
```

The app uses Flutter's built-in widgets without additional runtime packages or a state management library. Presentation and form behavior remain in one file to keep the example easy to follow.

## Verification

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web
```

The widget tests cover invalid inputs, successful demo validation, password visibility, keyboard submission, small screens with a keyboard, and larger text.

To refresh the preview after changing the interface:

```sh
flutter test --update-goldens test/screenshot_test.dart
```

Review the generated image before committing it. Golden images can vary slightly between Flutter versions and operating systems; the committed screenshot was generated on Linux with the SDK version listed above.
