# Installing Modified Sorayomi with TrollStore

## Why TrollStore is Perfect for This

- ✅ **No code signing needed** - TrollStore installs unsigned IPAs
- ✅ **No 7-day expiration** - Apps stay installed permanently
- ✅ **No computer needed** - Install directly on iPhone
- ✅ **No Apple ID needed** - No signing services required

## Prerequisites

1. **TrollStore installed** on your iPhone (using your existing setup)
2. **Codemagic account** (free tier is fine)

## Step 1: Build Unsigned IPA with Codemagic

### A. Set Up Codemagic
1. Go to https://codemagic.io/signup
2. Sign in with GitHub
3. Click "Add application"
4. Select `wetw0rks-c0ding/sorayomi-history-mod`
5. Choose "Flutter App"
6. Click "Finish: Add application"

### B. Configure Build (IMPORTANT - Skip Code Signing!)

Since TrollStore doesn't need signing, we can skip all code signing steps:

1. Codemagic will auto-detect the `codemagic.yaml` file
2. The config is already set up for unsigned builds with `--no-codesign`
3. No need to configure iOS code signing at all!

### C. Start Build

1. Go to "Builds" tab
2. Click "Start new build"
3. Select workflow: **"iOS Workflow for TrollStore"**
4. Select branch: `main`
5. Click "Start new build"

Build will take **15-20 minutes**.

### D. Download IPA

Once complete:
1. Click on the successful build
2. Go to "Artifacts" section
3. Download: **`Sorayomi-TrollStore.ipa`**
4. Save to: `C:\Users\blackbox\Nextcloud\vibe codes\bertha server management\mangapiracy\sorayomi-fork\`

## Step 2: Transfer IPA to iPhone

### Option A: AirDrop (Easiest if you have Mac)
1. AirDrop the IPA to your iPhone
2. Save to Files app

### Option B: Cloud Storage
1. Upload IPA to iCloud Drive, Dropbox, or Google Drive
2. Download on iPhone using the respective app
3. Save to Files app

### Option C: Direct Download (If you have web server)
1. Upload IPA to a web server you control
2. Open Safari on iPhone
3. Download the IPA
4. Save to Files app

### Option D: Via Nextcloud (You already have this!)
1. Upload `Sorayomi-TrollStore.ipa` to your Nextcloud
2. Open Nextcloud app on iPhone
3. Download the IPA
4. Share to Files app

## Step 3: Install with TrollStore

1. Open **Files** app on iPhone
2. Navigate to where you saved the IPA
3. Tap on `Sorayomi-TrollStore.ipa`
4. Tap **"Share"** button
5. Select **"TrollStore"** from share sheet
6. TrollStore will install it
7. Done! ✅

## Step 4: Launch and Connect

1. Open **Sorayomi** from home screen
2. Add your Suwayomi server:
   - URL: `https://bertha.tail4a794.ts.net:4567`
   - No authentication needed (based on your setup)
3. You'll now see the **History tab** in the bottom navigation!

## Verification

Bottom navigation should show (in order):
1. Library
2. Updates
3. **History** ← New!
4. Browse
5. Downloads
6. More

## What's Different from Official Sorayomi?

**Official Version:**
- Phone: Library | Updates | Browse | Downloads | More
- History hidden under "More" menu

**Your Modified Version:**
- Phone: Library | Updates | **History** | Browse | Downloads | More
- History is a main tab now!

## Advantages of TrollStore Method

- ✅ No code signing complexity
- ✅ No Apple Developer account needed
- ✅ No re-signing every 7 days
- ✅ Permanent installation
- ✅ No jailbreak detection issues
- ✅ All iOS features work normally

## If Build Fails

Common issues and fixes:

### "Workflow not found"
- Make sure you pushed the updated `codemagic.yaml`
- Refresh Codemagic dashboard
- Select the correct workflow in build settings

### "Build timed out"
- Increase max_build_duration in yaml
- Or just retry - sometimes network is slow

### "Pod install failed"
- This is usually automatic
- Retry the build

## Alternative: Build Locally on Mac (Future)

If you get access to a Mac later, you can build even faster:

```bash
git clone https://github.com/wetw0rks-c0ding/sorayomi-history-mod.git
cd sorayomi-history-mod
flutter pub get
flutter build ios --release --no-codesign
cd build/ios/iphoneos
mkdir Payload
cp -r Runner.app Payload/
zip -r ../../../Sorayomi-TrollStore.ipa Payload
```

Then install the IPA with TrollStore!

## Summary

1. **Codemagic builds unsigned IPA** (15-20 min, one-time setup)
2. **Transfer to iPhone** (via Nextcloud, AirDrop, etc.)
3. **Install with TrollStore** (tap and done)
4. **Enjoy History tab!** 🎉

No code signing headaches, no expiration, permanent install!
