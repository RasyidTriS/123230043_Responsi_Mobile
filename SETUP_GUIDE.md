# 🚀 SETUP GUIDE - STREAMHUB APP

## Prerequisites ✅

Pastikan Anda sudah memiliki:
- ✅ Flutter SDK installed (3.11.5 atau lebih baru)
- ✅ Dart SDK included in Flutter
- ✅ Android Studio / Xcode (untuk emulator)
- ✅ Emulator Android atau iOS

## Step 1: Navigate ke Project Directory

```bash
cd /Users/mymac/Downloads/Latihan\ Responsi/latihan_responsi
```

## Step 2: Get Dependencies

```bash
flutter pub get
```

Expected output:
```
Resolving dependencies...
Getting packages...
Changed XX dependencies!
```

## Step 3: Verify Installation

```bash
flutter doctor
```

Pastikan semua dependency checks bersatus ✓

## Step 4: List Available Devices

```bash
flutter devices
```

Contoh output:
```
2 connected devices:

Android SDK built for x86 (mobile) • emulator-5554 • android-x86 • Android 13
iPhone 14 Pro (mobile)             • 6A1E0C7D-... • ios      • iOS 16.4
```

## Step 5: Run Aplikasi

### Option A: Run di Default Device
```bash
flutter run
```

### Option B: Run di Specific Device
```bash
flutter run -d emulator-5554
# atau
flutter run -d "iPhone 14 Pro"
```

### Option C: Run Release Build (Faster)
```bash
flutter run --release
```

## Step 6: Login Demo

Setelah aplikasi running:

1. Lihat login page
2. Masukkan credentials:
   - Username: **`demo`**
   - Password: **`demo123`**
   - (atau gunakan username/password apapun)
3. Klik LOGIN
4. Aplikasi akan redirect ke Home Page

## Testing Features

### 1. Test Home Page
- Lihat daftar TV shows dalam GridView
- Lihat loading indicator saat first load
- Scroll untuk melihat lebih banyak shows
- Pull-to-refresh dengan drag ke atas

### 2. Test Detail Page
- Klik salah satu TV show card
- Lihat detail lengkap (poster, rating, genre, summary)
- Klik "ADD FAVORITE" button
- Lihat snackbar "Added to favorites"

### 3. Test Favorite Page
- Klik menu Favorite di bottom navigation
- Lihat daftar favorit Anda
- Klik remove untuk hapus favorite
- Klik show card untuk lihat detail

### 4. Test Profile Page
- Klik menu Profile di bottom navigation
- Lihat username Anda
- Lihat pesan kesan dan pesan
- Klik LOGOUT untuk keluar

### 5. Test Logout
- Setelah logout, akan kembali ke login page
- Semua favorites akan tetap tersimpan (Hive)
- Session sudah dihapus (SharedPreferences)

## Troubleshooting

### Issue: "flutter: command not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:~/flutter/bin"
```

### Issue: Emulator tidak terbuka
```bash
# Buka emulator secara manual
emulator -avd <emulator_name>
```

### Issue: "No devices found"
```bash
# Refresh devices
flutter devices --refresh
```

### Issue: Build error
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

### Issue: Hive error saat run
```bash
# Delete Hive cache
rm -rf /path/to/app/build/
flutter run
```

## Performance Tips

### Hot Reload
- Tekan `r` di terminal untuk hot reload (cepat)
- Tekan `R` untuk hot restart (slower tapi reset state)

### Debug Mode
- Jalankan dengan `--verbose` untuk debug info
```bash
flutter run -v
```

### Release Mode
- Lebih cepat dan smooth
```bash
flutter run --release
```

## Code Structure Quick Reference

```
🏠 Home Page → Grid of TV shows (API)
   └─ Detail Page → Show details + favorite button

❤️ Favorite Page → Saved shows (Hive)
   └─ Detail Page → Show details

👤 Profile Page → User info + logout

🔐 Login Page → Session management (SharedPreferences)
```

## API Information

- Base URL: `https://api.tvmaze.com`
- Endpoints:
  - Get Shows: `/shows` (paginated, up to 250)
  - Get Detail: `/shows/{id}`
- No authentication required
- Rate limit: No strict limit (reasonable use)
- Response time: Usually 1-2 seconds

## File Organization

```
lib/
├── main.dart                 # Entry point + routing
├── models/tv_show.dart       # Data model
├── services/
│   ├── auth_service.dart     # Login/session
│   ├── favorite_service.dart # Hive storage
│   └── tvmaze_service.dart   # API calls
├── pages/                    # UI Screens
└── widgets/                  # Reusable components
```

## Key Features Checklist

- ✅ Login dengan session
- ✅ Fetch dari real API (TVMaze)
- ✅ Local storage dengan Hive
- ✅ Dark theme modern
- ✅ Error handling
- ✅ Loading states
- ✅ Empty states
- ✅ Navigation flows
- ✅ Responsive design
- ✅ Clean code

## Next Steps (Optional Enhancement)

```dart
// Future enhancements:
- Add search functionality
- Add genre filtering
- Add pagination (currently loads 250 shows)
- Add watch history
- Add user ratings
- Add episode information
- Add actor/cast details
- Add show recommendations
```

## Support & Debugging

### Enable Verbose Logging
```bash
flutter run -v > debug.log 2>&1
```

### Check Flutter Version
```bash
flutter --version
```

### Verify All Tools
```bash
flutter doctor
```

### Clean Everything & Fresh Start
```bash
flutter clean
flutter pub get
flutter run
```

---

**Happy Coding! 🚀**

For more info, refer to:
- 📄 APP_DOCUMENTATION.md
- ✅ COMPLETION_CHECKLIST.md
- 📚 Flutter Docs: https://flutter.dev/docs
