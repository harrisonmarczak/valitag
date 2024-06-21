import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/utils/gox.dart';

import '../../button/smart_button.dart';
import '../../constants/appColors.dart';
import '../../constants/fontFamily.dart';
import '../../providers/helpSupport_provider.dart';
import '../../utils/common_widget.dart';

class HelpScreen extends StatefulWidget {

  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  TextFormField fullName = TextFormField();
  TextFormField email = TextFormField();
  TextFormField number = TextFormField();
  TextFormField message = TextFormField();

  String countryCode = "+61";


  @override
  Widget build(BuildContext context) {
    return Consumer<HelpAndSupportProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: customAppBar(showLeadingIcon: true, titleText: "Help & Support"),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
        //FullName
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGreyColorB, // Border color
                          width: 1, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: value.fullNameCont ,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                            fontFamily: FontFamily.neueLight ,
                            fontSize: 14,
                            color: Color(0xff8A8A8A)
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

        //Email
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGreyColorB, // Border color
                          width: 1, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: value.emailCont,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontFamily: FontFamily.neueLight ,
                            fontSize: 14,
                            color: Color(0xff8A8A8A)
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

        //MobileNumber
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGreyColorB, // Border color
                          width: 1, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin : EdgeInsets.only(right: 10) ,
                          padding: EdgeInsets.only(top: 5) ,
                          child: Text(
                            countryCode,
                          style: TextStyle(
                              fontFamily: FontFamily.neueMedium ,
                              fontSize: 15,
                              color: Color(0xff8A8A8A)
                          ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: value.numberCont ,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  fontFamily: FontFamily.neueLight ,
                                  fontSize: 14,
                                  color: Color(0xff8A8A8A)
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),

        //Message
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGreyColorB, // Border color
                          width: 1, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: value.messageCont,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Message',

                        hintStyle: TextStyle(
                            fontFamily: FontFamily.neueLight ,
                            fontSize: 14,
                            color: Color(0xff8A8A8A)
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

//Button
                  UnconstrainedBox(
                    child: SmartButton(
                        onTap: () {
                          // value.contactUsApi();
                          // GoX.goPush(const ReadyToScan());
                          GoX.goPop();
                        },
                        wrap: true,
                        height: 54,
                        width: MediaQuery.of(context).size.width *0.6 ,
                        color: Color(0xff007FC5),
                        radius: 100,
                        value: "Submit",
                        textStyle: TextStyle(
                          fontFamily: FontFamily.neueMedium,
                          fontSize: 16,
                          color: Color(0xffFFFFFF),
                        )
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
