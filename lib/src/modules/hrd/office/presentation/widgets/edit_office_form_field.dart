import 'package:smatrackz/core.dart';

class EditOfficeFormField extends StatelessWidget {
  const EditOfficeFormField({
    required this.fieldTitle,
    required this.controller,
    super.key,
    this.hintText,
    this.readOnly = false,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
