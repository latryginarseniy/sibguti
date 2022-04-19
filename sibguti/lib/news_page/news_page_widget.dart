import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../data/news.dart';
import '../open_news_page/open_news_page_widget.dart';
import 'news_page_widget_model.dart';

class NewsPageWidget extends StatefulWidget {
  const NewsPageWidget({Key? key}) : super(key: key);

  @override
  State<NewsPageWidget> createState() => _NewsPageWidgetState();
}

class _NewsPageWidgetState extends State<NewsPageWidget> {
  final _model = NewsPageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return NewsPageWidgetModelProvider(
        model: _model, child: const _NewsPageWidgetBody());
  }
}

class _NewsPageWidgetBody extends StatelessWidget {
  const _NewsPageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _NewsWidgetBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _NewsWidgetBody extends StatelessWidget {
  const _NewsWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _NewsWidget(),
        _SearchWidget(),
        Flexible(
          flex: 7,
          child: SingleChildScrollView(
              physics: ScrollPhysics(), child: NewsListWidget()),
        ),
      ],
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25.0, top: 50, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Новости",
            style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.blue.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              CupertinoIcons.bookmark_fill,
              size: 24,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1.0,
              offset: const Offset(0.0, 3.0))
        ],
      ),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          style: TextStyle(
            fontFamily: 'MontserratMedium',
            color: Colors.grey.shade900,
            fontSize: 15,
          ),
          cursorColor: Colors.grey.shade900,
          onChanged: (value) {},
          decoration: InputDecoration(
              prefixIcon: const Icon(
                CupertinoIcons.search,
                size: 24,
                color: Colors.grey,
              ),
              hintText: 'Поиск...',
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(width: 0.0, color: Colors.grey.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.grey.shade100),
              ),
              fillColor: Colors.grey.shade200,
              filled: true),
        ),
      ),
    );
  }
}

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = NewsPageWidgetModelProvider.read(context)?.model;
    return FutureBuilder<List<News>>(
      future: _model?.newsItems,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Shimmer.fromColors(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                        height: 150,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 8.0, top: 8.0, bottom: 8.0),
                        margin: const EdgeInsets.all(4),
                      ));
                },
              ),
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade100);
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var data = snapshot.data[index];
            return NewsItemWidget(
              imageUrl: data.image,
              heading: data.heading,
              description: data.description,
              date: data.date_created,
            );
          },
        );
      },
    );
  }
}

class NewsItemWidget extends StatelessWidget {
  String imageUrl;
  String heading;
  String description;
  String date;
  NewsItemWidget({
    Key? key,
    required this.imageUrl,
    required this.heading,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                    "http://alatryfd.beget.tech/uploads/${imageUrl}")),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            heading,
                            softWrap: true,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.1,
                              fontFamily: 'MontserratBold',
                              color: Colors.grey.shade800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          CupertinoIcons.bookmark,
                          size: 22,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'MontserratRegular',
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          date,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'MontserratBold',
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OpenNewsPageWidgetBody(
                                        description: description,
                                        heading: heading,
                                        imageUrl: imageUrl,
                                      )));
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            height: 32,
                            width: 80,
                            alignment: Alignment.center,
                            child: const Text(
                              'Смотреть',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'MontserratMedium',
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
