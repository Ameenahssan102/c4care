import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../Custom/widgets/texts.dart';

class RadioWidget extends StatefulWidget {
  final String title;
  final String firstOption;
  final String secondOption;
  final String firstOptionText;
  final String secondOptionText;
  final String? groupValue;
  final Function onChange;

  const RadioWidget({
    super.key,
    required this.title,
    required this.groupValue,
    required this.firstOption,
    required this.secondOption,
    required this.firstOptionText,
    required this.secondOptionText,
    required this.onChange,
  });

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  //String? groupValue;

  @override
  void initState() {
    super.initState();
    //groupValue = widget.groupValue;
  }

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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Texts.regular(widget.title),
                  )),
            ],
          ),
          const Divider(
            height: 0,
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: widget.firstOption,
                  groupValue: widget.groupValue,
                  title: Texts.regular(widget.firstOptionText),
                  onChanged: (val) {
                    widget.onChange(val!);
                    //setState(() => groupValue = val!);
                  },
                  activeColor: Colors.red,
                  selected: true,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: widget.secondOption,
                  groupValue: widget.groupValue,
                  title: Texts.regular(widget.secondOptionText),
                  onChanged: (val) {
                    widget.onChange(val!);
                    //setState(() => groupValue = val!);
                  },
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
