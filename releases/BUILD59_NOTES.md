# Build 59 Release Notes

## Status: ⚠️ Known Issue - "No Sources Found" on iOS

### Build Information
- **Build Number:** 59
- **Date:** 2026-02-01
- **Type:** Unsigned IPA for TrollStore/Sideloading

### Files Included
- `Sorayomi-unsigned-build59.ipa` - The iOS application (10.7 MB)
- `build59-artifacts.zip` - Build logs and artifacts

### Changes Made Since Build 58
1. **Fixed GraphQL code generation in Codemagic build**
   - Added post-build verification for critical GraphQL files
   - Build now fails early if `fragment.graphql.dart` or `query.graphql.dart` are missing
   - Removed broken two-pass build approach (build-filter doesn't work as expected)

2. **Updated critical file verification**
   - Corrected path for `fragment.graphql.dart` (it's in `domain/source/graphql/`, not `data/source_repository/graphql/`)
   - Added `SourceDto` typedef resolution check

### Known Issue: "No Sources Found" on iOS Browse Tab
**Status:** 🔴 **STILL PRESENT IN BUILD 59**

The issue persists despite build configuration fixes. The root cause is that `fragment.graphql.dart` is **not being generated** by the build process.

#### Investigation Results

From the build log analysis:
```
[INFO] Succeeded after 33.5s with 302 outputs (2049 actions)
```

The build_runner reports success with 302 outputs, but the fragment file is missing.

#### Root Cause
The `fragment.graphql` file exists at:
```
lib/src/features/browse_center/domain/source/graphql/fragment.graphql
```

But the generated file `fragment.graphql.dart` is **not being created** in:
```
lib/src/features/browse_center/domain/source/graphql/__generated__/
```

This causes `SourceDto = Fragment$SourceDto` typedef in `source_model.dart` to fail, resulting in the Sources list being empty.

#### Files Required for Sources Feature
| File | Status | Path |
|------|--------|------|
| `query.graphql.dart` | ✅ Generated | `data/source_repository/graphql/__generated__/` |
| `fragment.graphql.dart` | ❌ **MISSING** | `domain/source/graphql/__generated__/` |
| `schema.graphql.dart` | ✅ Generated | `lib/src/graphql/__generated__/` |

#### Next Steps to Fix
1. **Check graphql_codegen configuration** - The `build.yaml` has `fragments_glob: "lib/**/*.graphql"` which should find all fragments
2. **Verify fragment.graphql syntax** - Ensure the fragment definition is valid GraphQL
3. **Check for build_runner cache issues** - May need to clear `.dart_tool/build/` completely
4. **Consider manual generation** - Run `flutter pub run build_runner build` locally to see if fragments generate

### How to Test This Build
1. Install via TrollStore or sideload with AltStore/Sideloadly
2. Configure server URL: `https://yakubscave.tail4a794.ts.net:4567/`
3. Navigate to Browse tab → Sources
4. **Expected:** List of manga sources
5. **Actual:** "No sources found" message

### Debug Information
Check `build_runner.log` in artifacts for detailed generation output.

---
**Note:** This build is for testing purposes. The "No Sources Found" issue is a known blocker that requires further investigation into the GraphQL code generation.
