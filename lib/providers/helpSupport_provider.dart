import 'package:flutter/cupertino.dart';

import '../api_services/api_base_helper.dart';
import '../api_services/api_config.dart';
import '../model/contactUs_model.dart';
import '../utils/gox.dart';
import '../utils/show_dialog.dart';

class HelpAndSupportProvider with ChangeNotifier {

  String countryCode = "+61";

  TextEditingController fullNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController numberCont = TextEditingController();
  TextEditingController messageCont = TextEditingController();

  bool validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return false;
    }
    return true;
  }


  contactUsApi() async {

    if(fullNameCont.text.isEmpty)
    {
      showSnackBar("Please enter Full Name");
    }
    else if(emailCont.text.isEmpty)
    {
      showSnackBar("Please enter your Email");
    }
    else if(!validateEmail(emailCont.text))
    {
      showSnackBar("Please enter correct Email");
    }
    else if(numberCont.text.isEmpty)
    {
      showSnackBar("Please enter Phone Number");
    }
    else if(messageCont.text.isEmpty)
    {
      showSnackBar("Please enter Message");
    }
    else
    {
      Map<String, String> body = {
        "name" : fullNameCont.text,
        "email" : emailCont.text,
        "description" : messageCont.text,
        "phone" : numberCont.text,
      };

      var response = await ApiBaseHelper().postApiCall(true, contactUs, body);

      ContactUsModel model = ContactUsModel.fromJson(response);
      if (model.status == true)
      {
        fullNameCont.clear();
        emailCont.clear();
        numberCont.clear();
        messageCont.clear();
        GoX.goPop();
        showSnackBar("Thank you, We will contact you soon", isError: false);
      }
    }
  }

}