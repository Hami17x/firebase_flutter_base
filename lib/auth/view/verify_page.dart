import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/auth/service/firebase_service.dart';
import 'package:firebase_flutter/home.dart';
import 'package:flutter/material.dart';

class VerifyPafe extends StatefulWidget {
  const VerifyPafe({Key? key}) : super(key: key);

  @override
  State<VerifyPafe> createState() => _VerifyPafeState();
}

class _VerifyPafeState extends State<VerifyPafe> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      FirebaseService.sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return (isEmailVerified)
        ? HomePage()
        : Scaffold(
            appBar: AppBar(
              title: Text("verify Page"),
            ),
          );
  }
}
