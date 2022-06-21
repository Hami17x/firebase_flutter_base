import 'package:firebase_flutter/auth/service/service.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();
  bool didsent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reset password"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "email"),
            ),
            didsent
                ? Icon(Icons.thumb_up_sharp)
                : ElevatedButton(
                    onPressed: () {
                      FirebaseService.resetPassword(emailController.text.trim())
                          .then((value) {
                        if (value) {
                          didsent = true;
                          setState(() {});
                        }
                      });
                    },
                    child: Text("reset password"))
          ],
        ),
      ),
    );
  }
}
