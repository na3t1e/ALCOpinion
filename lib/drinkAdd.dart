import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'item.dart';

class DrinkAdd extends StatefulWidget {
  const DrinkAdd({Key? key}) : super(key: key);

  @override
  State<DrinkAdd> createState() => _DrinkAddState();
}

class _DrinkAddState extends State<DrinkAdd> {
  int mark = 0;
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

  String? selectedValue = 'Выберите категорию напитка *';
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
  Item? item = Item('', '', '', '', '', '', '', '', 0, '', index: 0);

  @override
  void initState() {
    super.initState();
  }

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
          MaterialButton(
            padding: const EdgeInsets.fromLTRB(40, 16, 0, 16),
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '← Назад',
                  style: montserratBig.apply(fontSizeFactor: 0.375),
                ),
              ],
            ),
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
                          'Добавь вкусняшку: ',
                          style: montserrat.apply(fontSizeFactor: 1.6),
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
                                color: const Color.fromRGBO(242, 182, 109, 0.8),
                              )),
                          child: TextField(
                            onChanged: (content) => item!.name = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Введите название напитка *',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromRGBO(242, 182, 109, 0.8),
                            ),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: montserrat.apply(
                                color: Colors.black, fontSizeFactor: 0.83),
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() => selectedValue = newValue);
                              item!.category = newValue!;
                            },
                            items: items
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
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
                              color: const Color.fromRGBO(242, 182, 109, 0.8),
                            ),
                          ),
                          child: TextField(
                            onChanged: (content) => item!.first = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Первое впечатление после глотка',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
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
                                color: const Color.fromRGBO(242, 182, 109, 0.8),
                              )),
                          child: TextField(
                            onChanged: (content) => item!.flavor = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Как по вкусу',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
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
                                color: const Color.fromRGBO(242, 182, 109, 0.8),
                              )),
                          child: TextField(
                            onChanged: (content) => item!.during = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Самочувствие во время расития',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
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
                                color: const Color.fromRGBO(242, 182, 109, 0.8),
                              )),
                          child: TextField(
                            onChanged: (content) => item!.after = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Признаки жизни спустя 7 часов',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
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
                                color: const Color.fromRGBO(242, 182, 109, 0.8),
                              )),
                          child: TextField(
                            onChanged: (content) => item!.cost = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Стоимость',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
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
                                color: const Color.fromRGBO(242, 182, 109, 0.8),
                              )),
                          child: TextField(
                            onChanged: (content) => item!.shop = content,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Место приобретения',
                              hintStyle: montserrat.apply(
                                  color: Colors.black, fontSizeFactor: 0.83),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 94,
                          child: Text(
                            'Оцени вкусняшку *',
                            style: montserrat.apply(
                                color: Colors.black, fontSizeFactor: 0.83),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                    if (item!.name.isEmpty ||
                        item!.category.isEmpty ||
                        mark == 0) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
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
                              onPressed: () => Navigator.of(context).pop(),
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
                      FirebaseFirestore.instance.collection('drinks').add({
                        'name': item!.name,
                        'category': item!.category,
                        'first': item!.first,
                        'flavor': item!.flavor,
                        'during': item!.during,
                        'after': item!.after,
                        'cost': item!.cost,
                        'shop': item!.shop,
                        'rating': mark,
                        'date': DateFormat('yyyy-MM-dd')
                            .format(DateTime.now())
                            .toString()
                      });
                      Navigator.of(context).pop();
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
                            padding: const EdgeInsets.fromLTRB(16, 15, 17, 14),
                            child: Text(
                              'Сохранить',
                              style: montserratBig.apply(
                                  color: Colors.white, fontSizeFactor: 0.416),
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
      ),
    );
  }
}
