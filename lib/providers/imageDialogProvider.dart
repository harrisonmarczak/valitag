import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valitag/constants/text/app_text.dart';

class ImageDialogProvider with ChangeNotifier {
  XFile? image;
  List<XFile?>? allImages = [];

  TextEditingController notesCont = TextEditingController();
  String notesText = AppText.notesText;
  String notesHeading = "Note: ";


  // String notesText = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";

  emptyFunc() {
    notesCont.clear();
    notesText = "";
    image = null;
    allImages = [];
    notifyListeners();
  }

  Future<void> getImageData() async {
    print("Image Gallery Function :::");
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null)
    {
      print("Imagges is :: ${image}");
      print("Imagges is :: ${image!.path}");

      notifyListeners();
    }
  }

  saveImages() {
    if(image == null) return;
    allImages?.add(image);
    image = null;
    print("Images lenght :: ${allImages?.length ?? 0}");
    notifyListeners();
  }

  deleteImage(int index) {
    allImages?.removeAt(index);
    notifyListeners();
  }


  saveNotes() {
    if(notesCont.text.isNotEmpty)
      {
        if(notesCont.text.toString().trim().isNotEmpty)
          {
            notesText = notesCont.text;
            // notesCont.clear();
            notifyListeners();
          }
        else
          {
            notesCont.clear();
            notesText = "";
            notifyListeners();
          }

      }
    else
      {
        notesCont.clear();
        notesText = "";
        notifyListeners();
      }
  }


}