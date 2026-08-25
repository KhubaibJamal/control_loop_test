# Service Loop

Flutter UI for a home-services marketplace (home, category list, provider detail), built from Figma.

## Requirements

- Flutter 3.38.7 and Dart 3.10.7 (or compatible stable)
- Flutter SDK / Dart `^3.10.7` (see `pubspec.yaml`)
- Xcode (iOS) and/or Android Studio (Android)

## Install Flutter

1. Follow the official guide: [Install Flutter](https://docs.flutter.dev/get-started/install)
2. Add `flutter` to your PATH
3. Check the toolchain:

```bash
flutter doctor
```

Fix any issues it reports before continuing.

## Steps to Run

1. **Clone the project**

   ```bash
   git clone https://github.com/KhubaibJamal/control_loop_test.git
   cd control_loop_test
   ```

2. **Install Flutter packages**

   ```bash
   flutter pub get
   ```

3. **Install iOS pods (macOS only)**

   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the app**

   ```bash
   flutter devices
   flutter run
   ```

   Or target a device explicitly:

   ```bash
   flutter run -d <device_id>
   ```

## Beyond Figma (UI / animation)

Brief extras not in the static design frames:

- Collapsing home header (welcome folds away; search stays pinned)
- Staggered fade/slide on home sections and provider cards
- Fade + slide route transitions between screens
- Sticky name + back bar on provider detail when scrolling
- Soft nav-icon scale and animated service chips
- Full-screen gallery open with fade (no page counter)

## Development Tips

- Use `dart format .` before submitting PRs.
- Keep repositories free of UI concerns—push business logic into view models.
- Add widget tests for critical flows whenever you change UX logic.

## Contributing

1. Create a topic branch off `main`.
2. Make your changes with tests.
3. Open a PR describing the change and screenshots for UI updates.

## License

This project is proprietary. All rights reserved.
