import 'package:booking/presentataion/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking/authentication.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return _isSigningIn
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        : AppButton(
            label: 'Sign in with Google',
            onTap: () async {
              setState(() {
                _isSigningIn = true;
              });
              User? user =
                  await Authentication.signInWithGoogle(context: context);
              setState(() {
                _isSigningIn = false;
              });
              if (user != null) {
                context.push('/list');
              }
            },
          );
  }
}
