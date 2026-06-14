import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nexus/models/cloud_message.dart';
import 'package:nexus/modules/auth/login_screen/login_screen.dart';
import 'package:nexus/modules/home_layout/home_page.dart';
import 'package:nexus/modules/other/notifications_screen/notifications_screen.dart';
import 'package:nexus/shared/components/bloc/my_bloc_observer.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';
import 'package:nexus/shared/network/remote/firebase_cloud_messaging_manager.dart';
import 'package:nexus/shared/network/remote/local_notification_service.dart';
import 'package:nexus/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modules/home_layout/cubit/home_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
  LocalNotificationsService localNotificationsService =
      LocalNotificationsService.instance();
  localNotificationsService.init();
  FirebaseCloudMessagingManager.init(
    serviceAccountCredentials: dotenv.env['FCM_ACCOUNT_CREDENTIALS_URI']!,
    localNotificationsService: localNotificationsService,
    navigatorKey: navigatorKey,
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
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: (userId == null) ? LoginScreen() : HomePage(),
        routes: {
          CloudMessageType.postLike.name: (context) =>
              const NotificationsScreen(),
        },
      ),
    );
  }
}
