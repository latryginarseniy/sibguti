import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sibguti/data/schedule.dart';
import 'package:sibguti/schedule_page/schedule_page_widget_model.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:shimmer/shimmer.dart';

import '../retake_page/retake_page_widget.dart';

class SchedulePageWidget extends StatefulWidget {
  const SchedulePageWidget({Key? key}) : super(key: key);

  @override
  State<SchedulePageWidget> createState() => _SchedulePageWidgetState();
}

class _SchedulePageWidgetState extends State<SchedulePageWidget> {
  final _model = SchedulePageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return SchedulePageWidgetModelProvider(
        model: _model, child: const _SchedulePageWidgetBody());
  }
}

class _SchedulePageWidgetBody extends StatelessWidget {
  const _SchedulePageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ScheduleWidgetBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _ScheduleWidgetBody extends StatefulWidget {
  const _ScheduleWidgetBody({Key? key}) : super(key: key);

  @override
  State<_ScheduleWidgetBody> createState() => __ScheduleWidgetBodyState();
}

class __ScheduleWidgetBodyState extends State<_ScheduleWidgetBody> {
  DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final _model = SchedulePageWidgetModelProvider.read(context)?.model;
    return Column(
      children: <Widget>[
        const _ScheduleWidget(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 1.0,
                  offset: const Offset(0.0, 3.0))
            ],
          ),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DatePicker(
                DateTime.now(),
                locale: "ru",
                width: 50,
                height: 76,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.blue.shade900,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  _model?.daySelected = date.weekday;
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: _ScheduleBuilderWidget(
                model: _model,
                daySelected: _selectedValue.weekday,
              )),
        ),
      ],
    );
  }
}

class _ScheduleBuilderWidget extends StatelessWidget {
  const _ScheduleBuilderWidget({
    Key? key,
    required SchedulePageWidgetModel? model,
    required this.daySelected,
  })  : _model = model,
        super(key: key);
  final int daySelected;
  final SchedulePageWidgetModel? _model;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Schedule>>(
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
            //?????????????????? ??????????????????
            var k = 0;
            var data = snapshot.data[index];
            for (int i = 0; i < snapshot.data.length; i++) {
              if (int.parse(snapshot.data[i].day_week) == _model?.daySelected) {
                k++;
                if (int.parse(snapshot.data[i].number) == index) {
                  var data = snapshot.data[i];

                  return _ScheduleItemWidget(
                    auditorium: data.auditorium,
                    day_week: data.day_week,
                    lecture: data.lecture,
                    name: data.name,
                    number_group: data.number_group,
                    number: data.number,
                    teacher: data.teacher,
                    first_color: Colors.blue.shade800,
                    last_color: Colors.blue.shade900,
                  );
                }
              }
            }
            if (k == 0) {
              return Container(
                width: double.infinity,
                height: 440,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset("assets/non_image.png"),
                    ),
                    Text(
                      "?????? ??????",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.blue.shade500,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _ScheduleWidget extends StatelessWidget {
  const _ScheduleWidget({Key? key}) : super(key: key);

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
            "????????????????????",
            style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.blue.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RetakePageWidget()));
            },
            icon: Icon(
              CupertinoIcons.bell,
              size: 24,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleItemWidget extends StatelessWidget {
  final number;
  final name;
  final auditorium;
  final lecture;
  final number_group;
  final teacher;
  final day_week;
  final first_color;
  final last_color;

  const _ScheduleItemWidget({
    Key? key,
    required this.number,
    required this.name,
    required this.auditorium,
    required this.lecture,
    required this.number_group,
    required this.teacher,
    required this.day_week,
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
                      // Colors.blue.shade800,
                      // Colors.blue.shade900,
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
                      lecture,
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
