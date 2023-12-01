import 'package:smatrackz/core.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        try {
          context.pop();
          return false;
        } catch (_) {
          return true;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
