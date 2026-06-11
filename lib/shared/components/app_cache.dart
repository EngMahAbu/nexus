import 'package:firebase_messaging/firebase_messaging.dart';

class AppCache {
  // Private constructor
  AppCache._internal();

  // The single instance of this class
  static final AppCache _instance = AppCache._internal();

  // Factory constructor to return the same instance every time
  factory AppCache() => _instance;

  late String fcmToken;

  Future<void> init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
  }
}
