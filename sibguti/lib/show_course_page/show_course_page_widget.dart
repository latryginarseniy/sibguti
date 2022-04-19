import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sibguti/data/lecture.dart';
import 'package:sibguti/show_course_page/show_course_page_widget_model.dart';

import '../data/ads_course.dart';

class ShowCoursePageWidget extends StatefulWidget {
  final String id;
  final String name_course;
  final String description_course;
  final String teacher_course;
  final String number_course;

  const ShowCoursePageWidget(
      {Key? key,
      required this.id,
      required this.name_course,
      required this.description_course,
      required this.teacher_course,
      required this.number_course})
      : super(key: key);

  @override
  State<ShowCoursePageWidget> createState() => _ShowCoursePageWidgetState();
}

class _ShowCoursePageWidgetState extends State<ShowCoursePageWidget> {
  @override
  Widget build(BuildContext context) {
    final _model = ShowCoursePageWidgetModel(
      id: widget.id,
      name_course: widget.name_course,
      description_course: widget.description_course,
      teacher_course: widget.teacher_course,
      number_course: widget.number_course,
    );
    return ShowCoursePageWidgetModelProvider(
        model: _model, child: const _ShowCoursePageWidgetBody());
  }
}

class _ShowCoursePageWidgetBody extends StatefulWidget {
  const _ShowCoursePageWidgetBody({Key? key}) : super(key: key);

  @override
  State<_ShowCoursePageWidgetBody> createState() =>
      _ShowCoursePageWidgetBodyState();
}

class _ShowCoursePageWidgetBodyState extends State<_ShowCoursePageWidgetBody> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    _AdsWidget(),
    _LectureWidget(),
    _TestWidget(),
    _AboutWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _model = ShowCoursePageWidgetModelProvider.read(context)?.model;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
              child: Container(
            color: Colors.blue.shade900,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 12.0, top: 50, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        _model!.name_course,
                        maxLines: 3,
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          CupertinoIcons.settings,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () => _onItemTapped(0),
                      child: _CardThemeWidget(
                        icon: CupertinoIcons.text_bubble_fill,
                        title: 'Объявления',
                        active_code: _selectedIndex,
                        personal_code: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () => _onItemTapped(1),
                      child: _CardThemeWidget(
                        icon: CupertinoIcons.video_camera_solid,
                        title: 'Лекции',
                        active_code: _selectedIndex,
                        personal_code: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () => _onItemTapped(2),
                      child: _CardThemeWidget(
                        icon: CupertinoIcons.doc_on_clipboard,
                        title: 'Тесты',
                        active_code: _selectedIndex,
                        personal_code: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () => _onItemTapped(3),
                      child: _CardThemeWidget(
                        icon: CupertinoIcons.person_fill,
                        title: 'О курсе',
                        active_code: _selectedIndex,
                        personal_code: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )),
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
    );
  }
}

