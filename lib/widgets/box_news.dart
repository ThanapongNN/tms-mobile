import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/widgets/text.dart';

Widget boxNews({
  required String image,
  required String content,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 180,
      height: 230,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 180,
          child: CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: 180,
              decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              height: 180,
              width: double.infinity,
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
        ),

        // Container(
        //   height: 180,
        //   decoration: BoxDecoration(image: DecorationImage(image: (image != null) ? NetworkImage(image) : , fit: BoxFit.cover)),
        // ),
        Expanded(child: text(content).paddingAll(5))
      ]),
    ).marginOnly(right: 10),
  );
}
