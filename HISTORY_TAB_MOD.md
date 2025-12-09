# History Tab Modification for iOS

## Summary
Added the History tab to the phone/iOS navigation bar in Sorayomi. Previously, the History tab was only visible on tablets/large screens, while phone users had to access it through the "More" menu.

## Changes Made

### 1. navigation_bar_data.dart
**File**: `lib/src/constants/navigation_bar_data.dart`

**Change**: Added History tab to `phoneNavList` between Updates and Browse tabs.

```dart
// Before: 5 tabs - Library, Updates, Browse, Downloads, More
// After: 6 tabs - Library, Updates, History, Browse, Downloads, More

NavigationBarData(
  icon: Icons.history_outlined,
  activeIcon: Icons.history_rounded,
  label: (context) => context.l10n.history,
),
```

### 2. navigation_shell_screen.dart
**File**: `lib/src/widgets/shell/navigation_shell_screen.dart`

**Change**: Simplified index adjustment logic to treat phone and tablet navigation the same way.

```dart
// Before: Different logic for phone vs tablet with index skipping
// After: Unified navigation - both phone and tablet have History tab at index 2

int getAdjustedIndex(int index) {
  // Both phone and tablet now have same navigation:
  // Library(0), Updates(1), History(2), Browse(3), Downloads(4), More(5)
  return index;
}
```

## Navigation Structure

### Before
**Phone/iOS**: Library | Updates | Browse | Downloads | More
**Tablet**: Library | Updates | History | Browse | Downloads | More

### After
**Phone/iOS**: Library | Updates | **History** | Browse | Downloads | More
**Tablet**: Library | Updates | **History** | Browse | Downloads | More

## Building the Modified App

### Prerequisites
1. macOS with Xcode installed
2. Flutter SDK (version compatible with Sorayomi)
3. iOS development environment configured

### Build Steps

```bash
# 1. Navigate to the project directory
cd "C:\Users\blackbox\Nextcloud\vibe codes\bertha server management\mangapiracy\sorayomi-fork"

# 2. Get Flutter dependencies
flutter pub get

# 3. Build for iOS (requires macOS)
flutter build ios --release

# 4. For iOS Simulator
flutter run -d "iPhone 15 Pro"  # or your simulator device

# 5. For physical device via Xcode
# Open ios/Runner.xcworkspace in Xcode
# Select your team and provisioning profile
# Build and run to your device
```

### Alternative: Build IPA for Direct Installation

```bash
# Build IPA file
flutter build ipa --release

# IPA will be at: build/ios/ipa/Sorayomi.ipa
```

### Installing on iPhone

#### Option 1: Via Xcode
1. Open `ios/Runner.xcworkspace` in Xcode
2. Connect your iPhone
3. Select your iPhone as the target device
4. Click Run (⌘R)

#### Option 2: Via AltStore / Sideloadly
1. Build the IPA: `flutter build ipa --release`
2. Use AltStore or Sideloadly to install the IPA
3. Trust the certificate in Settings → General → VPN & Device Management

#### Option 3: Via TestFlight (if you have Apple Developer account)
1. Archive the app in Xcode
2. Upload to App Store Connect
3. Add to TestFlight
4. Install via TestFlight app on iPhone

## Testing the Changes

### What to Test
1. ✅ History tab appears in bottom navigation on iPhone
2. ✅ History tab shows reading history from Suwayomi server
3. ✅ Tapping on history items opens the manga/chapter
4. ✅ All other tabs still work correctly
5. ✅ Navigation indices are correct (no tab confusion)

### Expected Behavior
- History tab shows manga chapters you've read, grouped by date
- Same data as the web UI's History tab
- Syncs with your Suwayomi server at https://bertha.tail4a794.ts.net:4567

## Files Modified
- `lib/src/constants/navigation_bar_data.dart` - Added History to phone navigation
- `lib/src/widgets/shell/navigation_shell_screen.dart` - Updated index logic

## No Additional Code Needed
All History functionality was already implemented in Sorayomi:
- ✅ History data model (`lib/src/features/history/domain/`)
- ✅ History repository with API calls (`lib/src/features/history/data/`)
- ✅ History screen UI (`lib/src/features/history/presentation/`)
- ✅ History widgets (`lib/src/features/history/presentation/widgets/`)

The only change needed was **exposing the existing History tab on phone/iOS**.

## Reverting Changes
To revert to original behavior (History only on tablets):

```bash
git checkout HEAD -- lib/src/constants/navigation_bar_data.dart
git checkout HEAD -- lib/src/widgets/shell/navigation_shell_screen.dart
```

## Notes
- This modification maintains all existing functionality
- No breaking changes to other features
- Compatible with your Suwayomi server setup
- History syncs automatically with server
