import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sibguti/schedule_page/schedule_page_widget_model.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'university_page_widget_model.dart';

class UniversityPageWidget extends StatefulWidget {
  const UniversityPageWidget({Key? key}) : super(key: key);

  @override
  State<UniversityPageWidget> createState() => _UniversityPageWidgetState();
}

class _UniversityPageWidgetState extends State<UniversityPageWidget> {
  final _model = UniversityPageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return UniversityPageWidgetModelProvider(
        model: _model, child: const _UniversityPageWidgetBody());
  }
}

class _UniversityPageWidgetBody extends StatelessWidget {
  const _UniversityPageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _UniversityWidgetBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _UniversityWidgetBody extends StatelessWidget {
  const _UniversityWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeadingWidget(),
        _UniversityListWidget(),
      ],
    );
  }
}

class _HeadingWidget extends StatelessWidget {
  const _HeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 56, bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0)),
          color: Colors.blue.shade900,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "СибГУТИ",
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  CupertinoIcons.info,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Здравствуйте,\nЛатрыгин Арсений",
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                          fontFamily: 'MontserratMedium',
                          color: Colors.grey.shade100,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 32,
                      width: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ИС-042",
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: 'MontserratRegular',
                            color: Colors.grey.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UniversityListWidget extends StatelessWidget {
  const _UniversityListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = UniversityPageWidgetModelProvider.read(context)?.model;
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: <Widget>[
          const _ListItem(
            iconItem: CupertinoIcons.person,
            titleItem: 'Личные данные',
            trailingItem: CupertinoIcons.chevron_forward,
            functionOnTap: null,
          ),
          const Divider(),
          const _ListItem(
            iconItem: CupertinoIcons.doc_person,
            titleItem: 'Кабинеты',
            trailingItem: CupertinoIcons.chevron_forward,
            functionOnTap: null,
          ),
          const Divider(),
          const _ListItem(
            iconItem: CupertinoIcons.person_2,
            titleItem: 'Преподаватели',
            trailingItem: CupertinoIcons.chevron_forward,
            functionOnTap: null,
          ),
          const Divider(),
          const _ListItem(
            iconItem: CupertinoIcons.question_circle,
            titleItem: 'Информация для студнетов',
            trailingItem: CupertinoIcons.chevron_forward,
            functionOnTap: null,
          ),
          const Divider(),
          const _ListItem(
            iconItem: CupertinoIcons.settings,
            titleItem: 'Настройки',
            trailingItem: CupertinoIcons.chevron_forward,
            functionOnTap: null,
          ),
          const Divider(),
          ListTile(
            onTap: () => _model?.logOut(context),
            leading: Icon(
              CupertinoIcons.square_arrow_right,
              color: Colors.blue.shade900,
              size: 24,
            ),
            title: Text(
              'Выйти из аккаунта',
              style: TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.grey.shade800,
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              CupertinoIcons.chevron_forward,
              color: Colors.grey.shade700,
              size: 24,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final titleItem;
  final iconItem;
  final trailingItem;
  final functionOnTap;
  const _ListItem(
      {Key? key,
      required this.iconItem,
      required this.titleItem,
      required this.trailingItem,
      required this.functionOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => functionOnTap,
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
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        trailingItem,
        color: Colors.grey.shade700,
        size: 24,
      ),
    );
  }
}
