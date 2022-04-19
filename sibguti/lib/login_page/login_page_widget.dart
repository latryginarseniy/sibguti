import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../registration_page/registration_page_widget.dart';
import 'login_page_widget_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final _model = LoginPageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return LoginPageWidgetModelProvider(
        model: _model, child: const _LoginPageWidgetBody());
  }
}

class _LoginPageWidgetBody extends StatelessWidget {
  const _LoginPageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _LoginWidgetBody(),
      backgroundColor: Colors.blue.shade900,
    );
  }
}

class _LoginWidgetBody extends StatefulWidget {
  const _LoginWidgetBody({Key? key}) : super(key: key);

  @override
  State<_LoginWidgetBody> createState() => _LoginWidgetBodyState();
}

class _LoginWidgetBodyState extends State<_LoginWidgetBody> {
  @override
  Widget build(BuildContext context) {
    final _model = LoginPageWidgetModelProvider.read(context)?.model;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const _HeadingWidget(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              padding: const EdgeInsets.only(
                  left: 14.0, right: 10.0, top: 0, bottom: 0.0),
              child: const Text(
                "Войти",
                style: TextStyle(
                    fontFamily: 'MontserratBold',
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _TextFormWidget(controller: _model?.email, title: '   Введите почту'),
          _TextFormWidget(
              controller: _model?.password, title: '   Введите пароль'),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationPageWidget()),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Зарегистрироваться",
                              style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 60,
                          )),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () => _model?.login(context),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Войти",
                              style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 60,
                          )),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TextFormWidget extends StatelessWidget {
  final controller;
  final title;
  const _TextFormWidget(
      {Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'MontserratMedium',
            color: Colors.grey.shade100,
            fontSize: 15,
          ),
          cursorColor: Colors.grey.shade100,
          onChanged: (value) {},
          decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(
                fontFamily: 'MontserratMedium',
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.blue.shade800),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.blue.shade800),
              ),
              fillColor: Colors.blue.shade800,
              filled: true),
        ),
      ),
    );
  }
}

class _HeadingWidget extends StatelessWidget {
  const _HeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 160,
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 56, bottom: 16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "СибГУТИ",
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                    child: const Icon(
                      CupertinoIcons.info,
                      size: 24,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavigationBarWidget()),
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
