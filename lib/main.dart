import 'package:filo_fire/network/auth_operations.dart';

import 'package:filo_fire/view/authanticate/Login/login_view.dart';
import 'package:filo_fire/view/authanticate/forgot_password/forgot_password_view.dart';
import 'package:filo_fire/view/authanticate/register/register_view.dart';
import 'package:filo_fire/view/authanticate/splash_screen/splash_view.dart';
import 'package:filo_fire/view/main_screen/home_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/car_list.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/car_info/AddCarView.dart';
//flutter library
import 'package:flutter/material.dart';
//firebase Library
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/tabView": (context) => const HomeView(),
        "/loginView": (context) => const LoginView(),
        "/registerView": (context) => const RegisterView(),
        "/forgotPasswordView": (context) => const ForgotPasswordView(),
        "/addCarView": (context) => const AddCarView(),
        "/carListView": (context) => const CarList(),
      },
      title: 'Filo-Fire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).copyWith(
        cardTheme: const CardTheme(color: Colors.red),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.amberAccent),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
          ),
        ),
        textTheme: const TextTheme().copyWith(
          bodyMedium: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
