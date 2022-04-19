import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'open_news_page_widget_model.dart';

class OpenNewsPageWidgetBody extends StatelessWidget {
  final imageUrl;
  final heading;
  final description;
  const OpenNewsPageWidgetBody(
      {Key? key,
      required this.imageUrl,
      required this.description,
      required this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _OpenNewsWidgetBody(
          imageUrl: imageUrl, heading: heading, description: description),
      backgroundColor: Colors.white,
    );
  }
}

class _OpenNewsWidgetBody extends StatelessWidget {
  final imageUrl;
  final heading;
  final description;
  const _OpenNewsWidgetBody(
      {Key? key,
      required this.imageUrl,
      required this.description,
      required this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HeaderWidget(),
        _ImageWidget(imageUrl: imageUrl),
        _TextWidget(heading: heading, description: description),
      ],
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 50.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.chevron_back,
              color: Colors.blue.shade900,
            ),
          ),
        ));
  }
}

class _ImageWidget extends StatelessWidget {
  _ImageWidget({Key? key, required this.imageUrl}) : super(key: key);
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "http://alatryfd.beget.tech/uploads/${imageUrl}",
              height: 300,
            )),
      ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  String heading;
  String description;
  _TextWidget({Key? key, required this.heading, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              heading,
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.grey.shade800,
                fontSize: 22,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'MontserratMedium',
                color: Colors.grey.shade800,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
