import 'package:firebase_flutter/auth/service/firebase_service.dart';
import 'package:firebase_flutter/auth/viewmodel/reset_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResetPasswordProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("reset password"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      context.read<ResetPasswordProvider>().setDidSent(false);
                    },
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "email"),
                  ),
                  context.watch<ResetPasswordProvider>().isSending
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed:
                              !context.watch<ResetPasswordProvider>().didsent
                                  ? () {
                                      context
                                          .read<ResetPasswordProvider>()
                                          .setIsSending(true);
                                      context
                                          .read<ResetPasswordProvider>()
                                          .setDidSent(false);

                                      FirebaseService.resetPassword(
                                              emailController.text.trim())
                                          .then((value) {
                                        context
                                            .read<ResetPasswordProvider>()
                                            .setIsSending(false);

                                        if (value) {
                                          context
                                              .read<ResetPasswordProvider>()
                                              .setDidSent(true);
                                        } else {
                                          print("asas");
                                        }
                                      });
                                    }
                                  : null,
                          child: Text("reset password")),
                  context.watch<ResetPasswordProvider>().didsent
                      ? Text(
                          "the email succesfully sent it",
                          style: TextStyle(color: Colors.green),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
