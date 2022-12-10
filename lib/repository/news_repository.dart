import 'package:um_mobile/model/news.dart';
import 'package:um_mobile/provider/api_provider.dart';

class NewsResponse {
  int code;
  String message;
  List<News> news;
  NewsResponse({required this.code, required this.message, required this.news});
}

class NewsRepository {
  //get api with dio
  Future<NewsResponse> getNews(String cat) async {
    var response = await ApiProvider.get(
            "https://scraping-um-node-js.vercel.app/post?cat=${cat}", {})
        .then((value) {
      if (value.statusCode == 200) {
        List<News> news = [];
        for (var item in value.data) {
          news.add(News.fromJson(item));
        }
        return NewsResponse(news: news, message: "success", code: 200);
      } else {
        return NewsResponse(
            news: [],
            message: "${value.statusMessage}",
            code: value.statusCode!);
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      return NewsResponse(news: [], message: "${error}", code: 500);
    });

    return response;
  }
}
