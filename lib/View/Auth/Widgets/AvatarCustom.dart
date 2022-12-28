import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../Constants/Constants.dart';
import 'LetterAva.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:imager/imager.dart';

class AvatarCustom extends StatelessWidget {
  const AvatarCustom(
      {super.key,
      required this.name,
      this.url,
      required this.onPress,
      required this.isLocal,
      required this.radius});

  final String name;
  final String? url;
  final bool isLocal;
  final VoidCallback onPress;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(child: InkWell(onTap: onPress, child: getAvatar()));
  }

  Widget getAvatar() {
    if (url != null && url != '') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius / 2),
        child: (isLocal && !kIsWeb)
            ? Container(
                width: radius,
                height: radius,
                decoration: const BoxDecoration(
                    color: defaultPlaceholderColor, shape: BoxShape.circle),
                child: Image.file(
                  File(url ?? ""),
                  width: radius,
                  height: radius,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        color: defaultPlaceholderColor,
                        child: Icon(
                          Icons.error,
                          size: radius,
                          color: Colors.red,
                        ));
                  },
                ),
              )
            : CachedNetworkImage(
                color: defaultPlaceholderColor,
                imageUrl: url ?? "",
                width: radius,
                height: radius,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: defaultPlaceholderColor,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                    color: defaultPlaceholderColor,
                    child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  print(error);
                  return Container(
                      color: defaultPlaceholderColor,
                      child: Icon(
                        Icons.error,
                        size: radius,
                        color: Colors.green,
                      ));
                },
              ),
      );
    } else {
      return LetterAva(
        radius: radius,
        name: name,
      );
    }
  }
}
