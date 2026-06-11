import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nexus/modules/auth/login_screen/login_screen.dart';
import 'package:nexus/modules/home_layout/home_page.dart';
import 'package:nexus/shared/components/app_cache.dart';
import 'package:nexus/shared/components/bloc/my_bloc_observer.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';
import 'package:nexus/shared/network/remote/firebase_cloud_messaging_manager.dart';
import 'package:nexus/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modules/home_layout/cubit/home_cubit.dart';

// TODO: This message handling code would be removed or extracted in future commits
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Environment variables for securing API keys in dev builds [not production]
  await dotenv.load(fileName: "lib/secrets.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  String? userId = await SharedPreferencesHelper.getString(userIdKey);
  // FCM
  await AppCache().init();
  requestNotificationPermission();
  setupInteractedMessage();
  FirebaseCloudMessagingManager.init(
    serviceAccountCredentials: dotenv.env['FCM_ACCOUNT_CREDENTIALS_URI']!,
  );

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: (userId == null) ? LoginScreen() : HomePage(),
      ),
    );
  }
}

void requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

Future setupInteractedMessage() async {
  // Get any messages which caused the application to open from a terminated state.
  RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage()
      .then((value) {
        print('Got first notification');
      })
      .catchError((error) {});

  // Also handle any interaction when the app is in the background using a Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('Got notification from back and opened app');
  });

  // handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // handle messages when application is terminated
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
