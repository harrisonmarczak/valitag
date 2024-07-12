import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/text/app_text.dart';

class DialogProvider extends ChangeNotifier {
    TextEditingController notesCont = TextEditingController();
    String notesText = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";

    saveNotes() {
      notesText = notesCont.text;
      notesCont.clear();
      notifyListeners();
    }
}