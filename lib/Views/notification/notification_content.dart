import 'package:C4CARE/Custom/base_widget.dart';
import 'package:C4CARE/Custom/ctext.dart';
import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Model/notifications.model.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class NotificationContent extends StatelessWidget {
  final Notifications data;
  const NotificationContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        appBar: AppBar(
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.message,
                color: AppColors.white10.withOpacity(.3),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: customText(text: data.title!, id: 1)),
            ],
          ),
          backgroundColor: AppColors.primaryDarkColor,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Iconsax.arrow_left_1),
          ),
          centerTitle: true,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryDarkColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          CText(
                              size: 12,
                              textcolor: AppColors.hint.withOpacity(.7),
                              text: DateFormat('dd MMM , ha')
                                  .format(data.createdAt!))
                        ])),
                    Divider(
                      color: AppColors.primaryColor,
                      thickness: 5,
                    ),
                    customText(
                      text: data.content ?? "",
                      id: 2,
                      textSize: 20,
                    )
                  ]),
            ),
          ),
        ));
  }
}
