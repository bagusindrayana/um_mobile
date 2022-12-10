import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:um_mobile/component/news_item.dart';
import 'package:um_mobile/model/news.dart';
import 'package:um_mobile/provider/utility_provider.dart';
import 'package:um_mobile/repository/news_repository.dart';

class HomeElement extends StatefulWidget {
  const HomeElement({super.key});

  @override
  State<HomeElement> createState() => _HomeElementState();
}

class _HomeElementState extends State<HomeElement>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<News> newsList = [];
  String cat = "berita";
  bool loading = false;

  void getNewsData() async {
    setState(() {
      loading = true;
    });
    await NewsRepository().getNews(cat).then((value) {
      if (value.code == 200) {
        setState(() {
          newsList = value.news;
          loading = false;
        });
      } else {
        setState(() {
          newsList = [];
          loading = false;
        });
        UtilityProvider.showAlertDialog("Ops", value.message, context);
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNewsData();
    setState(() {
      _tabController = TabController(length: 3, vsync: this);
      _tabController?.addListener(() {
        setState(() {
          if (_tabController!.index == 0) {
            cat = "berita";
          } else if (_tabController!.index == 1) {
            cat = "pengumuman";
          } else {
            cat = "pelatihan";
          }
          getNewsData();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 36,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //#E7E2E2
                    color: Color(0xFFE7E2E2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      color: Colors.white,
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    padding: EdgeInsets.all(6),
                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Berita',
                      ),

                      // second tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Pengumuman',
                      ),
                      Tab(
                        text: 'Pelatihan',
                      ),
                    ],
                  ),
                )),
            Flexible(
                child: RefreshIndicator(
              onRefresh: () async {
                getNewsData();
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(6),
                            height: 190,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "${newsList[index].image}"))),
                          ),
                          Container(
                            margin: EdgeInsets.all(6),
                            height: 190,
                            decoration: BoxDecoration(
                              color: Color(0xFFE7E2E2),
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    Color(0xFFA10302),
                                  ],
                                  stops: [
                                    0.0,
                                    1.0
                                  ]),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/images/logo_um.png',
                                        width: 30,
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "${newsList[index].title}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return NewsItem(news: newsList[index]);
                    }
                  }),
            ))
          ],
        ),
        (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox()
      ],
    );
  }
}
