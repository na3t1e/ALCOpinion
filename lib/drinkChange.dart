import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'item.dart';
import 'main.dart';

class DrinkChange extends StatefulWidget {
  Item item;

  DrinkChange({Key? key, required this.item}) : super(key: key);

  @override
  State<DrinkChange> createState() => _DrinkChangeState();
}

class _DrinkChangeState extends State<DrinkChange> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    mark = widget.item.rating;
    selectedValue = widget.item.category;
    super.initState();
  }

  late int mark;
  final items = [
    'Выберите категорию напитка *',
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

  String? selectedValue;
  TextStyle montserrat = const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  TextStyle montserratBig = const TextStyle(
    fontSize: 48,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  TextStyle montserratFat = const TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 16, bottom: 8),
            color: const Color.fromARGB(255, 64, 1, 1),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'ALCOpinoion',
                          style: montserratBig.apply(
                              color: const Color.fromRGBO(242, 182, 109, 0.8)),
                        ),
                      ),
                      Text(
                        'ALCOpinoion',
                        style: montserratBig.apply(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/title.png',
                  width: 53,
                  height: 59,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('drinks').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          padding: const EdgeInsets.fromLTRB(40, 16, 0, 16),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            '← Назад',
                            style: montserratBig.apply(fontSizeFactor: 0.375),
                          ),
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.fromLTRB(0, 16, 40, 16),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('drinks')
                                .doc(snapshot.data.docs[widget.item.index].id)
                                .delete();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MyApp(),
                              ),
                            );
                          },
                          child: Text(
                            '× Удалить',
                            style: montserratBig.apply(fontSizeFactor: 0.375),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Хочу отредактировать: ',
                                    textAlign: TextAlign.center,
                                    style:
                                        montserrat.apply(fontSizeFactor: 1.6),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.name,
                                      onChanged: (content) =>
                                          widget.item.name = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText: 'Введите название напитка *',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      style: montserrat.apply(
                                          color: Colors.black,
                                          fontSizeFactor: 0.83),
                                      value: selectedValue,
                                      onChanged: (String? newValue) {
                                        setState(
                                            () => selectedValue = newValue);
                                        widget.item.category = newValue!;
                                      },
                                      items: items
                                          .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                          .toList(),
                                      icon: Text(
                                        '↓',
                                        style: montserratFat,
                                      ),
                                      iconSize: 24,
                                      underline: const SizedBox(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.first!,
                                      onChanged: (content) =>
                                          widget.item.first = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText:
                                            'Первое впечатление после глотка',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.flavor!,
                                      onChanged: (content) =>
                                          widget.item.flavor = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText: 'Как по вкусу',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.during!,
                                      onChanged: (content) =>
                                          widget.item.during = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText:
                                            'Самочувствие во время распития',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.after!,
                                      onChanged: (content) =>
                                          widget.item.after = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText:
                                            'Признаки жизни спустя 7 часов',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.cost!,
                                      onChanged: (content) =>
                                          widget.item.cost = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText: 'Стоимость',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color.fromRGBO(
                                              242, 182, 109, 0.8),
                                        )),
                                    child: TextField(
                                      controller: TextEditingController()
                                        ..text = widget.item.shop!,
                                      onChanged: (content) =>
                                          widget.item.shop = content,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText: 'Место приобретения',
                                        hintStyle: montserrat.apply(
                                            color: Colors.black,
                                            fontSizeFactor: 0.83),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 24, bottom: 24),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 94,
                                    child: Text(
                                      'Оцени вкусняшку *',
                                      style: montserrat.apply(
                                          color: Colors.black,
                                          fontSizeFactor: 0.83),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                          5,
                                          (index) => MaterialButton(
                                            minWidth: 34,
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {
                                              setState(() {
                                                mark = index + 1;
                                              });
                                            },
                                            child: (index + 1 <= mark)
                                                ? Image.asset(
                                                    'assets/fill_star.png',
                                                  )
                                                : Image.asset(
                                                    'assets/empty_star.png',
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (widget.item.name.isEmpty ||
                                  widget.item.category.isEmpty ||
                                  mark == 0) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      'Внимание!',
                                      style: montserratBig,
                                    ),
                                    content: Text(
                                      'Необходимо заполнить обязательные поля (с *)',
                                      style: montserrat,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Center(
                                          child: Text('OK',
                                              style: montserratBig.apply(
                                                  fontSizeFactor: 0.375)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              } else {
                                FirebaseFirestore.instance
                                    .collection('drinks')
                                    .doc(snapshot
                                        .data.docs[widget.item.index].id)
                                    .update({
                                  'name': widget.item.name,
                                  'category': widget.item.category,
                                  'first': widget.item.first,
                                  'flavor': widget.item.flavor,
                                  'during': widget.item.during,
                                  'after': widget.item.after,
                                  'cost': widget.item.cost,
                                  'shop': widget.item.shop,
                                  'rating': mark,
                                  'date': widget.item.date
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MyApp(),
                                  ),
                                );
                              }
                            },
                            child: Center(
                              child: SizedBox(
                                height: 60,
                                width: 150,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/save.png',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 15, 17, 14),
                                      child: Text(
                                        'Сохранить',
                                        style: montserratBig.apply(
                                            color: Colors.white,
                                            fontSizeFactor: 0.416),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
