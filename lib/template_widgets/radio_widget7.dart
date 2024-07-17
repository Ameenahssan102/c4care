import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../Custom/widgets/custom_form_field.dart';
import '../Custom/widgets/texts.dart';

class RadioWidget7 extends StatelessWidget {
  final String title;
  final String firstOption;
  final String secondOption;
  final String thirdOption;
  final String? groupValue;
  final String firstOptionText;
  final String secondOptionText;
  final String thirdOptionText;
  final Function onChange;
  final String? formValue1;
  final String? formValue2;
  final Function onFormChange1;
  final Function onFormChange2;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  RadioWidget7({
    super.key,
    required this.title,
    required this.groupValue,
    required this.firstOption,
    required this.thirdOption,
    required this.secondOption,
    required this.firstOptionText,
    required this.secondOptionText,
    required this.thirdOptionText,
    required this.onChange,
    required this.formValue1,
    required this.formValue2,
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
          Row(children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Texts.regular(title),
                )),
          ]),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 2,
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
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
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
          Row(
            children: [
              Expanded(
                flex: 2,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: thirdOption,
                  groupValue: groupValue,
                  title: Texts.regular(thirdOptionText),
                  onChanged: (val) => onChange(val!),
                  activeColor: Colors.red,
                  selected: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      readOnly: groupValue == 'none',
                      hint: "Certificate No",
                      controller: controller1,
                      onChanged: (v) => onFormChange1(v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      readOnly: groupValue == 'none',
                      hint: "Issue Date",
                      controller: controller2,
                      onChanged: (v) => onFormChange2(v),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
