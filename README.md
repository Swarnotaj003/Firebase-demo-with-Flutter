# 🔥 Firebase Demo with Flutter

This `Flutter` project is a complete tutorial demonstrating how to integrate `Firebase Authentication` and `Cloud Firestore` in a Flutter app. It also showcases `state management using Provider`, making it easy to manage user and database states across the app.


## Features

### Firebase Authentication
- **User Registration** (Email & Password)
- **Login** and **Logout**
- **Validation with feedback using SnackBars**

### Firestore Integration
- **Add New Items** (with ID, name, and category)
- **View Item List** (real-time updates)
- **Delete Items** (with confirmation dialog)
- **Basic Dashboard Stats**
  - Total Item Count
  - Simple Revenue Estimation (₹100/item)

### State Management
- **Provider** for real-time item list sync with Firestore
- Clean separation of UI and business logic using service classes



## Firebase Configuration
Install FlutterFire from [FlutterFire docs](https://firebase.flutter.dev/docs/overview/).

Enter this command to generate a file called `lib/firebase_options.dart` that contains your **Google API key** and project info.
```
# Run the `configure` command, select a Firebase project and platforms
flutterfire configure
```


## Credits
This tutorial was created to help developers get started with Firebase in Flutter using modern practices.
Feel free to fork, clone, and build on it!

Happy Coding! 🚀