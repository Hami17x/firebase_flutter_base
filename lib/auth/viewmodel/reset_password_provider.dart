import 'package:flutter/widgets.dart';

class ResetPasswordProvider extends ChangeNotifier {
  late bool didsent;
  late bool isSending;

  ResetPasswordProvider() {
    didsent = false;
    isSending = false;
  }

  void setDidSent(bool value) {
    didsent = value;
    notifyListeners();
  }

  void setIsSending(bool value) {
    isSending = value;
    notifyListeners();
  }
}
