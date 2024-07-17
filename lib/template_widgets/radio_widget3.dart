import 'package:C4CARE/Custom/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../Custom/widgets/texts.dart';

class RadioWidget3 extends StatelessWidget {
  final String title;
  final String firstOption;
  final String secondOption;
  final String? groupValue;
  final String hint;
  final String firstOptionText;
  final String secondOptionText;
  final Function onChange;
  final Function onFormChange;
  final String? formValue1;
  final TextEditingController controller = TextEditingController();

  RadioWidget3({
    super.key,
    required this.title,
    this.formValue1,
    this.groupValue,
    required this.firstOption,
    required this.secondOption,
    required this.hint,
    required this.firstOptionText,
    required this.secondOptionText,
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
          Column(
            children: [
              Row(children: [
                Expanded(flex: 2, child: Texts.regular(title)),
              ]),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      value: firstOption,
                      groupValue: groupValue,
                      title: Texts.regular(firstOptionText),
                      onChanged: (val) {
                        onChange(val);
                      },
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
                      onChanged: (val) {
                        onChange(val);
                      },
                      activeColor: Colors.red,
                      selected: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          CustomTextFormField(
            hint: hint,
            controller: controller,
            // initialValue: formValue1,
            readOnly: groupValue == 'no',
            onChanged: (v) {
              onFormChange(v);
            },
          ),
        ],
      ),
    );
  }
}
