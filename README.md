<div align="center">

# 💬 Convo

### Real-Time Cross-Platform Chat Application

[![Flutter](https://img.shields.io/badge/Flutter-3.2.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

_Connect with friends instantly across Android and iOS devices_

</div>

---

## 📖 About

**Convo** is a modern, cross-platform messaging application built with Flutter and powered by Firebase. It delivers seamless real-time communication with a beautiful, intuitive interface that works consistently across Android and iOS platforms. Find your friends by username and stay connected wherever you go!

## ✨ Key Features

🔐 **Secure Authentication**

- Email and password-based registration
- Firebase Authentication integration
- Persistent user sessions
- Username-based user profiles

💬 **Real-Time Messaging**

- Instant message delivery with Firebase Firestore
- Live synchronization across all devices
- Message timestamps and sender information
- Chat room management

👥 **User Discovery**

- Search users by username
- Easy-to-use friend finder
- Direct messaging capabilities

📱 **Cross-Platform Support**

- Native Android application
- Native iOS application
- Consistent UI/UX across platforms
- Responsive design for all screen sizes

## 🛠️ Tech Stack

- **Framework:** Flutter (SDK 3.2.0+)
- **Backend:** Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Core
- **State Management:** Provider
- **Architecture:** Clean architecture with service layer separation

## 📦 Dependencies

```yaml
firebase_core: ^2.23.0
firebase_auth: ^4.14.1
cloud_firestore: ^4.13.2
provider: latest
cupertino_icons: ^1.0.2
```

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.2.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase CLI (optional, for Firebase configuration)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/danielwidhiarto/Convo.git
   cd Convo
   ```

2. **Install Flutter dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   a. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)

   b. Enable the following Firebase services:

   - Authentication (Email/Password)
   - Cloud Firestore

   c. Download configuration files:

   - **Android:** Download `google-services.json` and place it in `android/app/`
   - **iOS:** Download `GoogleService-Info.plist` and place it in `ios/Runner/`

   d. Run FlutterFire CLI (recommended):

   ```bash
   flutterfire configure
   ```

4. **Set up Firestore Database**

   Create the following collections in your Firebase Console:

   - `users` - Stores user profiles (uid, email, username)
   - `chat_rooms` - Stores chat conversations and messages

5. **Run the application**

   ```bash
   # For Android
   flutter run

   # For iOS (macOS only)
   flutter run -d ios

   # For specific device
   flutter devices
   flutter run -d <device-id>
   ```

## 📱 Usage Guide

### Registration

1. Launch the app
2. Tap "Register" or "Sign Up"
3. Enter your email, password, and desired username
4. Create your account

### Logging In

1. Enter your registered email and password
2. Tap "Sign In" to access your account

### Chatting

1. From the home page, search for users by username
2. Select a user to start a conversation
3. Type your message and send
4. Enjoy real-time messaging!

## 📂 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── firebase_options.dart     # Firebase configuration
├── components/               # Reusable UI components
│   ├── chat_bubble.dart     # Message bubble widget
│   ├── custom_button.dart   # Custom button component
│   └── text_field.dart      # Custom text field
├── model/                    # Data models
│   └── message.dart         # Message model
├── pages/                    # Application screens
│   ├── chat_page.dart       # Chat conversation screen
│   ├── home_page.dart       # Main home screen
│   ├── login_page.dart      # Login screen
│   └── register_page.dart   # Registration screen
└── services/                 # Business logic layer
    ├── auth/                # Authentication services
    │   ├── auth_gate.dart   # Auth state management
    │   ├── auth_services.dart
    │   └── login_or_register.dart
    └── chat/                # Chat services
        └── chat_service.dart
```

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Contribution Guidelines

- Follow Flutter's style guide
- Write clear commit messages
- Add tests for new features
- Update documentation as needed

## 🐛 Bug Reports & Feature Requests

Found a bug or have a feature suggestion? We'd love to hear from you!

- **Issues:** [GitHub Issues](https://github.com/danielwidhiarto/Convo/issues)
- Please check existing issues before creating a new one
- Provide detailed information and steps to reproduce bugs

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Daniel Widhiarto**

- GitHub: [@danielwidhiarto](https://github.com/danielwidhiarto)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend infrastructure
- All contributors who help improve this project

---

<div align="center">

**Made with ❤️ using Flutter**

_If you find this project helpful, please consider giving it a ⭐_

</div>
