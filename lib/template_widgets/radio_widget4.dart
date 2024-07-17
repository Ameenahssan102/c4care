import 'package:C4CARE/Custom/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../Custom/widgets/texts.dart';

class RadioWidget4 extends StatelessWidget {
  final String title;
  final String? formValue1;
  final String? formValue2;
  final String firstOption;
  final String secondOption;
  final String firstOptionText;
  final String secondOptionText;
  final String? groupValue;
  final String hint;
  final String hint2;
  final Function onChange;
  final Function onFormChange1;
  final Function onFormChange2;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  RadioWidget4({
    super.key,
    required this.title,
    required this.formValue1,
    required this.formValue2,
    required this.groupValue,
    required this.firstOption,
    required this.secondOption,
    required this.firstOptionText,
    required this.secondOptionText,
    required this.hint,
    required this.hint2,
    required this.onChange,
    required this.onFormChange1,
    required this.onFormChange2,
  });

  @override
  Widget build(BuildContext context) {
    controller1.text = formValue1 ?? "";
    controller2.text = formValue2 ?? "";
    return Container(
      decoration: Decorations.boxDecorationColor(
          color: AppColors.hint.withOpacity(.08)),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
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
                      onChanged: (val) => onChange(val!),
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
                      onChanged: (val) => onChange(val!),
                      activeColor: Colors.red,
                      selected: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hint: hint,
                  controller: controller1,
                  readOnly: groupValue == 'no',
                  onChanged: (v) => onFormChange1(v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFormField(
                  hint: hint2,
                  controller: controller2,
                  readOnly: groupValue == 'no',
                  onChanged: (v) => onFormChange2(v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
