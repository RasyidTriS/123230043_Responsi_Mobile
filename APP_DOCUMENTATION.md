# StreamHub - TV Show Streaming App

Aplikasi Flutter modern untuk streaming TV show dengan dark theme.

## 📱 Fitur Lengkap

### 1. **Authentication**
- Login page dengan username & password
- Session management menggunakan SharedPreferences
- Auto-login jika sudah ada session
- Logout functionality

### 2. **Home Page**
- Fetch daftar TV shows dari TVMaze API
- GridView dengan modern card design
- Poster image, title, dan rating
- FutureBuilder untuk loading state
- Pull-to-refresh functionality

### 3. **Detail Page**
- Fetch detail TV show dari API
- Tampilkan poster besar, judul, rating, genre, dan summary
- Clean HTML tags pada summary
- Add/Remove favorite dengan snackbar feedback
- Back button navigation

### 4. **Favorite Page**
- Hive local storage untuk favorites
- List view dengan poster dan info
- Remove favorite functionality
- Navigate ke detail page dari favorite
- Empty state widget

### 5. **Profile Page**
- Tampilkan username dari session
- Kesan dan pesan praktikum
- Avatar sederhana
- Logout button dengan confirmation dialog

### 6. **UI/UX**
- Dark theme modern (hitam dengan aksen merah)
- Rounded corners pada semua card
- Material 3 design
- Responsive layout
- Custom widgets reusable
- Splash screen built-in Flutter

## 🏗️ Struktur Project

```
lib/
├── main.dart                    # Entry point & routing
├── models/
│   └── tv_show.dart           # TV Show model
├── services/
│   ├── auth_service.dart       # Authentication logic
│   ├── favorite_service.dart   # Hive favorites management
│   └── tvmaze_service.dart     # TVMaze API client
├── pages/
│   ├── login_page.dart         # Login screen
│   ├── main_page.dart          # Main navigation dengan bottom bar
│   ├── home_page.dart          # TV shows list
│   ├── detail_page.dart        # TV show detail
│   ├── favorite_page.dart      # Favorite list
│   └── profile_page.dart       # User profile
└── widgets/
    └── custom_widgets.dart     # Reusable components
```

## 📦 Dependencies

```yaml
http: ^1.1.0                    # HTTP client untuk API
shared_preferences: ^2.2.2      # Session storage
hive: ^2.2.3                    # Local database
hive_flutter: ^1.1.0            # Hive Flutter integration
path_provider: ^2.1.1           # File path utilities
```

## 🚀 Cara Menjalankan

### 1. Setup Dependencies
```bash
flutter pub get
```

### 2. Run Aplikasi
```bash
# On emulator/device
flutter run

# On specific device
flutter run -d <device-id>

# Release mode
flutter run --release
```

### 3. Login Demo
```
Username: demo
Password: demo123
(atau gunakan username & password apapun)
```

## 🎯 API Endpoints

- **List Shows**: `https://api.tvmaze.com/shows`
- **Show Detail**: `https://api.tvmaze.com/shows/{id}`

## ✨ Highlights

✅ Clean code dengan separation of concerns
✅ No GetX - menggunakan Navigator biasa
✅ Null safety
✅ ErrorHandling dengan snackbar & error widgets
✅ Loading indicators dengan smooth transitions
✅ Empty states design
✅ Responsive untuk semua screen sizes
✅ Async/await patterns
✅ FutureBuilder untuk API calls
✅ StateManagement dengan StatefulWidget

## 🎨 Theme Colors

- **Primary**: Colors.red (#FF0000)
- **Background**: Colors.black (#000000)
- **Secondary**: Colors.grey[900] (#121212)
- **Accent**: Colors.yellow (untuk rating)

## 🔐 Null Safety

Semua code 100% null safe dengan proper type handling.

## 📝 Notes

- Image null handling dengan placeholder
- HTML tag cleaning pada summary
- Session persistence dengan SharedPreferences
- Local storage dengan Hive untuk offline favorites
- Network timeout handling (10 seconds)
- Proper async/await patterns

## 🎬 Next Steps (Optional)

Untuk enhancement lebih lanjut:
- Add search functionality
- Add filtering by genre
- Add pagination
- Add watch history
- Add user ratings
- Add cast information
- Add episode list per season

---

**Created with Flutter 3.x**
**Dark Theme Modern Design**
**Production Ready Code**
