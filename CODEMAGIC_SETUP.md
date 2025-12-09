# Building Modified Sorayomi with Codemagic

## Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Name it: `sorayomi-history-mod` (or any name you prefer)
3. Make it **Public** (required for Codemagic free tier)
4. Don't initialize with README (we already have code)
5. Click "Create repository"

## Step 2: Push Your Modified Code to GitHub

Open Git Bash or Terminal in the sorayomi-fork directory and run:

```bash
cd "C:\Users\blackbox\Nextcloud\vibe codes\bertha server management\mangapiracy\sorayomi-fork"

# Initialize git (if not already)
git init

# Add all files
git add .

# Commit changes
git commit -m "Add History tab to iOS navigation - Modified for phone/iOS"

# Add your GitHub repository as remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/sorayomi-history-mod.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 3: Sign Up for Codemagic

1. Go to https://codemagic.io/signup
2. Sign up with your GitHub account (easiest)
3. Authorize Codemagic to access your repositories

## Step 4: Add Your App to Codemagic

1. Click "Add application" in Codemagic dashboard
2. Select your repository: `sorayomi-history-mod`
3. Choose "Flutter App" as the project type
4. Click "Finish: Add application"

## Step 5: Configure Build Settings

### Option A: Using codemagic.yaml (Already Configured)

The `codemagic.yaml` file is already in the repository. Codemagic will detect it automatically.

**Important**: You'll need to configure code signing:

1. In Codemagic, go to your app settings
2. Navigate to "iOS code signing"
3. Choose one of these options:

   **Option 1: Development Build (No Apple Developer Account Needed)**
   - Select "Development" distribution type
   - Codemagic will generate a development certificate
   - This IPA can only be installed on devices you register

   **Option 2: Ad Hoc Distribution (Requires Apple Developer Account - $99/year)**
   - You'll need Apple Developer account credentials
   - Codemagic can auto-manage signing
   - Can install on up to 100 registered devices

### Option B: Using Workflow Editor (If yaml fails)

1. Go to "Build" tab
2. Click "Start your first build"
3. Select "Flutter workflow editor"
4. Configure:
   - **Flutter version**: Stable
   - **Xcode version**: Latest
   - **Build mode**: Release
   - **Build iOS**: Yes
   - **Build Android**: No (optional, can keep enabled)

## Step 6: Configure Code Signing (IMPORTANT)

### For Development Build (Easiest - No Cost):

1. Go to "App settings" → "iOS code signing"
2. Select "Automatic code signing"
3. Choose "iOS App Development"
4. Codemagic will generate a development certificate

**Note**: Development builds can only be installed on your specific device after you register it in Codemagic.

### To Register Your iPhone:

1. Get your device UDID:
   - Connect iPhone to computer
   - Open iTunes/Finder
   - Click on device, click on serial number to show UDID
   - Copy the UDID
2. In Codemagic, go to "Teams" → "Devices"
3. Click "Add device"
4. Paste UDID and give it a name
5. Save

## Step 7: Start the Build

1. Go to "Builds" tab
2. Click "Start new build"
3. Select branch: `main`
4. Click "Start new build"

The build will take about 15-20 minutes.

## Step 8: Download Your IPA

1. Once build completes successfully (green checkmark)
2. Click on the build
3. Go to "Artifacts" section
4. Download the `.ipa` file
5. Save it to: `C:\Users\blackbox\Nextcloud\vibe codes\bertha server management\mangapiracy\sorayomi-fork\`

## Step 9: Install on Your iPhone

### Option A: Using AltStore (Free)

1. Download AltStore: https://altstore.io/
2. Install AltServer on your PC
3. Connect iPhone to PC
4. Open AltStore on iPhone
5. Click "+" and select your downloaded IPA
6. AltStore will sideload it to your iPhone

### Option B: Using Sideloadly (Free)

1. Download Sideloadly: https://sideloadly.io/
2. Connect iPhone to PC
3. Drag your IPA into Sideloadly
4. Enter your Apple ID (used for signing, not stored)
5. Click "Start"

### Option C: Using Xcode (If you have a Mac)

1. Open Xcode
2. Go to Window → Devices and Simulators
3. Connect your iPhone
4. Drag the IPA file onto your device
5. Trust the certificate on iPhone (Settings → General → VPN & Device Management)

## Important Notes

### Free Tier Limitations:
- 500 build minutes per month (plenty for this)
- Public repositories only
- 1 concurrent build

### Code Signing Without Apple Developer Account:
- Development builds work without paid account
- Limited to devices you explicitly register
- Need to re-sign every 7 days (with free Apple ID)

### With Apple Developer Account ($99/year):
- Can create Ad Hoc or App Store builds
- Ad Hoc works on 100+ devices
- No 7-day re-signing needed

## Troubleshooting

### Build Fails with "No matching provisioning profiles found"
- Make sure you configured code signing in Step 6
- Try switching to "Development" distribution type

### Can't Install IPA on iPhone
- If using development build, ensure your device UDID is registered
- Check that you trusted the certificate on iPhone
- Try re-installing with AltStore/Sideloadly

### Build Takes Too Long
- First build might take 20-30 minutes (downloading dependencies)
- Subsequent builds are faster (5-10 minutes)

## Alternative: Pre-built Sorayomi + Manual Patching

If Codemagic doesn't work or you don't want to deal with code signing:

1. Download official Sorayomi from: https://github.com/Suwayomi/Tachidesk-Sorayomi/releases
2. Install it
3. When you get access to a Mac, apply the changes and rebuild

The official app works great - you just won't have the History tab in the main navigation (it'll be under More → History instead).

## Summary

**Easiest Path for You:**
1. Push code to GitHub (5 minutes)
2. Sign up for Codemagic with GitHub (2 minutes)
3. Add repository and configure development build (5 minutes)
4. Start build (15-20 minutes automatic)
5. Download IPA and install with AltStore (5 minutes)

**Total time: ~30-40 minutes** (mostly waiting for build)

No Apple Developer account needed if you use Development distribution!
