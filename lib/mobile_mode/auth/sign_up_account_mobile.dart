import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportwave/mobile_mode/auth/login_screen.dart';
import 'package:sportwave/mobile_mode/auth/subscription_page_mobile.dart';
import 'package:sportwave/mobile_mode/widgets/button.dart';
import 'package:sportwave/services/auth.dart';
import 'package:sportwave/utils/app_style.dart';
import 'package:sportwave/utils/colors.dart';
import 'package:sportwave/utils/input_text.dart';

class SignUpAccountMobile extends StatefulWidget {
  const SignUpAccountMobile({super.key});

  @override
  State<SignUpAccountMobile> createState() => _SignUpAccountMobileState();
}

class _SignUpAccountMobileState extends State<SignUpAccountMobile> {
  bool passwordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Account",
          style: TextStyle(color: colorwhite),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colorwhite),
        backgroundColor: const Color(0xff000080),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "First Name",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 9),
              InputText(
                controller: _nameController,
                labelText: "First Name",
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
                onSaved: (val) {},
                textInputAction: TextInputAction.done,
                isPassword: false,
                enabled: true,
              ),
              const SizedBox(height: 9),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last Name",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 9),
              InputText(
                controller: _lastNameController,
                labelText: "Last Name",
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
                onSaved: (val) {},
                textInputAction: TextInputAction.done,
                isPassword: false,
                enabled: true,
              ),
              const SizedBox(height: 9),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 9),
              InputText(
                controller: _emailController,
                labelText: "example@gmail.com",
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
                onSaved: (val) {},
                textInputAction: TextInputAction.done,
                isPassword: false,
                enabled: true,
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 9),
              TextFormField(
                controller: _passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: AppStyles.focusedBorder,
                  disabledBorder: AppStyles.focusBorder,
                  enabledBorder: AppStyles.focusBorder,
                  errorBorder: AppStyles.focusErrorBorder,
                  focusedErrorBorder: AppStyles.focusErrorBorder,
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  alignLabelWithHint: false,
                  filled: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SaveButton(
                      title: "Continue",
                      onTap: () async {
                        if (_nameController.text.isEmpty ||
                            _lastNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "First Name and Last Name is Required")));
                        } else if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Email or Password is Required")));
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                        }

                        String res = await AuthMethods().signUpUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                            confrimPassword: _passwordController.text,
                            firstName: _nameController.text,
                            lastName: _lastNameController.text);

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
                                  builder: (builder) =>
                                      const SubscriptionPageMobile()));
                        }
                      }),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const LoginScreen()));
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.dmSans(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign I',
                        style: GoogleFonts.dmSans(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'n\n',
                        style: GoogleFonts.dmSans(
                          color: black,
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
      ),
    );
  }
}
