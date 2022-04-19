import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sibguti/course_page/course_page_widget.dart';

import '../news_page/news_page_widget.dart';
import '../schedule_page/schedule_page_widget.dart';
import '../university_page/university_page_widget.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottonNavigationBarWidgetState();
}

class _BottonNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SchedulePageWidget(),
    NewsPageWidget(),
    CoursePageWidget(),
    UniversityPageWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
            fontFamily: 'MontserratBold',
            fontSize: 12,
            color: Colors.blue.shade900),
        unselectedLabelStyle: const TextStyle(
            fontFamily: 'MontserratBold', fontSize: 12, color: Colors.black),
        unselectedItemColor: Colors.blue.shade900,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.calendar,
              color: Colors.grey,
            ),
            activeIcon:
                Icon(CupertinoIcons.calendar, color: Colors.blue.shade900),
            label: 'Расписание',
          ),
          BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.news_solid,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                CupertinoIcons.news_solid,
                color: Colors.blue.shade900,
              ),
              label: 'Новости'),
          BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.doc_chart,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                CupertinoIcons.doc_chart_fill,
                color: Colors.blue.shade900,
              ),
              label: 'Курсы'),
          BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.person,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                CupertinoIcons.person_alt,
                color: Colors.blue.shade900,
              ),
              label: 'Университет'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        onTap: _onItemTapped,
      ),
    );
  }
}
