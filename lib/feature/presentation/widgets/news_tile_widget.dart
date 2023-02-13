import 'package:flutter/material.dart';
import 'package:news_feed/commons/textStyle_helper.dart';
import 'package:news_feed/feature/presentation/widgets/cached_network_image_widget.dart';

class NewsTileWidget extends StatelessWidget {
  final String? imageUrl;
  final String? text;
  final double width;
  final double height;

  const NewsTileWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImageWidget(
            imageUrl: imageUrl,
            width: width * 0.35,
            height: height * 0.15,
          ),
          SizedBox(
            width: width * 0.35,
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyleHelper.f16w400,
            ),
          ),
        ],
      ),
    );
  }
}
