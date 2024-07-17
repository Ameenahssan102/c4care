import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomFooter2 extends StatelessWidget {
  const CustomFooter2({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget child;
        if (mode == LoadStatus.idle) {
          child = const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                    text: "Swipe up to load more",
                    color: AppColors.hint2,
                    id: 1)
              ]);
        } else if (mode == LoadStatus.loading) {
          child =
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CupertinoActivityIndicator(),
            SizedBox(
              width: 5,
            ),
            customText(text: "Loading..", color: AppColors.hint2, id: 1)
          ]);
        } else if (mode == LoadStatus.failed) {
          child =
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.error_outlined,
              color: AppColors.hint2,
            ),
            SizedBox(
              width: 5,
            ),
            customText(text: "", color: AppColors.hint2, id: 1)
          ]);
        } else if (mode == LoadStatus.canLoading) {
          child = const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                    text: "Swipe up to load more",
                    color: AppColors.hint2,
                    id: 1)
              ]);
        } else {
          child =
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            customText(
              text: "",
              color: AppColors.hint2,
              id: 1,
            )
          ]);
        }
        return child;
      },
    );
  }
}
