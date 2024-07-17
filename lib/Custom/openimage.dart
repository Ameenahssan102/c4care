// ignore_for_file: prefer_const_constructors

import 'package:C4CARE/Values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OpenImage extends StatelessWidget {
  final void Function() ondelete;
  final void Function() oncamera;
  final void Function() ongallery;
  final String title;
  const OpenImage(
      {Key? key,
      required this.ondelete,
      required this.oncamera,
      required this.ongallery,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.black_18(),
              ),
              IconButton(
                  onPressed: () {
                    ondelete();
                    // setState(() {
                    //   img = null;
                    //   _removedialog();
                    // });
                  },
                  icon: Icon(Iconsax.trash)),
            ],
          ),
        ),
        Column(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              leading: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.white10,
                  child: Icon(
                    CupertinoIcons.camera,
                    color: AppColors.primaryColor,
                  )),
              title: Text(
                "Camera",
                style: TextStyle(fontSize: 18, color: AppColors.black),
              ),
              onTap: () {
                oncamera();
                // _removedialog();
                // _imgFromCamera(ImageSource.camera);
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Divider(
                color: AppColors.white10,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.white10,
                  child: Icon(
                    CupertinoIcons.photo,
                    color: AppColors.primaryColor,
                  )),
              title: Text(
                "Gallery",
                style: TextStyles.black_18(),
              ),
              onTap: () {
                ongallery();
                // _removedialog();
                // _imgFromCamera(ImageSource.gallery);
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
