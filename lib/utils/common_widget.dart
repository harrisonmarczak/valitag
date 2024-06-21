import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:valitag/constants/appColors.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/utils/gox.dart';

import '../dialog/common_dialog.dart';
import '../ui/helpScreen/help_screen.dart';
import 'package:valitag/constants/imageText/app_images.dart';

void mDialog(context, Widget widget) {
  showDialog(
    context: context,
    builder: (context) => widget,
  );
}
 customAppBar({ BuildContext? context ,bool? showLeadingIcon, String? titleText , bool? showMenuButton}) {
 return AppBar(
    leading: showLeadingIcon == true
        ? IconButton(
              onPressed: () {
                GoX.goPop();
              },
              icon: Icon(Icons.arrow_back)
          )
       : null,
    automaticallyImplyLeading: false,
    
    title: titleText == null
            ? Text("")
            : Text(
                titleText!,
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 24,
                fontFamily: FontFamily.neueMedium,
              ),
              ),
    centerTitle: true,

    actions: [
      showMenuButton == true
      ? PopupMenuButton(
        // color: Color(0xff858686),
          iconColor: const Color(0xff858686),
          surfaceTintColor: Color(0xffFAFDFE),
          color: Color(0xffFAFDFE), //const Color(0xffFAFDFE),
          itemBuilder: (context){
            return [
               PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    // logoutButon
                    // helpButon
                    SizedBox(
                        height: 20 , width: 20,
                        child: Image.asset(AppImages.helpButon)),
                    const SizedBox(width: 10,),
                    const Text("Help"),
                  ],
                ),
              ),

               PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    SizedBox(
                        height: 20 , width: 20,
                        child: Image.asset(AppImages.logoutButon),
                    ),
                    const SizedBox(width: 10,),
                    const Text("Logout"),
                  ],
                ),
              ),
            ];
          },
          onSelected:(value){
            if(value == 0){
              print("Help menu is selected.");
              GoX.goPush(const HelpScreen());
            }else if(value == 1){
              print("Logout menu is selected.");
              mDialog(context, const CommonDialog(
                title: "Logout",
                cancelButtonTxt: "No",
                proceedButtonTxt: "Yes",
              ));
              // mDialog(context, widget);
            }
          }
      )
      : SizedBox(),
    ],
  );
}