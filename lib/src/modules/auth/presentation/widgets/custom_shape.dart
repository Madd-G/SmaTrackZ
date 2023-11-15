import 'package:smatrackz/core.dart';

class CustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;

    final halfCircleHeight = size.width / 3;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height - halfCircleHeight),
          radius: size.width,
        ),
        0,
        180 * (3.1415927 / 180),
        false,
      )
      ..lineTo(0, size.height - halfCircleHeight)
      ..lineTo(size.width, size.height - halfCircleHeight)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
