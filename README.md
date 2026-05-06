# 💊 Pharmacist Smart Care

A Flutter-based pharmacy management system that allows users to browse products, search medicines, explore categories and companies, and manage orders.

---

## 📌 Prerequisites and Dependencies

### 🧠 Programming Language

* Dart SDK: `^3.11.0`

### 📱 Framework

* Flutter SDK (latest stable version)

---

### 📦 Main Dependencies

* **State Management**

  * `flutter_bloc`

* **Networking**

  * `dio`

* **Functional Programming**

  * `dartz`

* **Local Storage**

  * `shared_preferences`

* **Utilities**

  * `equatable`
  * `intl`
  * `jwt_decoder`

* **UI / UX**

  * `lottie`
  * `cached_network_image`
  * `animated_text_kit`
  * `convex_bottom_bar`
  * `line_icons`
  * `flutter_advanced_drawer`

* **Device Tools**

  * `image_picker`
  * `device_preview`

* **Splash & Icons**

  * `flutter_native_splash`
  * `flutter_launcher_icons`

---

## 💻 Required Software

* Flutter SDK
* Android Studio or VS Code
* Android SDK
* Git

---

## 🖥 System Requirements

* OS: Windows / macOS / Linux
* RAM: 8GB minimum (16GB recommended)
* Storage: 5GB free space

---

## 🌐 External Services

* REST APIs (used for authentication, products, orders, categories, companies, and search)

---

## ⚙️ Installation Steps

### 1. Clone the repository

```bash
git clone https://github.com/MarkAyman1/Pharmacist-Smart-Care.git
cd Pharmacist-Smart-Care
```

---

### 2. Install dependencies

```bash
flutter pub get
```

---

### 3. Configure Environment

Update API base URL inside:

```
lib/core/api/
```

Example:

```dart
static const String baseUrl = "https://smartcarepharmacy.tryasp.net/";
```

---

## 🧱 Compilation Steps

### Build APK

```bash
flutter build apk --release
```

### Build App Bundle

```bash
flutter build appbundle
```

---

## 🚀 Run Instructions

### Run the app

```bash
flutter run
```

### Run on specific device

```bash
flutter devices
flutter run -d <device_id>
```

---

## 🔧 Environment Setup & Configuration

### 1. Verify Flutter installation

```bash
flutter doctor
```

---

### 2. API Configuration

Make sure backend is running and API URL is correctly set.

---

### 3. Permissions (Android)

Add to `AndroidManifest.xml` if needed:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

---

## 📂 Project Structure

```
lib/
 ├── core/
 │    ├── api/
 │    ├── services/
 │    ├── styles/
 │    ├── theme/bloc/
 │    ├── widgets/
 │    ├── app_color.dart
 │    └── app_theme.dart
 │
 ├── features/
 │    ├── auth/
 │    ├── categories/
 │    ├── companies/
 │    ├── orders/
 │    ├── products/
 │    ├── search/presentation/
 │    ├── main/presentation/
 │    └── splash/
 │
 └── main.dart
```

---

## 🧠 Architecture

* Feature-based structure
* Bloc state management
* Clean separation between core and features
* API-driven using Dio

---

## 📌 Features

* 🔐 Authentication
* 🏠 Home Screen
* 🔎 Search
* 💊 Products
* 🏷 Categories
* 🏭 Companies
* 🛒 Orders
* 🎬 Splash Screen

---

## 📄 License

This project is for educational purposes.

---
