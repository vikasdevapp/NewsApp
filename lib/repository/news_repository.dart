import 'dart:convert';
import 'package:news_app/models/news_headline_response.dart';
import 'package:http/http.dart' as http;

class NewsRepository {

  Future<NewsHeadlineResponse> fetchHeadlineResponse({String source = 'bbc-news'}) async {
    String url = "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=fd5d9c1983c2488e99a31e654b290c8b";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsHeadlineResponse.fromJson(body);
      } else {
        throw Exception('Failed to load news headlines. Status code: ${response.statusCode}');
      }
  }
}