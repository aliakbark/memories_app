import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textTheme,
    this.textColor = Colors.white,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding = const EdgeInsets.all(0.0),
    this.visualDensity,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.animationDuration,
    this.enableFeedback = true,
    this.child,
    this.width,
    this.isLoading = false,
  })  : assert(autofocus != null),
        assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(clipBehavior != null),
        super(key: key);

  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHighlightChanged;
  final MouseCursor? mouseCursor;
  final ButtonTextTheme? textTheme;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? color;
  final Color? disabledColor;
  final Color? splashColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final double? elevation;
  final double? hoverElevation;
  final double? focusElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final Brightness? colorBrightness;
  final double? width;
  final Widget? child;
  final bool isLoading;

  bool get enabled => onPressed != null || onLongPress != null;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Duration? animationDuration;
  final MaterialTapTargetSize? materialTapTargetSize;

  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      disabledColor: disabledColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      focusElevation: focusElevation,
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: Clip.none,
      focusNode: focusNode,
      autofocus: false,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      child: Container(
        height: 48.0,
        width: width,
        alignment: Alignment.center,
        // decoration: onPressed != null
        //     ? const BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //   gradient: LinearGradient(
        //     colors: <Color>[
        //       Color(0xFF009688),
        //       Color(0xFF26a69a),
        //       Color(0xFF4db6ac),
        //     ],
        //   ),
        // )
        //     : null,

        child: isLoading
            ? SpinKitThreeBounce(
                size: 32, color: Theme.of(context).primaryColor)
            : child,
      ),
    );
  }
}
