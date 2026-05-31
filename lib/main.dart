import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nexus/modules/auth/login_screen/login_screen.dart';
import 'package:nexus/modules/home_layout/home_page.dart';
import 'package:nexus/shared/components/bloc/my_bloc_observer.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';
import 'package:nexus/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modules/home_layout/cubit/home_cubit.dart';

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
