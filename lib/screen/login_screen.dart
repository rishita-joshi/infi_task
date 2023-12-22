import 'package:api_task_glogin/model/user_model.dart';
import 'package:api_task_glogin/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool isLogin = false;
  List<UserModelClass> userModelClass = [];

  @override
  void initState() {
    getLoginUserAPi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Enter Email Address"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter Password"),
              ),
              ElevatedButton(
                  onPressed: () {
                    logInUser();
                  },
                  child: isLogin
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                      : Text("Login")),
              ElevatedButton(
                  onPressed: () {
                    logInWithGoogleAccount();
                  },
                  child: Text("Login With Google "))
            ],
          ),
        ),
      ),
    );
  }

  void logInUser() {
    if (loginFormKey.currentState!.validate()) {
      userModelClass.where((element) {
        element.email!.toLowerCase() == emailController.text.toLowerCase();
        print("You can Login");
        return true;
      });
    }
  }

  void logInWithGoogleAccount() {
    AuthService().googleSignIn().then((value) => {
          if (value.user!.uid.isNotEmpty)
            {
              print("google Login successFully"),
            }
        });
  }

  void getLoginUserAPi() async {
    ApiService().getUser().then((value) {
      userModelClass.addAll(value);
      print(userModelClass);
    });
  }
}
