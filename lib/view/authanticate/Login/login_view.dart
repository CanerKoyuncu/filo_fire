import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/authanticate/widget/CustomTextField.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.network(
                        "http://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png"),
                  ),
                  const Center(
                    child: Text(
                      "Giriş yapmak için formu doldurunuz.",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  spacer,
                  CustomTextField(
                      myController: controllerEmail, hintText: "e-mail"),
                  spacer,
                  CustomTextField(
                      myController: controllerPassword, hintText: "password"),
                  ElevatedButton(
                      onPressed: () async {
                        print("user obj");
                        AuthOperations().signIn(context, controllerEmail.text,
                            controllerPassword.text);
                        Navigator.popAndPushNamed(context, "/tabView");
                      },
                      child: const Text("data"))
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/registerView"),
                child: const Text(
                    "Hesabınız yok ise ve kayıt olmak istiyorsanız, buraya tıklayın."),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, "/forgotPasswordView"),
                child: const Text("Şifrenizi unuttuysanız buraya tıklayın."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get spacer => const SizedBox(height: 16);
}
