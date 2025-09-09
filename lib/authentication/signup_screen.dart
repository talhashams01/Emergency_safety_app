



// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//   final confirmPassController = TextEditingController();

//   bool isLoading = false;

//   void signUpUser() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => isLoading = true);

//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passController.text.trim(),
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Account created successfully")),
//       );
//       Navigator.pop(context);
//     } on FirebaseAuthException catch (e) {
//       String message = "An error occurred";
//       if (e.code == 'email-already-in-use') {
//         message = "This email is already in use.";
//       } else if (e.code == 'weak-password') {
//         message = "Password is too weak.";
//       }

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Container(
//                 padding: const EdgeInsets.all(25),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.95),
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("Create Account",
//                           style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.pinkAccent)),
//                       const SizedBox(height: 20),
//                       _buildInput("Full Name", nameController,
//                           validator: (val) =>
//                               val!.isEmpty ? "Enter your name" : null),
//                       const SizedBox(height: 12),
//                       _buildInput("Email", emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (val) =>
//                               val!.contains('@') ? null : "Enter valid email"),
//                       const SizedBox(height: 12),
//                       _buildInput("Password", passController,
//                           obscureText: true,
//                           validator: (val) =>
//                               val!.length < 6 ? "Min 6 characters" : null),
//                       const SizedBox(height: 12),
//                       _buildInput("Confirm Password", confirmPassController,
//                           obscureText: true,
//                           validator: (val) => val != passController.text
//                               ? "Passwords don't match"
//                               : null),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: isLoading ? null : signUpUser,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.pinkAccent,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 50, vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: isLoading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text("SIGN UP",
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white)),
//                       ),
//                       // const SizedBox(height: 18),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: [
//                       //     _socialIcon(FontAwesomeIcons.facebookF),
//                       //     const SizedBox(width: 20),
//                       //     _socialIcon(FontAwesomeIcons.twitter),
//                       //   ],
//                       // ),
//                       const SizedBox(height: 10),
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text("Already have an account? Login"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInput(String label, TextEditingController controller,
//       {TextInputType? keyboardType,
//       bool obscureText = false,
//       String? Function(String?)? validator}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.pink.shade50,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.pinkAccent),
//         ),
//       ),
//     );
//   }

// //   Widget _socialIcon(IconData icon) {
// //     return Container(
// //       padding: EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         shape: BoxShape.circle,
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
// //         ],
// //       ),
// //       child: Icon(icon, color: Colors.pinkAccent, size: 20),
// //     );
// //   }

//  }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isLoading = false;

  void signUpUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      // ✅ Save user name and email to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully")),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'email-already-in-use') {
        message = "This email is already in use.";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak.";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 180, 202),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF5F6D)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 235, 235).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Create Account",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent)),
                      const SizedBox(height: 20),
                      _buildInput("Full Name", nameController,
                          validator: (val) =>
                              val!.isEmpty ? "Enter your name" : null),
                      const SizedBox(height: 12),
                      _buildInput("Email", emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val!.contains('@') ? null : "Enter valid email"),
                      const SizedBox(height: 12),
                      _buildInput("Password", passController,
                          obscureText: true,
                          validator: (val) =>
                              val!.length < 6 ? "Min 6 characters" : null),
                      const SizedBox(height: 12),
                      _buildInput("Confirm Password", confirmPassController,
                          obscureText: true,
                          validator: (val) => val != passController.text
                              ? "Passwords don't match"
                              : null),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isLoading ? null : signUpUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("SIGN UP",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Already have an account? Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller,
      {TextInputType? keyboardType,
      bool obscureText = false,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        //fillColor: Colors.pink.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
      ),
    );
  }
}