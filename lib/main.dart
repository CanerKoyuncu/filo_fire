import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/main_screen/tabs/add_car/AddCarView.dart';
import 'package:filo_fire/view/authanticate/Login/login_view.dart';
import 'package:filo_fire/view/authanticate/forgot_password/forgot_password_view.dart';
import 'package:filo_fire/view/authanticate/register/register_view.dart';
import 'package:filo_fire/view/main_screen/tab_view.dart';
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
        "/tabView": (context) => const CustomTabView(),
        "/loginView": (context) => const LoginView(),
        "/registerView": (context) => const RegisterView(),
        "/forgotPasswordView": (context) => const ForgotPasswordView(),
        "/addCarView": (context) => const AddCarView(),
      },
      title: 'Flutter - Parse Server',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).copyWith(
        cardTheme: CardTheme(color: Colors.red),
        appBarTheme: AppBarTheme(backgroundColor: Colors.amberAccent),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
        )),
      ),
      home: FutureBuilder<dynamic>(
        future: AuthOperations().isLoggedIn(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            default:
              if (snapshot.data == true) {
                return const CustomTabView();
              } else {
                return const LoginView();
              }
          }
        },
      ),
    );
  }
}
