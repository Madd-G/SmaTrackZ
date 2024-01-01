import 'package:smatrackz/core.dart';

class Dropdown2 extends StatefulWidget {
  final String? hint;
  final List<Map<String, dynamic>> items;
  final String? Function(Map<String, dynamic>? value)? validator;
  final dynamic value;
  final bool emptyMode;
  final Function(dynamic value, String? label) onChanged;

  const Dropdown2({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.emptyMode = true,
    this.hint,
  }) : super(key: key);

  @override
  State<Dropdown2> createState() => _Dropdown2State();
}

class _Dropdown2State extends State<Dropdown2> {
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic>? selectedValue;

  @override
  void initState() {
    super.initState();

    items = [];
    if (widget.emptyMode) {
      items.add({
        "label": "-",
        "value": "-",
      });
      selectedValue = {
        "label": "-",
        "value": "-",
      };
    }

    for (var item in widget.items) {
      items.add(item);
    }

    var values = widget.items.where((i) => i["value"] == widget.value).toList();
    if (values.isNotEmpty) {
      selectedValue = values.first;
    }
  }

  // setAllItemsToFalse() {
  //   for (var item in items) {}
  // }

  Map<String, dynamic>? get currentValue {
    if (widget.emptyMode) {
      var foundItems =
          items.where((i) => i["value"] == selectedValue?["value"]).toList();
      if (foundItems.isNotEmpty) {
        return foundItems.first;
      }

      return {
        "label": "-",
        "value": "-",
      };
    }
    return items.first;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: false,
      validator: (value) {
        if (widget.validator != null) {
          if (widget.emptyMode && selectedValue?["value"] == "-") {
            return widget.validator!(null);
          }
          return widget.validator!(selectedValue);
        }
        return null;
      },
      enabled: true,
      builder: (FormFieldState<bool> field) {
        return DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: false,
            child: SizedBox(
              child: DropdownButton<Map<String, dynamic>>(
                hint: const Row(
                  children: [
                    Text('AAAAA'),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.0,
                      color: AppColors.lightGreyColor,
                    ),
                  ],
                ),
                isExpanded: true,
                // value: currentValue,
                // icon: const Icon(
                //   Icons.keyboard_arrow_down,
                //   size: 24.0,
                //   color: AppColors.lightGreyColor,
                // ),
                iconSize: 16,
                elevation: 16,
                style: CustomTextStyle.textBigRegular.copyWith(
                  color: AppColors.greyColor,
                ),
                underline: Container(
                  height: 0,
                  color: Colors.grey[300],
                ),
                onChanged: (Map<String, dynamic>? newValue) {
                  // if (widget.emptyMode && newValue?["value"] == "-") {
                  //   selectedValue = {
                  //     "label": "-",
                  //     "value": "-",
                  //   };
                  // } else {
                    selectedValue = newValue!;
                  // }
                  setState(() {});

                  var label = selectedValue!["label"];
                  var value = selectedValue!["value"];
                  widget.onChanged(value, label);
                },
                items: List.generate(
                  items.length,
                  (index) {
                    var item = items[index];
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0.0,
                          vertical: 0.0,
                        ),
                        child: Text(
                          item["label"],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
