// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables, avoid_print, file_names, must_be_immutable

import 'package:chat_app/Pages/Login_Page.dart';
import 'package:chat_app/Widgets/Custom_Form_Text_Field.dart';
import 'package:chat_app/Widgets/Custom_button.dart';
import 'package:chat_app/cubit/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/show_SnackBar.dart';
import 'chat_Page.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  String? password;
  bool isLoading = false;
  static String id = 'RegisterPage';
  GlobalKey<FormState> formKey = GlobalKey();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                    'assets/images/RedSus.png',
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
                        'Register',
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
                        BlocProvider.of<RegisterCubit>(context)
                            .registerUserAccount(
                                email: email!, password: password!);
                      } else {}
                    },
                    text: 'Register',
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
                            return LoginPage();
                          }));
                        },
                        child: const Text(
                          'Already have an account ?  ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
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
      ),
    );
  }

  Future<void> registerUserAccount() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
/*
try {
                        await registerUserAccount();
                        showSnackBar(
                            context, 'Success , Login into your account');
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, 'weak-password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, 'email exist , try again');
                        }
                      } catch (ex) {
                        showSnackBar(context, 'There was an error');
                      }
*/