import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sibguti/schedule_page/schedule_page_widget_model.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

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

class _ScheduleWidgetBody extends StatelessWidget {
  const _ScheduleWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _ScheduleWidget(),
        _ScrollDateWidget(),
        Expanded(
          child: SingleChildScrollView(
              physics: ScrollPhysics(), child: _ListViewScheduleWidget()),
        ),
      ],
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
            "Расписание",
            style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.blue.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            CupertinoIcons.bell,
            size: 24,
            color: Colors.blue.shade900,
          ),
        ],
      ),
    );
  }
}

class _ScrollDateWidget extends StatelessWidget {
  const _ScrollDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              // New date selected
              // setState(() {
              //   _selectedValue = date;
              // });
            },
          ),
        ],
      ),
    );
  }
}

class _ListViewScheduleWidget extends StatelessWidget {
  const _ListViewScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 0.0, bottom: 10.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                '11:00',
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                '13:30',
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )),
                        ],
                      ),
                      Container(
                        width: 2,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        height: double.maxFinite,
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 10,
                child: _CardSubject(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardSubject extends StatelessWidget {
  const _CardSubject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3.0,
                offset: const Offset(0.0, 5.0))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding:
          const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0, bottom: 8.0),
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
                  '  Берлизов Д. М.',
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Программирование',
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Практика',
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
              child: const Text(
                '402a',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'MontserratBold',
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
