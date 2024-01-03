import 'dart:async';

import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/authanticate/Login/login_view.dart';
import 'package:filo_fire/view/main_screen/home_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/car_list.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeView())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.car_repair, size: 250),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
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
              return const CarList();
            } else {
              return const LoginView();
            }
        }
      },
    );
  }
}
