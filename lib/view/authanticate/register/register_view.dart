import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/authanticate/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final controllerName = TextEditingController();
  final controllerSurname = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerAdress = TextEditingController();
  final controllerPhoneNumber = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? e;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      "Kayıt olmak için aşağıdaki formu doldurunuz.",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  spacer,
                  CustomTextField(
                    hintText: "Name",
                    myController: controllerName,
                  ),
                  spacer,
                  CustomTextField(
                    hintText: "Surname",
                    myController: controllerSurname,
                  ),
                  spacer,
                  CustomTextField(
                    hintText: "address",
                    myController: controllerAdress,
                  ),
                  spacer,
                  CustomTextField(
                    hintText: "email",
                    myController: controllerEmail,
                  ),
                  spacer,
                  CustomTextField(
                    hintText: "phone number",
                    myController: controllerPhoneNumber,
                  ),
                  spacer,
                  CustomTextField(
                    hintText: "password",
                    myController: controllerPassword,
                  ),
                  spacer,
                  ElevatedButton(
                    onPressed: () {
                      e = AuthOperations().signUp(
                              controllerEmail.text, controllerPassword.text)
                          as String?;
                      print("user : " + e.toString());
                      //TODO: kayıt olurken ekstra veri eklenecek
                      // NetworkService().signUp(controllerName.text,p
                      //     controllerEmail.text, controllerPassword.text);
                      // PSconnect().addCustomer(
                      //     name: controllerName.text,
                      //     surname: controllerSurname.text,
                      //     phoneNumber: controllerPhoneNumber.text,
                      //     email: controllerEmail.text,
                      //     address: controllerAdress.text);
                    },
                    child: const Text("register"),
                  )
                ],
              ),
              TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, "/loginView"),
                child: Text(
                    "Eğer bir hesabınız var ise giriş yapmak için buraya tıklayın."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get spacer => const SizedBox(height: 16);
}
