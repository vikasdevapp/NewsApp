import 'package:news_app/models/news_headline_response.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel{

  final _repo=NewsRepository();

  Future<NewsHeadlineResponse> fetchNewChannelHeadline() async{
    final response=await _repo.fetchHeadlineResponse();
    return response;
  }
}