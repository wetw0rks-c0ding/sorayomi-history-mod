@echo off
REM Build script for Sorayomi Flutter project
REM Run this script to generate code and build the iOS app

echo ============================================
echo Sorayomi Build Script
echo ============================================
echo.

REM Check if Flutter is available
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter from https://flutter.dev/docs/get-started/install
    echo.
    echo If Flutter is installed, add it to your PATH:
    echo Example: set PATH=%%PATH%%;C:\path\to\flutter\bin
    exit /b 1
)

echo Step 1: Cleaning previous builds...
flutter clean

if %errorlevel% neq 0 (
    echo ERROR: flutter clean failed
    exit /b 1
)

echo.
echo Step 2: Getting Flutter packages...
flutter pub get

if %errorlevel% neq 0 (
    echo ERROR: flutter pub get failed
    exit /b 1
)

echo.
echo Step 3: Running code generation (build_runner)...
echo This may take a few minutes...
flutter pub run build_runner build --delete-conflicting-outputs

if %errorlevel% neq 0 (
    echo ERROR: Code generation failed
    echo This is required to generate .g.dart, .freezed.dart, and GraphQL files
    exit /b 1
)

echo.
echo Step 4: Building iOS app (unsigned for development)...
echo This may take several minutes...
flutter build ios --release --no-codesign

if %errorlevel% neq 0 (
    echo ERROR: iOS build failed
    exit /b 1
)

echo.
echo ============================================
echo Build completed successfully!
echo ============================================
echo.
echo The iOS app has been built at:
echo build\ios\iphoneos\Runner.app
echo.
echo To create an IPA file, you'll need to:
echo 1. Open ios\Runner.xcworkspace in Xcode
echo 2. Configure code signing (or use --no-codesign for development)
echo 3. Archive and export the IPA
echo.
echo For CodeMagic builds, push these changes and trigger a build.
exit /b 0
