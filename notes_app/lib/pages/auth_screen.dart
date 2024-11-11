import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/login_button.dart';
import 'package:notes_app/components/my_textfield.dart';
import 'package:notes_app/pages/note_page.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key, required this.onTap});

  final emailController = TextEditingController();
  final passController = TextEditingController();

  final Function()? onTap;

  void signUserIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/TimeTamer.png', scale: 2),
                Text(
                  "Welcome back!",
                  style: GoogleFonts.dmSerifText(
                      color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: passController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: GoogleFonts.dmSerifText(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                LoginButton(
                  text: 'Sign in',
                  onTap: () => signUserIn(context),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or Continue with",
                          style:
                              GoogleFonts.dmSerifText(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                        buttonType: SocialLoginButtonType.google,
                        mode: SocialLoginButtonMode.single,
                        height: 35,
                        imageWidth: 25,
                        borderRadius: 15,
                        text: '',
                        onPressed: () {}),
                    const SizedBox(
                      width: 10,
                    ),
                    SocialLoginButton(
                        buttonType: SocialLoginButtonType.facebook,
                        mode: SocialLoginButtonMode.single,
                        borderRadius: 15,
                        height: 35,
                        imageWidth: 25,
                        text: '',
                        onPressed: () {}),
                    const SizedBox(
                      width: 10,
                    ),
                    SocialLoginButton(
                        buttonType: SocialLoginButtonType.twitter,
                        mode: SocialLoginButtonMode.single,
                        borderRadius: 15,
                        height: 35,
                        imageWidth: 25,
                        text: '',
                        onPressed: () {}),
                    const SizedBox(
                      width: 10,
                    ),
                    SocialLoginButton(
                        buttonType: SocialLoginButtonType.github,
                        mode: SocialLoginButtonMode.single,
                        borderRadius: 15,
                        height: 35,
                        imageWidth: 25,
                        text: '',
                        onPressed: () {}),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: GoogleFonts.dmSans(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Register now',
                        style: GoogleFonts.dmSans(color: Colors.blue[700]),
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
}
