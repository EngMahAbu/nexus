// TODO: this service would be added or removed in future commits
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class LocalNotificationsService {
//   // private constructor
//   LocalNotificationsService._internal();
//
//   static final LocalNotificationsService _instance =
//       LocalNotificationsService._internal();
//
//   // factory to return singleton
//   factory LocalNotificationsService.instance() => _instance;
//
//   // main plugin instance
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//
//   final _androidInitializationSettings = AndroidInitializationSettings(
//     '@mipmap/ic_launcher',
//   );
//
//   final _androidChannel = AndroidNotificationChannel(
//     'channel_id',
//     'Channel Name',
//     description: "Android push notifications",
//     importance: Importance.max,
//   );
//
//   bool _isFlutterLocalNotificationInitialized = false;
//
//   int _notificationIdCounter = 0;
//
//   Future<void> init() async {
//     if (_isFlutterLocalNotificationInitialized) {
//       return;
//     }
//
//     // init
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     // combine platform-specific settings
//     final initializationSettings = InitializationSettings(
//       android: _androidInitializationSettings,
//     );
//
//     // Initialize plugin with settings and callback for notification taps
//     await _flutterLocalNotificationsPlugin.initialize(
//       settings: initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap in foreground
//         print('Foreground notification has been tapped: ${response.payload}');
//       },
//     );
//
//     // Create Android notification channel
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(_androidChannel);
//
//     // Mark initialization as complete
//     _isFlutterLocalNotificationInitialized = true;
//   }
//
//   /// Show a local notification with the given title, body, and payload.
//   Future<void> showNotification(
//     String? title,
//     String? body,
//     String? payload,
//   ) async {
//     // Android-specific notification details
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       _androidChannel.id,
//       _androidChannel.name,
//       channelDescription: _androidChannel.description,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     // // iOS-specific notification details
//     // const iosDetails = DarwinNotificationDetails();
//
//     // Combine platform-specific details
//     final notificationDetails = NotificationDetails(
//       android: androidDetails,
//       // iOS: iosDetails,
//     );
//
//     // Display the notification
//     await _flutterLocalNotificationsPlugin.show(
//       id: _notificationIdCounter++,
//       title: title,
//       body: body,
//       notificationDetails: notificationDetails,
//       payload: payload,
//     );
//   }
// }