//Страница об объявлениях
class _AdsWidget extends StatelessWidget {
  const _AdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = ShowCoursePageWidgetModelProvider.read(context)?.model;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 25.0, top: 24, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Объявления",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.blue.shade900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  child: FutureBuilder<List<AdsCourse>>(
                      future: _model?.adsCourseItems,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Shimmer.fromColors(
                              child: ListView.separated(
                                controller: scrollController,
                                padding: const EdgeInsets.only(top: 8),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 5,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Container(
                                        height: 80,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        padding: const EdgeInsets.only(
                                            left: 12.0,
                                            right: 8.0,
                                            top: 8.0,
                                            bottom: 8.0),
                                        margin: const EdgeInsets.all(4),
                                      ));
                                },
                              ),
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade100);
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          controller: scrollController,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data[index];
                            return _ListItemCourseWidget(
                              ads_description: data.ads_description,
                              ads_heading: data.ads_heading,
                              date_created: data.date_created,
                              course_id: data.course_id,
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//Страница о лекциях
class _LectureWidget extends StatelessWidget {
  const _LectureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _model = ShowCoursePageWidgetModelProvider.read(context)?.model;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 25.0, top: 24, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Лекции",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.blue.shade900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Scrollbar(
                  child: FutureBuilder<List<Lecture>>(
                    future: _model?.lectureItems,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 8),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      padding: const EdgeInsets.only(
                                          left: 12.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0),
                                      margin: const EdgeInsets.all(4),
                                    ));
                              },
                            ),
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade100);
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(0),
                        controller: scrollController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = snapshot.data[index];
                          return _ListItem(
                            iconItem: CupertinoIcons.folder,
                            titleItem: data.name_lecture,
                            trailingItem: CupertinoIcons.chevron_forward,
                            link_lecture: data.link_lecture,
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//Страница о тестах
class _TestWidget extends StatelessWidget {
  const _TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 25.0, top: 24, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Тесты",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.blue.shade900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Scrollbar(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return _ListItem(
                        iconItem: CupertinoIcons.doc_on_doc,
                        titleItem: 'Тест по материалам ${index + 1} лекции',
                        trailingItem: CupertinoIcons.chevron_forward,
                        link_lecture: '',
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//Страница о курсе
class _AboutWidget extends StatelessWidget {
  const _AboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = ShowCoursePageWidgetModelProvider.read(context)?.model;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 25.0, top: 24, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "О курсе",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.blue.shade900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      CupertinoIcons.info,
                      size: 24,
                      color: Colors.blue.shade900,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _model!.name_course,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Colors.grey.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _model.description_course,
                          style: TextStyle(
                              fontFamily: 'MontserratRegular',
                              color: Colors.grey.shade900,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final titleItem;
  final iconItem;
  final trailingItem;
  final link_lecture;
  const _ListItem(
      {Key? key,
      required this.iconItem,
      required this.titleItem,
      required this.trailingItem,
      required this.link_lecture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = ShowCoursePageWidgetModelProvider.read(context)?.model;
    return ListTile(
      onTap: () => _model?.launchURL(link_lecture),
      leading: Icon(
        iconItem,
        color: Colors.blue.shade900,
        size: 24,
      ),
      title: Text(
        titleItem,
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Colors.grey.shade800,
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        trailingItem,
        color: Colors.grey.shade400,
        size: 24,
      ),
    );
  }
}

class _CardThemeWidget extends StatefulWidget {
  final icon;
  final title;

  final personal_code;
  final active_code;
  const _CardThemeWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.personal_code,
      required this.active_code})
      : super(key: key);

  @override
  State<_CardThemeWidget> createState() => _CardThemeWidgetState();
}

class _CardThemeWidgetState extends State<_CardThemeWidget> {
  bool isOpen = false;

  bool setCondition() {
    if (widget.personal_code == widget.active_code) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return setCondition()
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 4.0, left: 10, right: 10.0),
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  color: Colors.blue.shade900,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 44.0,
                    width: 44.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Icon(
                      widget.icon,
                      color: Colors.grey.shade100,
                      size: 24,
                    ),
                  ),
                  Text(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: Colors.grey.shade100,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 4.0, left: 10, right: 10.0),
              height: 120.0,
              width: 120.0,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 44.0,
                    width: 44.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Icon(
                      widget.icon,
                      color: Colors.blue.shade900,
                      size: 24,
                    ),
                  ),
                  Text(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: Colors.grey.shade800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class _ListItemCourseWidget extends StatelessWidget {
  final String course_id;
  final String ads_heading;
  final String ads_description;
  final String date_created;
  const _ListItemCourseWidget({
    Key? key,
    required this.course_id,
    required this.ads_heading,
    required this.ads_description,
    required this.date_created,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 24.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 8.0))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                date_created,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  fontFamily: 'MontserratRegular',
                  color: Colors.grey.shade100,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ads_heading,
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.1,
                  fontFamily: 'MontserratBold',
                  color: Colors.grey.shade100,
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ads_description,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  fontFamily: 'MontserratRegular',
                  color: Colors.grey.shade100,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
