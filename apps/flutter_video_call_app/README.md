# Flutter Starter Repo

A starter Flutter project with **Login** and **Users list** features implemented using:

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management
- [dio](https://pub.dev/packages/dio) for networking
- [hive](https://pub.dev/packages/hive) for local caching
- [get_it](https://pub.dev/packages/get_it) for dependency injection

---

## 📂 Features
- **Login Screen**
    - Mock API using [ReqRes](https://reqres.in/)
    - Email + Password validation
    - Stores auth token in memory (extend with secure storage for prod)
- **Users Screen**
    - Fetches list of users from ReqRes API
    - Displays avatar, name, and email
    - Caches users locally in Hive for offline use

---

## 🚀 Getting Started

### 1. Clone & Install
```bash
git clone <your_repo_url>
cd flutter_starter_repo
flutter pub get
```

### 2. Run the App
```bash
flutter run
```

---

## 📱 Default Login Credentials
The login page is prefilled with ReqRes test credentials:

- **Email:** `eve.holt@reqres.in`
- **Password:** `cityslicka`

---

## 📦 Folder Structure
```
lib/
│ main.dart
│ injection.dart
│
├── core/              # core utils (Dio, error handling)
├── features/
│   ├── auth/          # Login feature (Bloc + Repo)
│   └── users/         # Users feature (Bloc + Repo + Hive caching)
```

---

## 🛠 Next Steps / Improvements
- Add `flutter_secure_storage` for storing auth token securely
- Add unit tests for blocs and repositories
- Add logout functionality
- Extend ReqRes mock to more endpoints or connect to real backend

---

## 📝 License
This project is for learning/demo purposes only.
