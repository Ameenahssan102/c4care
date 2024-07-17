import 'package:C4CARE/Custom/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../Custom/widgets/texts.dart';

class RadioWidget5 extends StatelessWidget {
  final String title;
  final String firstOption;
  final String secondOption;
  final String thirdOption;
  final String fourthOption;
  final String firstOptionText;
  final String secondOptionText;
  final String thirdOptionText;
  final String fourthOptionText;
  final String? groupValue;
  final String? formValue1;
  final Function onChange;
  final Function onFormChange;
  final TextEditingController controller = TextEditingController();

  RadioWidget5({
    super.key,
    required this.title,
    required this.groupValue,
    required this.firstOption,
    required this.secondOption,
    required this.thirdOption,
    required this.fourthOption,
    required this.firstOptionText,
    required this.secondOptionText,
    required this.thirdOptionText,
    required this.fourthOptionText,
    required this.formValue1,
    required this.onChange,
    required this.onFormChange,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = formValue1 ?? "";
    return Container(
      decoration: Decorations.boxDecorationColor(
          color: AppColors.hint.withOpacity(.08)),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: Texts.regular(title)),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: firstOption,
                  groupValue: groupValue,
                  title: Texts.regular(firstOptionText),
                  onChanged: (val) => onChange(val),
                  activeColor: Colors.red,
                  selected: true,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: secondOption,
                  groupValue: groupValue,
                  title: Texts.regular(secondOptionText),
                  onChanged: (val) => onChange(val),
                  activeColor: Colors.red,
                  selected: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: thirdOption,
                  groupValue: groupValue,
                  title: Texts.regular(thirdOptionText),
                  onChanged: (val) => onChange(val),
                  activeColor: Colors.red,
                  selected: true,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: fourthOption,
                  groupValue: groupValue,
                  title: Texts.regular(fourthOptionText),
                  onChanged: (val) => onChange(val),
                  activeColor: Colors.red,
                  selected: true,
                ),
              ),
            ],
          ),
          CustomTextFormField(
            hint: "Registration No",
            controller: controller,
            onChanged: (v) => onFormChange(v),
          ),
        ],
      ),
    );
  }
}
