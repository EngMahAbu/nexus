import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:nexus/models/cloud_message.dart';
import 'package:nexus/shared/network/remote/local_notification_service.dart';

@pragma('vm:entry-point')
class FirebaseCloudMessagingManager {
  static late String serviceAccountCredentialsFileUri;
  static late String fcmToken;
  static late LocalNotificationsService _localNotificationsService;
  static late GlobalKey<NavigatorState> _navigatorKey;

  @pragma('vm:entry-point')
  static void init({
    required String serviceAccountCredentials,
    required LocalNotificationsService localNotificationsService,
    required GlobalKey<NavigatorState> navigatorKey,
  }) async {
    serviceAccountCredentialsFileUri = serviceAccountCredentials;
    _localNotificationsService = localNotificationsService;
    _navigatorKey = navigatorKey;

    await handleFcmToken();

    _requestPermission();

    // Register handler for background messages (app terminated)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listen for messages when the app is in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // Listen for notification taps when the app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Check for initial message that opened the app from terminated state
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _onMessageLaunchedApp(initialMessage);
    }
  }

  static Future<void> _requestPermission() async {
    // Request permission for alerts, badges, and sounds
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${result.authorizationStatus}');
  }

  /// Handles messages received while the app is in the foreground
  static void _onForegroundMessage(RemoteMessage message) {
    print('Foreground message received: ${message.data.toString()}');
    final remoteNotification = message.notification;
    if (remoteNotification != null) {
      // Display a local notification using the service
      _localNotificationsService.showNotification(
        remoteNotification.title,
        remoteNotification.body,
        message.data.toString(),
      );
    }
    // handleNotificationTap(message);
  }

  /// Handles notification taps when app is opened from a terminated state
  static void _onMessageLaunchedApp(RemoteMessage message) {
    print('Notification caused the app to open: ${message.data.toString()}');
    handleNotificationTap(message);
  }

  /// Handles notification taps when app is opened from the background
  static void _onMessageOpenedApp(RemoteMessage message) {
    print('Notification caused the app to open: ${message.data.toString()}');
    handleNotificationTap(message);
  }

  /// Background message handler (must be top-level function or static)
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print('Background message received: ${message.data.toString()}');
    handleNotificationTap(message);
  }

  static void handleNotificationTap(RemoteMessage message) {
    if (message.data['type'] == CloudMessageType.postLike.name) {
      _navigatorKey.currentState?.pushNamed(message.data['type']);
    }
  }

  static Future<void> handleFcmToken() async {
    FirebaseCloudMessagingManager.fcmToken =
        await FirebaseMessaging.instance.getToken() ?? "";

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
          FirebaseCloudMessagingManager.fcmToken = fcmToken;
          // await FirestoreManager.updateUserProfile(profile)
        })
        .onError((error) {
          print('Error refreshing FCM token: $error');
        });
  }

  static Future<String> getAccessToken() async {
    // Load service account key
    final String response = await rootBundle.loadString(
      serviceAccountCredentialsFileUri,
    );
    final Map<String, dynamic> accountCredentials = json.decode(response);

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    AutoRefreshingAuthClient client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(accountCredentials),
      scopes,
    );

    // Obtain the access token
    AccessCredentials credentials =
        await obtainAccessCredentialsViaServiceAccount(
          ServiceAccountCredentials.fromJson(accountCredentials),
          scopes,
          client,
        );

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  static Future<Response> sendNotification({
    // required String targetDeviceToken,
    required CloudMessage message,
  }) async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    final String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/social-nexus-flutter/messages:send';

    final Response response = await post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message.toMap()),
    );

    return response;
  }
}
