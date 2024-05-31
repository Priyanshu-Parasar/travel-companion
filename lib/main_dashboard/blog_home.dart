import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/services/crud.dart';
import 'package:login/main_dashboard/create_blog.dart';
import 'package:login/utils/widgets/loading.dart';

import '../views/blog_details_view.dart';

final userId = FirebaseAuth.instance.currentUser?.uid;

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  _BlogHomePageState createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage>  with TickerProviderStateMixin {
  //bool myBlogs = false;
  late TabController _tabcontroller;
  String titleText = "All Blogs";

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
    
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> blogsStream =
    //     FirebaseFirestore.instance.collection("blogs").snapshots();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        //title: Text(titleText),
        bottom: TabBar(controller: _tabcontroller,
          tabs: const [
            Tab(text: "All Blogs",
              icon: Icon(Icons.menu_book),
            ),
            Tab(text: "My Blogs",
              icon: Icon(Icons.message),
            ),
          ],
        ),
      ),
      body: TabBarView( controller: _tabcontroller,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: (500),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("blogs").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error Loading the Data");
                      }
      
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("wating");
                        return const Center(child: CircularProgressIndicator());
                        
                      }
      
                      Future.delayed(const Duration(milliseconds: 400));
      
                      // print("-----------");
                      // print(snapshot.data);
      
                      List<DocumentSnapshot> _snap = [];
                      _snap.addAll(snapshot.data?.docs
                          as Iterable<DocumentSnapshot<Object?>>);
      
                      var _blogData =
                          _snap.map((e) => BlogsTile.fromFirestore(e)).toList();
      
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _blogData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // print("-----------");
                            // print(_blogData[index]);
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlogDetailsPage(
                                          blogDetail: _blogData[index],
                                        ),
                                      ));
                                },
                                child: _blogData[index]);
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: (MediaQuery.of(context).size.height - 160),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("blogs").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error Loading the Data");
                      }
      
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
      
                      Future.delayed(const Duration(milliseconds: 400));
      
                      // print("-----------");
                      // print(snapshot.data);
      
                      List<DocumentSnapshot> _snap = [];
                      _snap.addAll(snapshot.data?.docs
                              .where((element) => element.get("id") == userId)
                          as Iterable<DocumentSnapshot<Object?>>);
      
                      var _blogData =
                          _snap.map((e) => BlogsTile.fromFirestore(e)).toList();
      
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _blogData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // print("-----------");
                            // print(_blogData[index]);
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlogDetailsPage(
                                          blogDetail: _blogData[index],
                                        ),
                                      ));
                                },
                                child: _blogData[index]);
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateBlog()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.description,
      required this.authorName});

  factory BlogsTile.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data() as Map<String, dynamic>;

    return BlogsTile(
        authorName: d['authorName'] ?? "",
        title: d["title"] ?? "",
        description: d['desc'] ?? "",
        imgUrl: d['imgUrl'] ?? "");
  }

  @override
  Widget build(BuildContext context) {
    if (imgUrl == null || imgUrl == "") {
      imgUrl =
          "https://firebasestorage.googleapis.com/v0/b/login-43130.appspot.com/o/no_image_available.png?alt=media&token=8881d61a-bed3-4f68-904e-290c52cfe5f7";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                // Text(
                //   description,
                //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                Text(authorName, style: const TextStyle(color: Colors.white))
              ],
            ),
          )
        ],
      ),
    );
  }
}
