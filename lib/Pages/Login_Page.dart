// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:chat_app/Pages/Register_Page.dart';
import 'package:chat_app/Pages/chat_Page.dart';
import 'package:chat_app/Widgets/Custom_Text_Field.dart';
import 'package:chat_app/Widgets/Custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/show_SnackBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'Login Page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/PinkSus.png',
                  width: 225,
                  height: 250,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'The Chat App',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomFormTextField(
                  hintText: 'Email',
                  onChange: (dataE) {
                    email = dataE;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomFormTextField(
                  obscureText: true,
                  hintText: 'Password',
                  onChange: (dataP) {
                    password = dataP;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUserAccount();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      child: const Text(
                        'Don\'t have an account ?  ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUserAccount() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
// // ignore_for_file: file_names

// import 'package:chat_app/Pages/Register_Page.dart';
// import 'package:chat_app/Widgets/Custom_Text_Field.dart';
// import 'package:chat_app/Widgets/Custom_button.dart';
// import 'package:flutter/material.dart';
// import '../constants.dart';

// class LoginPage extends StatelessWidzget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: ListView(
//           children: [
//             const SizedBox(
//               height: 25,
//             ),
//             Image.asset(
//               'assets/images/PinkSus.png',
//               width: 225,
//               height: 250,
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'The Chat App',
//                   style: TextStyle(
//                       fontSize: 32,
//                       color: Colors.white,
//                       fontFamily: 'pacifico'),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Row(
//               children: [
//                 Text(
//                   'Login',
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             CustomTextField(hintText: 'Email'),
//             const SizedBox(
//               height: 15,
//             ),
//             CustomTextField(hintText: 'Password'),
//             const SizedBox(
//               height: 25,
//             ),
//             CustomButton(
//               text: 'Login',
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Don\'t have an account ?  ',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, RegisterPage.id);
//                   },
//                   child: const Text(
//                     'Register',
//                     style: TextStyle(color: Color(0xffC7EDE6)),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
