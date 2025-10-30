# Google Login Setup Guide

## ✅ Completed Implementation

### 1. API Integration
- **API URL**: `https://asad.binarybards.online/api/v1/auth/social-login`
- **Method**: POST
- **Body**:
  ```json
  {
    "appId": "<Google ID Token>",
    "deviceToken": "<Firebase FCM Token>"
  }
  ```

### 2. Files Created/Modified

#### Created Files:
- `lib/services/repository/auth_repository/google_login_api_controller.dart` - Google login API controller
- `lib/services/firebase_messaging/firebase_messaging_service.dart` - Firebase Messaging service for device token

#### Modified Files:
- `lib/services/repository/auth_repository/auth_repository.dart` - Added `googleLogin()` method
- `lib/screens/user_screens/user_auth_screens/user_sign_in_screen/controller/user_sign_in_button_controller.dart` - Updated `loginWithGoogle()` method
- `lib/controller_binders.dart` - Registered `GoogleLoginApiController`
- `lib/main.dart` - Added Firebase Messaging initialization
- `pubspec.yaml` - Added `firebase_messaging: ^16.0.2`

### 3. Architecture
```
User taps Google Login Button
    ↓
UserSignInButtonController.loginWithGoogle()
    ↓
1. Initialize Google Sign In
2. Get Google ID Token (appId)
3. Get Firebase Device Token
    ↓
GoogleLoginApiController.googleLoginApiCall()
    ↓
POST to /auth/social-login
    ↓
Response: accessToken, refreshToken, role
    ↓
Navigate to User Dashboard
```

---

## 🔧 Firebase SHA-1 Setup Required

### Why SHA-1 is Needed
SHA-1 fingerprint is required for Google Sign-In to work on Android. Without it, authentication will fail.

### Steps to Add SHA-1 to Firebase:

#### Step 1: Get Debug SHA-1 Key
Run this command in your project directory:
```bash
cd android
./gradlew signingReport
```

Or on Windows:
```bash
cd android
gradlew.bat signingReport
```

**Look for the debug SHA-1** in the output:
```
Variant: debug
Config: debug
Store: C:\Users\YourName\.android\debug.keystore
Alias: AndroidDebugKey
MD5: XX:XX:XX...
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
SHA-256: XX:XX:XX...
```

#### Step 2: Add SHA-1 to Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to **Project Settings** (⚙️ icon)
4. Scroll down to **Your apps**
5. Select your Android app
6. Click **Add fingerprint**
7. Paste the **SHA-1** key
8. Click **Save**

#### Step 3: Download Updated google-services.json
1. After adding SHA-1, download the new `google-services.json`
2. Replace the existing file at: `android/app/google-services.json`

#### Step 4: Get Release SHA-1 (For Production)
When building for release, you'll need the release SHA-1:

**If using upload keystore:**
```bash
keytool -list -v -keystore android/app/upload-keystore.jks -alias upload
```

**If using play store keystore:**
Get it from Google Play Console → Release Management → App Signing

Then add this SHA-1 to Firebase as well.

---

## 🔑 Server Client ID

The server client ID is already configured in the code:
```dart
serverClientId: '169457956060-bqt2bj3pnha0gog354568ggt8h5pgdc1.apps.googleusercontent.com'
```

### Where to Find/Update Server Client ID:
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project
3. Go to **APIs & Services** → **Credentials**
4. Look for **OAuth 2.0 Client IDs**
5. Find the **Web client** (not Android client)
6. Copy the **Client ID**

---

## 📱 Testing Google Login

### Before Testing, Make Sure:
- ✅ SHA-1 key is added to Firebase
- ✅ `google-services.json` is updated
- ✅ Google Sign-In is enabled in Firebase Authentication
- ✅ Dependencies are installed (`flutter pub get`)

### Test Flow:
1. Tap Google Sign-In button
2. Select Google account
3. App sends `appId` (ID token) and `deviceToken` to backend
4. Backend validates and returns tokens
5. Navigate to user dashboard

### Common Issues:

**Error: "Developer Error" or "10:"**
- ❌ SHA-1 not added to Firebase
- ❌ Wrong `google-services.json` file
- Solution: Follow SHA-1 setup steps above

**Error: "Network error occurred"**
- ❌ Backend API not responding
- ❌ Check API URL in `lib/constants/api_urls.dart`

**Error: "Failed to get Google ID token"**
- ❌ Google Sign-In not properly initialized
- ❌ Server Client ID incorrect

---

## 🚀 Next Steps

1. **Add SHA-1 to Firebase** (REQUIRED)
2. **Update google-services.json** (REQUIRED)
3. Test Google Login on physical device or emulator
4. Test with different Google accounts
5. Verify device token is being sent correctly
6. Check backend logs for successful authentication

---

## 📝 Code Usage Example

```dart
// In your sign-in screen, call:
await controller.loginWithGoogle();

// The method handles:
// - Google authentication
// - Getting ID token
// - Getting device token
// - API call to backend
// - Storing tokens locally
// - Navigation to dashboard
```

---

## 🔒 Security Notes

- ID token is sent as `appId` to backend
- Backend should validate the ID token with Google
- Device token is for push notifications
- Access and refresh tokens are stored securely using `SharedPreferences`

---

## 📞 Support

If you encounter issues:
1. Check Firebase Console for SHA-1 configuration
2. Verify `google-services.json` is up to date
3. Check backend logs for API errors
4. Verify server client ID is correct
