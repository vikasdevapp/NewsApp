import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Routes/routes_name.dart';
import 'package:news_app/models/news_headline_response.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screens/categories_screen.dart';
import 'package:news_app/view_model/NewViewModel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum NewsFilterList {
  bbcNews,aryNews,independent,reuters,cnn,alJazeera
}
class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  NewsFilterList? selectedMenu;
  final format = DateFormat('MMMM dd,yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoriesScreen()));
            },
            icon: Image.asset(
              'images/category_icon.png',
              width: 30,
              height: 30,
            )),
        title: Center(
            child: Text('News',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w700))),
        actions: [
          PopupMenuButton<NewsFilterList>(
            initialValue: selectedMenu,
              onSelected: (NewsFilterList item){
                  if(NewsFilterList.bbcNews.name==item.name){
                    name = 'bbc-news';
                  }
                  if(NewsFilterList.aryNews.name==item.name){
                    name = 'ary-news';
                  }
                  if(NewsFilterList.alJazeera.name==item.name){
                    name = 'al-jazeera-english';
                  }

                  setState(() {
                    selectedMenu=item;
                  });
              },
              itemBuilder:(BuildContext context )=>  <PopupMenuEntry<NewsFilterList>>[
                  const PopupMenuItem<NewsFilterList>(
                    value: NewsFilterList.bbcNews,
                      child:Text('BBC News')
                  ),
                  const PopupMenuItem<NewsFilterList>(
                    value: NewsFilterList.aryNews,
                    child:Text('Ary News')
                  ),
                  const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.alJazeera,
                      child:Text('Aljazeera')
                  ),
              ]
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
              height: height * .55,
              width: width * 55,
              child: FutureBuilder<NewsHeadlineResponse>(
                  future: newsViewModel.fetchNewChannelHeadline(source: name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {

                            DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * 0.48,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        width: width * 0.1,
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(child: spinKit2),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        height: height*0.22,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.35,
                                              // height: height * 0.,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  snapshot
                                                      .data!.articles![index].title
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: width*0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!.articles![index].source!.name
                                                        .toString(),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  Text(format.format(dateTime),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
