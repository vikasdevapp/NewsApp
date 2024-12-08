import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/categories_news_response.dart';

class CategoryRepository{

  Future<CategoriesNewsResponse> fetchCategories(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?category=$category&apiKey=fd5d9c1983c2488e99a31e654b290c8b";

    try {
      final response = await http.get(Uri.parse(url));

      print('Request URL: $url'); // Debug print
      print('Response Status Code: ${response.statusCode}'); // Debug print
      print('Response Body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return CategoriesNewsResponse.fromJson(body);
      } else {
        throw Exception('Failed to load news categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }
}