import 'package:smatrackz/core.dart';

showLoading({
  String? message,
}) async {
  await showDialog<void>(
    context: Get.currentContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

hideLoading() async {
  Get.back();
}
