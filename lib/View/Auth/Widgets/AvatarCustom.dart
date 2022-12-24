import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../Constants/Constants.dart';
import 'LetterAva.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:imager/imager.dart';

class AvatarCustom extends StatefulWidget {
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
  State<AvatarCustom> createState() => _AvatarCustomState();
}

class _AvatarCustomState extends State<AvatarCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: InkWell(onTap: widget.onPress, child: getAvatar()));
  }

  Widget getAvatar() {
    if (widget.url != null || widget.url == '') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius / 2),
        child: (widget.isLocal && !kIsWeb)
            ? Container(
                width: widget.radius,
                height: widget.radius,
                decoration: const BoxDecoration(
                    color: defaultPlaceholderColor, shape: BoxShape.circle),
                child: Image.file(
                  File(widget.url ?? ""),
                  width: widget.radius,
                  height: widget.radius,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        color: defaultPlaceholderColor,
                        child: Icon(
                          Icons.error,
                          size: widget.radius,
                          color: Colors.red,
                        ));
                  },
                ),
              )
            : CachedNetworkImage(
                color: defaultPlaceholderColor,
                imageUrl: widget.url ?? "",
                width: widget.radius,
                height: widget.radius,
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
                  return Container(
                      color: defaultPlaceholderColor,
                      child: Icon(
                        Icons.error,
                        size: widget.radius,
                        color: Colors.red,
                      ));
                },
              ),
      );
    } else {
      return LetterAva(
        radius: widget.radius,
        name: widget.name,
      );
    }
  }
}
