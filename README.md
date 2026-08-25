
## Requirements
- Flutter 3.38.7 and Dart 3.10.7
- Flutter SDK ^3.10.7
- Xcode 15 / Android Studio Hedgehog (for iOS/Android builds)


## Steps to Run
1. **Clone**
   ```bash
   git clone https://github.com/KhubaibJamal/control_loop_test.git
   cd control-loop-test
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
   
4. **Run**
   ```bash
   flutter run
   ```


## Development Tips
- Use `dart format .` before submitting PRs.
- Keep repositories free of UI concerns—push business logic into view models.
- Add widget tests for critical flows whenever you change UX logic.

## Contributing
1. Create a topic branch off `main`.
2. Make your changes with tests.
3. Open a PR describing the change, screenshots for UI updates, and any env/key requirements.

## License
This project is proprietary. All rights reserved.
