import 'package:C4CARE/Custom/texts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../values/values.dart';

class CachedImage {
  static load(String image, BuildContext context, {double? size}) {
    return CachedNetworkImage(
      cacheKey: image,
      width: size,
      height: size,
      fit: BoxFit.fitHeight,
      imageUrl: image,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image(fit: BoxFit.cover, image: imageProvider),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 16.0),
            height: 24.0,
            width: 24.0,
            child:  CircularProgressIndicator(
                backgroundColor: Colors.grey, valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor), strokeWidth: 2.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: MediaQuery.of(context).size.width / 3,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
            color: const Color(0xFF3BAA44), borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.white)),
        child: Center(child: Texts.small("NO IMAGE", color: AppColors.white)),
      ),
    );
  }
}
