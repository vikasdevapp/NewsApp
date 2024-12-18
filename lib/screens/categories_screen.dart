import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_response.dart';
import 'package:news_app/view_model/CategoryViewModel.dart';

import 'home_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  Categoryviewmodel categoryviewmodel = Categoryviewmodel();
  final format = DateFormat('MMMM dd,yyyy');
  String categoryName = 'General';

  List<String> categoriesList=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                  itemBuilder: (context,index) {
                    return InkWell(
                      onTap: (){
                        categoryName=categoriesList[index];
                        setState(() {

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: categoryName==categoriesList[index]?Colors.blue:Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Center(child: Text(categoriesList[index].toString(),style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white
                            ), )),
                          ),
                        ),
                      ),
                    );
              }),
            ),
            SizedBox(height: 12,),
            Expanded(
              child: FutureBuilder<CategoriesNewsResponse>(
                  future: categoryviewmodel.fetchCategoriesNews(categoryName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data?.articles == null) {
                      return const Center(
                        child: Text('No news available'),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(
                                snapshot.data!.articles![index].publishedAt.toString()
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height:height*.18,
                                      width: width*.15,
                                      placeholder: (context, url) =>
                                          Container(child: Center(child: spinKit2)),
                                      errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        height: height * 0.18,
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Text(
                                                  snapshot.data!.articles![index].title
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                            Spacer(),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!.articles![index].source!.name
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
