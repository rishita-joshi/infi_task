import 'package:api_task_glogin/main.dart';
import 'package:api_task_glogin/model/user_model.dart';
import 'package:api_task_glogin/screen/home_screen.dart';
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
                controller: emailController,
                decoration: InputDecoration(hintText: "Enter Email Address"),
              ),
              TextField(
                controller: passwordController,
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
    for (int i = 0; i < userModelClass.length; i++) {
      if (userModelClass[i].email!.trim().toLowerCase() ==
          emailController.text.trim().toLowerCase()) {
        print("ypu can login");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }

  void logInWithGoogleAccount() {
    var tokenId;
    AuthService().googleSignIn().then((value) => {
          if (value.user != null)
            {
              tokenId = (value.user!.getIdToken() ?? "") as String?,

              print("accesss token ==> ${tokenId}"),
              //  prefs.setString("token", value.user!.uid.toString()),
              print("===>"),
              print(value.user!.uid),
              // print(value.uid.toString()),
              print("google Login successFully"),
            }
        });
  }

  void getLoginUserAPi() {
    ApiService().getUser().then((value) {
      setState(() {
        userModelClass.addAll(value);
      });
      //  print(userModelClass.toList());
    });
  }
}
