import 'dart:developer';

import 'package:alcopinion/main.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  List<String> selected;
  bool all;

  Category({Key? key, required this.selected, required this.all})
      : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late List<String> selected = widget.selected;
  late bool all;
  TextStyle montserratBig = const TextStyle(
    fontSize: 48,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  final items = [
    'Абсент',
    'Виски',
    'Водка',
    'Джин',
    'Коньяк',
    'Ликер',
    'Напиток из вина',
    'Пивной напиток',
    'Ром',
    'Саке',
    'Текила',
    'Чача',
  ];

  TextStyle monserrat = const TextStyle(
      fontSize: 22,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: Colors.white);

  @override
  void initState() {
    super.initState();
    all = widget.all;
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 64, 1, 1),
        shape: const ContinuousRectangleBorder(
            side: BorderSide(
                width: 7, color: Color.fromRGBO(242, 182, 109, 0.8))),
        child: SafeArea(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 16, 30, 16),
                child: Text(
                  'Выбрать категории:',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(242, 182, 109, 0.8),
                  ),
                  maxLines: 3,
                ),
              ),
              checking(name: items[0]),
              checking(name: items[1]),
              checking(name: items[2]),
              checking(name: items[3]),
              checking(name: items[4]),
              checking(name: items[5]),
              checking(name: items[6]),
              checking(name: items[7]),
              checking(name: items[8]),
              checking(name: items[9]),
              checking(name: items[10]),
              checking(name: items[11]),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(
                          () {
                            all = true;
                            selected.clear();
                            log(selected.toString(), name: 'очищено');
                          },
                        );
                      },
                      child: Center(
                        child: SizedBox(
                          height: 46,
                          width: 125,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/light_bottom.png',
                              ),
                              Center(
                                child: Text(
                                  'Сброс',
                                  style: monserrat.apply(
                                      color:
                                          const Color.fromARGB(255, 64, 1, 1),
                                      fontSizeFactor: 1.27),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MainPage(
                              categories: selected,
                              all: all,
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: SizedBox(
                          height: 46,
                          width: 125,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/light_bottom.png',
                              ),
                              Center(
                                child: Text(
                                  'Готово',
                                  style: monserrat.apply(
                                      color:
                                          const Color.fromARGB(255, 64, 1, 1),
                                      fontSizeFactor: 1.27),
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checking({required String name}) {
    return MaterialButton(
      padding: const EdgeInsets.only(left: 40, right: 30),
      onPressed: () {
        if (selected.contains(name)) {
          setState(
            () {
              selected.remove(name);
              log(selected.toString(), name: 'select');
              if (selected.isEmpty) all = true;
              log(all.toString(), name: 'не выбрано');
            },
          );
        } else {
          setState(
            () {
              if (selected.isEmpty) all = false;
              selected.add(name);
              log(selected.toString(), name: 'not select');
            },
          );
        }
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'assets/check.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                (!all && selected.contains(name))
                    ? Image.asset(
                        'assets/checked.png',
                        width: 28,
                        height: 28,
                      )
                    : const SizedBox(
                        height: 28,
                        width: 28,
                      ),
              ],
            ),
          ),
          Text(name, style: monserrat),
        ],
      ),
    );
  }
}
