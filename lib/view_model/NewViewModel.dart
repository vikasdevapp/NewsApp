import 'package:news_app/models/news_headline_response.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel{

  final newsRepos=NewsRepository();

  Future<NewsHeadlineResponse> fetchNewChannelHeadline({String source = 'bbc-news'}) async{
    final response=await newsRepos.fetchHeadlineResponse(source: source);
    return response;
  }
}