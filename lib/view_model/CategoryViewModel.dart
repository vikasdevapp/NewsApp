import 'package:news_app/models/categories_news_response.dart';
import 'package:news_app/repository/category_repository.dart';

class Categoryviewmodel{

  final categoryRepo=CategoryRepository();

    Future<CategoriesNewsResponse> fetchCategoriesNews(String category) async{
    final response=await categoryRepo.fetchCategories(category);
    return response;
  }
}