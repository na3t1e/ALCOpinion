import 'dart:developer';
import 'dart:math' hide log;

import 'package:alcopinion/drinkAdd.dart';
import 'package:alcopinion/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'drinkView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALCOpinion',
      color: const Color.fromRGBO(242, 182, 109, 0.7),
      home: MainPage(
        categories: [],
        all: true,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  List<String> categories;
  bool all;

  MainPage({Key? key, required this.categories, required this.all})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late bool sort;
  late String vector;

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    sort = false;
    vector = '↑';
    super.initState();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  static const TextStyle montserrat = TextStyle(
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
    fontSize: 18,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    log(widget.categories.toString(), name: 'выбрала');
    return Scaffold(
      key: _globalKey,
      drawer: Category(selected: widget.categories, all: widget.all),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/category.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              width: 100,
                              child: const Flexible(
                                child: Text(
                                  'Показать категории',
                                  maxLines: 5,
                                  softWrap: true,
                                  style: montserrat,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _globalKey.currentState!.openDrawer();
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/add.png',
                              width: 69,
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              width: 100,
                              child: const Flexible(
                                child: Text('Добавить вкусняшку',
                                    maxLines: 5,
                                    softWrap: true,
                                    style: montserrat),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const DrinkAdd(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'ALCOлента',
                        style: montserratBig.apply(
                          color: const Color.fromARGB(255, 242, 182, 109),
                        ),
                      ),
                    ),
                    Text(
                      'ALCOлента',
                      style: montserratBig.apply(
                          color: const Color.fromARGB(255, 64, 1, 1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Сортировать: ',
                          style: montserrat,
                        ),
                      ),
                      MaterialButton(
                        height: 22,
                        onPressed: () {
                          setState(() {
                            sort = !sort;
                            if (sort) {
                              vector = '↓';
                            } else {
                              vector = '↑';
                            }
                          });
                        },
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          'по дате добавления ',
                          style: montserratFat,
                        ),
                      ),
                      Text(
                        vector,
                        style: montserratFat,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      267 -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('drinks')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return const Text(
                          'Пока что тут пусто...',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        );
                      }
                      return ListView.builder(
                        // reverse: sort,
                        itemCount: snapshot.data.docs.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          num type = 1 + Random().nextInt(4);
                          int newIndex = snapshot.data.docs.length - index - 1;
                          if (widget.all ||
                              (!widget.all &&
                                  widget.categories.contains(snapshot
                                      .data.docs[sort ? newIndex : index]
                                      .get('category')))) {
                            return Column(
                              children: [
                                /* if (sort && newIndex > 0)
                                  Image.asset(
                                    'assets/divider$type.png',
                                    fit: BoxFit.fill,
                                  ),*/
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Items(
                                    item: Item(
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('name'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('category'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('first'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('flavor'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('during'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('after'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('cost'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('shop'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('rating'),
                                      snapshot
                                          .data.docs[sort ? newIndex : index]
                                          .get('date'),
                                      index:
                                          index /*snapshot.data.docs[index]*/,
                                    ),
                                  ),
                                ),
                                if (index < snapshot.data.docs.length - 1 &&
                                        !sort ||
                                    sort && newIndex > 0)
                                  Image.asset(
                                    'assets/divider$type.png',
                                    fit: BoxFit.fill,
                                  ),
                              ],
                            );
                          }
                          return Container();
                        },
                      );
                    },
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

class Items extends StatelessWidget {
  final Item item;

  const Items({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/${name(2)}.png',
          // height: 80,
          width: 80,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Flexible(
                  child: Text(
                    '${name(1)} “${item.name}”',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    5,
                    (index) => (item.rating > index)
                        ? Image.asset(
                            'assets/fill_star.png',
                            width: 34,
                            height: 34,
                          )
                        : Image.asset(
                            'assets/empty_star.png',
                            width: 34,
                            height: 34,
                          )),
              ),
              MaterialButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DrinkView(item: item),
                  ),
                ),
                padding: EdgeInsets.zero,
                child: const Text(
                  'Поподробнее.....',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String name(int ind) {
    switch (item.category) {
      case ('Пивной напиток'):
        return (ind == 1) ? 'Пивас' : 'beer';
      case ('Винный напиток'):
        return (ind == 1) ? 'Винишко' : 'vine';
      case ('Текилка'):
        return (ind == 1) ? 'Текилка' : 'tequila';
      case ('Водка'):
        return (ind == 1) ? 'Водочка' : 'vodka';
      case ('Виски'):
        return (ind == 1) ? 'Виски' : 'whiskey';
      case ('Абсент'):
        return (ind == 1) ? 'Абсентик' : 'absinthe';
      case ('Чача'):
        return (ind == 1) ? 'Чача' : 'chacha';
      case ('Джин'):
        return (ind == 1) ? 'Джинчик' : 'gin';
      case ('Саке'):
        return (ind == 1) ? 'Саке' : 'sake';
      case ('Коньяк'):
        return (ind == 1) ? 'Коньячок' : 'cognac';
      case ('Ром'):
        return (ind == 1) ? 'Ромчик' : 'rum';
      case ('Ликер'):
        return (ind == 1) ? 'Ликерчик' : 'liquor';
      default:
        return (ind == 1) ? 'Алкоголь' : 'glass';
    }
  }
}
