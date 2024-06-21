import 'package:flutter/material.dart';


class SingleTapEvent extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Function() onTap;

  bool singleTap = false;

  SingleTapEvent(
      {Key? key, required this.child, required this.onTap, singleTap = false, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 7),
        onTap: ()  {
          if (!singleTap) {
            Function.apply(onTap, []);
            singleTap = true;
            Future.delayed(const Duration(milliseconds: 500)).then((value) => singleTap = false);
          }
        },
        child: child);
  }
}