import 'package:flutter/material.dart';
import 'package:news_feed/commons/textStyle_helper.dart';
import 'package:news_feed/feature/presentation/widgets/cached_network_image_widget.dart';

class NewsCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String? text;
  final double height;
  final double width;

  const NewsCardWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          CachedNetworkImageWidget(
            height: height * 0.1,
            width: width * 0.3,
            imageUrl: imageUrl,
            radius: BorderRadius.circular(10),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: width * 0.5,
            child: Text(
              text ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyleHelper.f16w400,
            ),
          ),
        ],
      ),
    );
  }
}
