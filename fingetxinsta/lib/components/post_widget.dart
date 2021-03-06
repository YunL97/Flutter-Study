import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:fingetxinsta/components/avatar_widget.dart';
import 'package:fingetxinsta/components/image_data.dart';
import 'package:fingetxinsta/src/models/post.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
              nickname: post.userInfo!.nickname,
              size: 40,
              thumbPath: post.userInfo!.thumbnail!,
              type: AvatarType.TYPE3),
          //더보기
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(imageUrl: post.thumbnail!);
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              SizedBox(
                width: 10,
              ),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              SizedBox(
                width: 10,
              ),
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 55,
          )
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "좋아요 ${post.likeCount ?? 0}개",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text(
          //   "콘텐츠 1입니다. \n콘텐츠 1입니다. \n콘텐츠 1입니다. \n콘텐츠 1입니다. \n",
          // ),
          ExpandableText(
            post.description ?? "",
            expandText: '더보기',
            collapseText: '접기',
            prefixText: post.userInfo!.nickname,
            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.green,
            onPrefixTap: () {
              print("ta");
            },
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "댓글: 199개 모두보기",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        timeago.format(post.createdAt!),
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(
            height: 15,
          ),
          _image(),
          SizedBox(height: 5),
          _infoCount(),
          SizedBox(height: 5),
          _infoDescription(),
          SizedBox(height: 5),
          _replyTextBtn(),
          _dateAgo()
        ],
      ),
    );
  }
}
