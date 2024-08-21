import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/auth/login_screen.dart';
import 'package:sportwave/mobile_mode/widgets/button.dart';
import 'package:sportwave/utils/colors.dart';
import 'package:sportwave/utils/input_text.dart';

class ForgotPasswordMobile extends StatefulWidget {
  const ForgotPasswordMobile({super.key});

  @override
  State<ForgotPasswordMobile> createState() => _ForgotPasswordMobileState();
}

class _ForgotPasswordMobileState extends State<ForgotPasswordMobile> {
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(color: colorwhite),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colorwhite),
        backgroundColor: Color(0xff000080),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 200,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email Address",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            const SizedBox(height: 9),
            InputText(
              controller: _passwordController,
              labelText: "example@gmail.com",
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {},
              onSaved: (val) {},
              textInputAction: TextInputAction.done,
              isPassword: false,
              enabled: true,
            ),
            const SizedBox(height: 30),
            _isLoading
                ? CircularProgressIndicator()
                : SaveButton(
                    title: "Send",
                    onTap: () async {
                      if (_passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Email is Required To reset the password")));
                      } else {
                        setState(() {
                          _isLoading = true;
                        });

                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _passwordController.text.trim());

                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Reset Password Link Send to your email")));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => LoginScreen()));
                      }
                    })
          ],
        ),
      ),
    );
  }
}
