import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login/main_dashboard/blog_home.dart';

class BlogDetailsPage extends StatelessWidget {
  BlogDetailsPage({super.key, required this.blogDetail});

  BlogsTile blogDetail;

  @override
  Widget build(BuildContext context) {
    //print(blogDetail.category);

    Widget _dispImg = CachedNetworkImage(
      imageUrl: blogDetail.imgUrl,
      fit: BoxFit.cover,
    );

    if (blogDetail.imgUrl == null || blogDetail.imgUrl == "") {
      _dispImg = CachedNetworkImage(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/login-43130.appspot.com/o/no_image_available.png?alt=media&token=8881d61a-bed3-4f68-904e-290c52cfe5f7",
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: _dispImg,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          blogDetail.title.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Author :- ${blogDetail.authorName}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Description :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        blogDetail.description,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
