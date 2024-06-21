import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valitag/utils/gox.dart';

import '../ui/helpScreen/help_screen.dart';

class CustomAppBar {
  customAppBar({ BuildContext? context ,bool? showLeadingIcon, bool? showMenuButton}) {
    return AppBar(
      leading: showLeadingIcon == true
          ? IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back)
      )
          : null,
      automaticallyImplyLeading: false,

      actions: [
        showMenuButton == true
            ? PopupMenuButton(
          // color: Color(0xff858686),
            iconColor: Color(0xff858686),
            itemBuilder: (context){
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      // Image.asset(name),
                      Text("Help"),
                    ],
                  ),

                ),

                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected:(value){
              if(value == 0){
                print("Help menu is selected.");
                GoX.goPush(const HelpScreen());
              }else if(value == 1){
                print("Logout menu is selected.");
                // mDialog(context, widget);
              }
            }
        )
            : SizedBox(),
      ],
    );
  }
}