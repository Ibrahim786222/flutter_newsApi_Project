import 'package:flutter/material.dart';
import 'package:renotechnews/helper/news.dart';
import 'package:renotechnews/models/article_model.dart';
import 'package:renotechnews/views/article_view.dart';

 class CategoryNews  extends StatefulWidget {

  final String category;
  const CategoryNews({super.key, required this.category});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState  extends State<CategoryNews > {

  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Renotech"),
            Text("News", style: TextStyle(color: Colors.amber),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.save),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return BlogTile(imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BlogTile extends StatelessWidget {
  //const BlogTile({super.key, required this.imageUrl, required this.title, required this.desc});
  final String imageUrl, title, desc, url;
  const BlogTile({required this.imageUrl, required this.title, required this.desc, required this.url,  super.key, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,

            )
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)
            ),
            const SizedBox(height: 8,),
            Text(title, style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500
            ),),
            const SizedBox(height: 8,),
            Text(desc, style: const TextStyle(
                color: Colors.black54
            ),),
          ],
        ),
      ),
    );
  }
}