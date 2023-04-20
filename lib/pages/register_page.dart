import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constans.dart';
import '../helper/snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custon_text_feild.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 75.0,
                      ),
                      Image.asset('assets/images/scholar.png'),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      const SizedBox(
                        height: 75.0,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      CustomTextField(
                        labelText: 'First Name',
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      CustomTextField(
                        labelText: 'Last Name',
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      CustomTextField(
                        labelText: 'Email',
                        onChange: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      CustomTextField(
                        labelText: 'Password',
                        obSecure: true,
                        onChange: (data) {
                          password = data;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomButton(
                        onTap: () async {
                          if(formKey.currentState!.validate())
                            {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await registerUser();
                                Navigator.pushNamed(
                                  context,
                                  ChatPage.id,
                                  arguments: email,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  snackBar(context , 'weak-password');
                                } else if (e.code == 'email-already-in-use') {
                                  snackBar(context, 'Email already exists');
                                }
                              } catch (e) {
                                snackBar(context, e.toString());
                              }
                              isLoading = false;
                              setState(() {});
                              snackBar(context, 'Success');
                            }else {}
                            },
                        text: 'REGISTER',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xffC7EDE6),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 75.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
