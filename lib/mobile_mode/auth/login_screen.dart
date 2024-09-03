import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportwave/mobile_mode/auth/forgot_password_mobile.dart';
import 'package:sportwave/mobile_mode/auth/sign_up_account_mobile.dart';
import 'package:sportwave/mobile_mode/auth/subscription_page_mobile.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/mobile_mode/main/main_dashboard.dart';
import 'package:sportwave/mobile_mode/widgets/text_form_field.dart';
import 'package:sportwave/services/auth.dart';
import 'package:sportwave/utils/buttons.dart';
import 'package:sportwave/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormInputField(
                  controller: _emailController,
                  hintText: "Email Address",
                  IconSuffix: Icons.email,
                  textInputType: TextInputType.emailAddress),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormInputField(
                  controller: _passwordController,
                  hintText: "Password",
                  IconSuffix: Icons.visibility,
                  textInputType: TextInputType.visiblePassword),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SaveButton(
                      title: "Login",
                      onTap: () async {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Email or Password is Required")));
                        } else {
                          setState(() {
                            _isLoading = true;
                          });

                          String res = await AuthMethods().loginUpUser(
                            email: _emailController.text,
                            pass: _passwordController.text,
                          );

                          setState(() {
                            _isLoading = false;
                          });
                          if (res != 'sucess') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(res)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => CheckMobile(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid,
                                        )));
                          }
                        }
                      }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: SizedBox(
                    width: 154,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const ForgotPasswordMobile()));
                        },
                        child: Text(
                          "Forgot Password",
                          style: GoogleFonts.dmSans(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const SignUpAccountMobile()));
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Want To Create New Account?",
                      style: GoogleFonts.dmSans(
                        color: black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: '\n Click Here',
                      style: GoogleFonts.dmSans(
                        color: Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckMobile extends StatelessWidget {
  final String uid;

  const CheckMobile({super.key, required this.uid});

  Future<bool> _CheckMobile() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc['isPaid'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _CheckMobile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: mainBtnColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == true) {
            return MainDashboard();
          } else {
            return const SubscriptionPageMobile();
          }
        },
      ),
    );
  }
}
