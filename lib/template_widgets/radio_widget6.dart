import 'package:C4CARE/Custom/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class RadioWidget6 extends StatelessWidget {
  final String? formValue1;
  final String? formValue2;
  final String? formValue3;
  final Function onFormChange1;
  final Function onFormChange2;
  final Function onFormChange3;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  RadioWidget6({
    super.key,
    required this.formValue1,
    required this.formValue2,
    required this.formValue3,
    required this.onFormChange1,
    required this.onFormChange2,
    required this.onFormChange3,
  });

  @override
  Widget build(BuildContext context) {
    controller1.text = formValue1 ?? "";
    controller2.text = formValue2 ?? "";
    controller3.text = formValue3 ?? "";
    return Container(
      decoration: Decorations.boxDecorationColor(
          color: AppColors.hint.withOpacity(.08)),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hint: "Form Completed by (Print Name):",
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
                  hint: "Position:",
                  controller: controller2,
                  onChanged: (v) => onFormChange2(v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hint: "Date",
                  controller: controller3,
                  onChanged: (v) => onFormChange3(v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
