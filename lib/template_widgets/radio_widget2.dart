import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../Custom/widgets/texts.dart';

class RadioWidget2 extends StatelessWidget {
  final String title;
  final String firstOption;
  final String secondOption;
  final String thirdOption;
  final String? groupValue;
  final String firstOptionText;
  final String secondOptionText;
  final String thirdOptionText;
  final Function onChange;

  const RadioWidget2({
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Decorations.boxDecorationColor(
          color: AppColors.hint.withOpacity(.08)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Texts.regular(title),
                  )),
            ],
          ),
          const Divider(
            height: 0,
          ),
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
        ],
      ),
    );
  }
}
