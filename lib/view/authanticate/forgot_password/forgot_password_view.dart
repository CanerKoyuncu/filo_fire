import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/authanticate/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const Center(
                    child: Text(
                      "Şifrenizi değiştirmek için lütfen üyeliğinize bağlı olan email hesabınızı giriniz",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  spacer,
                  CustomTextField(
                    myController: controllerEmail,
                    hintText: "Email",
                  ),
                  ElevatedButton(
                      onPressed: () {
                        AuthOperations().resetPassword(controllerEmail.text);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/loginView",
                          ModalRoute.withName("/loginView"),
                        );
                      },
                      child: const Text("Şifreyi Sıfırla"))
                ],
              ),
              TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, "/loginView"),
                child: const Text(
                    "Eğer bir hesabınız var ise giriş yapmak için buraya tıklayın."),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, "/registerView"),
                child: const Text(
                    "Hesabınız yok ise ve kayıt olmak istiyorsanız, buraya tıklayın."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get spacer => const SizedBox(height: 16);
}
