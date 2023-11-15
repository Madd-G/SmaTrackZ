import 'package:smatrackz/core.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.child,
    this.containerColor,
    this.borderColor,
    this.borderWidth,
    this.radius,
    this.height,
    this.width,
  });

  final Widget child;
  final Color? containerColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? radius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 20.0),
        ),
        border: Border.all(
          color: borderColor ?? Colors.black12,
          width: borderWidth ?? 1,
        ),
      ),
      child: child,
    );
  }
}
