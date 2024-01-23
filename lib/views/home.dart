
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:renotechnews/helper/data.dart';
import 'package:renotechnews/helper/news.dart';
import 'package:renotechnews/models/article_model.dart';
import 'package:renotechnews/models/categori_model.dart';
import 'package:renotechnews/views/article_view.dart';
import 'package:renotechnews/views/category_news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }
  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold (
        appBar: AppBar(
        title: const Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget> [
          Text("Renotech"),
          Text("News", style: TextStyle(
            color: Colors.amber
      ),)
     ],
    ),
    backgroundColor: Colors.blue ,
    centerTitle: true,
    elevation: 0.0,
    ),
    body: _loading ? Center(
      child: Container(
        child: const CircularProgressIndicator(),
      ),
    ) : Container(
     child: Column(
       children:<Widget> [

         //Categories
         Container(
           padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 70,
            child: ListView.builder(
              itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                return CategoryTile(
                  imageUrl: categories[index].imageUrl,
                  categoryName: categories[index].categoryName,
              );
              }),
         ),


         ///Blogs
         Expanded(
           child: Container(
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
         )
        ],
       ),
     )
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  const CategoryTile({
    super.key,
    required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toString().toLowerCase(),
            )
        ));

      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                   width: 120, height: 60, fit: BoxFit.cover, imageUrl: imageUrl,)
            ), // ClipRRect
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500

              ),),
            )
          ],
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
