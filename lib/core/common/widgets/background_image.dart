import 'package:smatrackz/core.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppMedia.backgroundImage,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        child,
      ],
    );
  }
}
