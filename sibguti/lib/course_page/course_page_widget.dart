import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import '../data/course.dart';
import '../show_course_page/show_course_page_widget.dart';
import 'course_page_widget_model.dart';

class CoursePageWidget extends StatefulWidget {
  const CoursePageWidget({Key? key}) : super(key: key);

  @override
  State<CoursePageWidget> createState() => _CoursePageWidgetState();
}

class _CoursePageWidgetState extends State<CoursePageWidget> {
  final _model = CoursePageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return CoursePageWidgetModelProvider(
        model: _model, child: const _CoursePageWidgetBody());
  }
}

class _CoursePageWidgetBody extends StatelessWidget {
  const _CoursePageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _CourseWidgetBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _CourseWidgetBody extends StatelessWidget {
  const _CourseWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _CourseWidget(),
        _SearchWidget(),
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
              physics: ScrollPhysics(), child: _CourseListWidget()),
        ),
      ],
    );
  }
}

class _CourseWidget extends StatelessWidget {
  const _CourseWidget({Key? key}) : super(key: key);

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
            "Курсы",
            style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.blue.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            CupertinoIcons.bookmark,
            size: 24,
            color: Colors.blue.shade900,
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
              color: Colors.grey.shade200,
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

class _CourseListWidget extends StatelessWidget {
  const _CourseListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = CoursePageWidgetModelProvider.read(context)?.model;

    /////////////////////////////////
    return FutureBuilder<List<Course>>(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
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
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var data = snapshot.data[index];
                return _ListItemCourseWidget(
                  id: data.id,
                  name_course: data.name_course,
                  description_course: data.description_course,
                  teacher_course: data.teacher_course,
                  number_course: data.number_course,
                );
              });
        });
  }
}

class _ListItemCourseWidget extends StatelessWidget {
  final String id;
  final String name_course;
  final String description_course;
  final String teacher_course;
  final String number_course;
  const _ListItemCourseWidget(
      {Key? key,
      required this.id,
      required this.name_course,
      required this.description_course,
      required this.teacher_course,
      required this.number_course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowCoursePageWidget(
                    id: id,
                    name_course: name_course,
                    description_course: description_course,
                    teacher_course: teacher_course,
                    number_course: number_course,
                  )),
        );
      },
      child: Container(
        height: 100,
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
                  '${number_course} курс',
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'MontserratRegular',
                    color: Colors.grey.shade300,
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name_course,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.1,
                          fontFamily: 'MontserratBold',
                          color: Colors.grey.shade100,
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
                      color: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  teacher_course,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'MontserratRegular',
                    color: Colors.grey.shade100,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
