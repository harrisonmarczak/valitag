import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String? value;
  final Color? color;
  final Color? textColor;
  final double? height;
  final TextStyle? textStyle;

  const SubmitButton(
      {Key? key,
        this.value,
        this.color,
        this.textColor,
        this.height,
        this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: height ?? 44,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          // gradient: const LinearGradient(
          //   colors: <Color>[
          //     AppColors.submitGradiantColor2,
          //     AppColors.submitGradiantColor1
          //   ],
          //   //stops: [0.9, 0.0],
          //   begin: Alignment(-1.0, -3.0),
          //   end: Alignment(1.0, 3.0),
          //   //end: FractionalOffset.bottomLeft,
          // ),
          // boxShadow: const [
          //    BoxShadow(
          //     color: Colors.black54,
          //     offset:  Offset(0, 5),
          //     blurRadius: 6.0,
          //   ),
          // ],
        ),
        child: Text(value ?? "", style: textStyle!));
  }
}

class SmartButton extends StatelessWidget {
  final String? value;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool? wrap;
  final double radius;
  final double? borderWidth;
  final double padding;
  final void Function()? onTap;
  final TextStyle? textStyle;

  const SmartButton(
      {Key? key,
        this.onTap,
        this.value,
        this.color,
        this.borderColor,
        this.textColor,
        this.borderWidth,
        @required this.height,
        @required this.textStyle,
        this.width,
        this.wrap = false,
        this.radius = 10.0,
        this.padding = 6.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        wrap == true
            ? Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            onTap: onTap,
            child: Container(
              width: width,
              padding: EdgeInsets.only(left: padding, right: padding),
              height: height,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  color:
                  color ?? Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                      color: borderColor ?? Colors.transparent, width: borderWidth ?? 1)),
              child: Text(value ?? "", style: textStyle!),
            ),
          ),
        )
            : Expanded(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            onTap: onTap,
            child: Container(
              width: width,
              padding: EdgeInsets.only(left: padding, right: padding),
              height: height,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  color: color ?? Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(radius),
                  border:
                  Border.all(color: borderColor ?? Colors.transparent,width: borderWidth ?? 1 )),
              child: Text(value ?? "", style: textStyle!),
            ),
          ),
        ),
      ],
    );
  }
}

class SmartButtonIcon extends StatelessWidget {
  final String? value;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double radius;
  final double? contentPadding;
  final double padding;
  final Widget? icon;
  final bool? wrap;
  final TextStyle? textStyle;

  const SmartButtonIcon(
      {Key? key,
        this.value,
        this.icon,
        this.color,
        this.borderColor,
        this.textColor,
        this.wrap = false,
        @required this.height,
        @required this.textStyle,
        this.width,
        this.radius = 10.0,
        this.contentPadding,
        this.padding = 6.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        wrap == true
            ? Container(
          width: width,
          padding: EdgeInsets.only(left: padding, right: padding),
          height: height,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              color: color ?? Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(radius),
              border:
              Border.all(color: borderColor ?? Colors.transparent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              if (icon != null) SizedBox(width: contentPadding ?? 10),
              Text(value ?? "", style: textStyle!),
            ],
          ),
        )
            : Expanded(
          child: Container(
            width: width,
            padding: EdgeInsets.only(left: padding, right: padding),
            height: height,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                color: color ?? Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(radius),
                border:
                Border.all(color: borderColor ?? Colors.transparent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                if (icon != null) SizedBox(width: contentPadding ?? 10),
                Text(value ?? "", style: textStyle!),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SmallButton extends StatelessWidget {
  final String? value;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;

  const SmallButton(
      {Key? key,
        this.value,
        this.color,
        this.textColor,
        @required this.height,
        @required this.width,
        @required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(value ?? "", style: textStyle!),
    );
  }
}

class SmallIconButton extends StatelessWidget {
  final String? value;
  final String? icon;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;

  const SmallIconButton(
      {Key? key,
        this.value,
        this.icon,
        this.color,
        this.textColor,
        @required this.width,
        @required this.height,
        @required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        // gradient: const LinearGradient(
        //   colors: <Color>[
        //     AppColors.submitGradiantColor2,
        //     AppColors.submitGradiantColor1
        //   ],
        //   begin: Alignment(-1.0, -3.0),
        //   end: Alignment(1.0, 3.0),
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon!,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 5),
          Text(value ?? "", style: textStyle!),
        ],
      ),
    );
  }
}

/*class ButtonWithIcon extends StatelessWidget {
  final String? value;
  final String? icon;
  final Color? color;
  final Color? textColor;
  final double? height;
  final TextStyle? textStyle;

  const ButtonWithIcon(
      {Key? key,
      this.value,
      @required this.icon,
      this.color,
      this.textColor,
      @required this.height,
      @required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: <Color>[
            AppColors.submitGradiantColor2,
            AppColors.submitGradiantColor1
          ],
          //stops: [0.9, 0.0],
          begin: Alignment(-1.0, -3.0),
          end: Alignment(1.0, 3.0),
          //end: FractionalOffset.bottomLeft,
        ),
        // boxShadow: const [
        //    BoxShadow(
        //     color: Colors.black54,
        //     offset:  Offset(0, 5),
        //     blurRadius: 6.0,
        //   ),
        // ],SizedBox(height: 5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon!,
            height: 20,
            width: 20,
            color: AppColors.whiteColor,
          ),
          const SizedBox(width: 10),
          Text(value ?? "", style: textStyle!),
        ],
      ),
    );
  }
}*/
