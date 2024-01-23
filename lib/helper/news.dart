import 'dart:convert';

import 'package:renotechnews/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{

  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url= "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=dcd81759c79040fa8dbb02cd76202f2e";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    //print(jsonData);

    if(jsonData['status']== "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element ["description"] != null){
         ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element["description"],
            url: element['url'],
            urlToImage: element['urlToImage'],
             content: element['content']
          );
         news.add(articleModel);

        }

      });
    }

  }
}

class CategoryNewsClass{

  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url= "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=dcd81759c79040fa8dbb02cd76202f2e";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
   // print(jsonData);

    if(jsonData['status']== "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element ["description"] != null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element["description"],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']
          );
          news.add(articleModel);

        }

      });
    }

  }
}