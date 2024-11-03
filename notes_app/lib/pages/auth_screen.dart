import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/login_button.dart';
import 'package:notes_app/components/my_textfield.dart';
import 'package:notes_app/components/square_tile.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({
    super.key,
  });

  final userNameController = TextEditingController();

  final passController = TextEditingController();

  void signUserIn() {}

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
                Image.asset('assets/TimeTamer.png', scale: 2,),
                Text(
                  "Welcome back!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  controller: userNameController,
                  hintText: 'Username',
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
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                LoginButton(
                  onTap: signUserIn,
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
                          style: TextStyle(color: Colors.grey[700]),
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
                const SizedBox(
                  height: 16,
                ),
                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SquareTile(imagePath: 'assets/google.png'),
                  SizedBox(
                    width: 10,
                  ),
                  SquareTile(imagePath: 'assets/apple.png')
                ]),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: GoogleFonts.dmSans(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Register now',
                        style: GoogleFonts.dmSans(color: Colors.blue[700]))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
