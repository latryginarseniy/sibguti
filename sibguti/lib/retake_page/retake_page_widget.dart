import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:sibguti/data/retake.dart';
import 'package:sibguti/retake_page/retake_page_widget_model.dart';
import '../data/news.dart';
import '../open_news_page/open_news_page_widget.dart';

class RetakePageWidget extends StatefulWidget {
  const RetakePageWidget({Key? key}) : super(key: key);

  @override
  State<RetakePageWidget> createState() => _RetakePageWidgetState();
}

class _RetakePageWidgetState extends State<RetakePageWidget> {
  final _model = RetakePageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return RetakePageWidgetModelProvider(
        model: _model, child: const _RetakePageWidgetBody());
  }
}

class _RetakePageWidgetBody extends StatelessWidget {
  const _RetakePageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _RetakeWidgetBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _RetakeWidgetBody extends StatelessWidget {
  const _RetakeWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _RetakeWidget(),
        Flexible(
          child: SingleChildScrollView(
              physics: ScrollPhysics(), child: _ScheduleBuilderWidget()),
        ),
      ],
    );
  }
}

class _RetakeWidget extends StatelessWidget {
  const _RetakeWidget({Key? key}) : super(key: key);

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
            "Пересдачи",
            style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.orange.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ScheduleBuilderWidget extends StatelessWidget {
  const _ScheduleBuilderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = RetakePageWidgetModelProvider.read(context)?.model;

    return FutureBuilder<List<Retake>>(
      future: _model?.newsItems,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Shimmer.fromColors(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 8.0, top: 8.0, bottom: 8.0),
                        margin: const EdgeInsets.all(4),
                      ));
                },
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100);
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            //Добавлены изменения
            var data = snapshot.data[index];
            return _ScheduleItemWidget(
              id: data.id,
              number: data.number,
              name: data.name,
              auditorium: data.auditorium,
              number_group: data.number_group,
              teacher: data.teacher,
              date_retake: data.date_retake,
              first_color: Colors.orange.shade700,
              last_color: Colors.red,
            );
          },
        );
      },
    );
  }
}

class _ScheduleItemWidget extends StatelessWidget {
  final String id;
  final String number;
  final String name;
  final String auditorium;
  final String number_group;
  final String teacher;
  final String date_retake;
  final first_color;
  final last_color;

  const _ScheduleItemWidget({
    Key? key,
    required this.id,
    required this.number,
    required this.name,
    required this.auditorium,
    required this.number_group,
    required this.teacher,
    required this.date_retake,
    required this.first_color,
    required this.last_color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0, bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTimeForLecture(int.parse(number)),
                  Container(
                    width: 2,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    height: double.maxFinite,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      first_color,
                      last_color,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.only(
                  left: 12.0, right: 8.0, top: 8.0, bottom: 8.0),
              margin: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.person_alt_circle_fill,
                          color: Colors.grey.shade200,
                          size: 14,
                        ),
                        Text(
                          teacher,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'MontserratRegular',
                            color: Colors.grey.shade300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'MontserratBold',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      date_retake,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'MontserratRegular',
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      height: 16,
                      width: 36,
                      alignment: Alignment.center,
                      child: Text(
                        auditorium,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTimeForLecture(int number_lecture) {
    switch (number_lecture) {
      case 1:
        return const _SetTimeWidget(
          first: '8:00',
          last: '9:35',
        );
      case 2:
        return const _SetTimeWidget(
          first: '9:50',
          last: '11:25',
        );
      case 3:
        return const _SetTimeWidget(
          first: '11:40',
          last: '13:15',
        );
      case 4:
        return const _SetTimeWidget(
          first: '13:45',
          last: '15:20',
        );
      case 5:
        return const _SetTimeWidget(
          first: '15:35',
          last: '17:10',
        );
      case 6:
        return const _SetTimeWidget(
          first: '17:25',
          last: '19:00',
        );

      default:
        return const _SetTimeWidget(
          first: '00:00',
          last: '00:00',
        );
    }
  }
}

class _SetTimeWidget extends StatelessWidget {
  final String first;
  final String last;
  const _SetTimeWidget({
    Key? key,
    required this.first,
    required this.last,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              first,
              style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              last,
              style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            )),
      ],
    );
  }
}
