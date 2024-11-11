import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onTap, required this.text});

  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 63, 3, 77),
              Color.fromARGB(255, 189, 136, 210),
            ],
          ),
        ),
        child: Center(
            child: Text(text,
                style: GoogleFonts.dmSans(color: Colors.white, fontSize: 20))),
        // child: ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.transparent,
        //     shadowColor: Colors.transparent,
        //   ),
        //   child: const Text(
        //     "Σύνδεση",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontSize: 20,
        //       color: Colors.white,
        //       fontWeight: FontWeight.normal,
        //       fontFamily: 'Helvetica',
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
