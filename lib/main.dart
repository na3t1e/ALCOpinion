import 'dart:math';

import 'package:flutter/material.dart';
import 'categoty.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ALCOpinion',
      color: Color.fromRGBO(242, 182, 109, 0.7),
      home: MainPage(title: 'ALCOpinion'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const TextStyle montserrat = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );


  static const TextStyle marrow = TextStyle(
    color: Colors.black,
    fontSize: 48,
    fontFamily: 'Ribeye Marrow',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: const Color.fromRGBO(242, 182, 109, 0.7),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                widget.title,
                style: marrow,
              ),
            ),
            Image.asset(
              'assets/title.png',
              width: 53,
              height: 59,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      body: Padding(
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
                    onPressed: () {},
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
                            child: Text(
                              'Добавить вкусняшку',
                              maxLines: 5,
                              softWrap: true,
                              style: montserrat
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Stack(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 6),
                  child: Text(
                    'ALCOлента',
                    style: TextStyle(
                      color: Color.fromRGBO(242, 182, 109, 0.7),
                      fontSize: 55,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Text(
                  'ALCOлента',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 55,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
            /*Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 8),
              child: ListView.custom(
                // reverse: true,
                childrenDelegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    int type = 1 + Random().nextInt(4);
                    return Column(
                      children: [
                        if (i > 0)
                          Image.asset(
                            'assets/divider$type.png',
                            fit: BoxFit.fill,
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Item(
                            type: type,
                            title: 'Волковская пивоварня',
                            rating: 1 + Random().nextInt(5),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),*/
            Column(
              children: List.generate(
                3,
                (index) {
                  int type = 1 + Random().nextInt(4);
                  return Column(
                    children: [
                      if (index > 0)
                        Image.asset(
                          'assets/divider$type.png',
                          fit: BoxFit.fill,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Item(
                          type: type,
                          title: 'Волковская пивоварня',
                          rating: 1 + Random().nextInt(5),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final int type;
  final String title;
  final int rating;

  const Item(
      {Key? key, required this.type, required this.title, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/${image()}.png',
          // height: 80,
          width: 80,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Flexible(
                  child: Text(
                    '${name()} “$title”',
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
                  (index) => (rating > index)
                      ? const Icon(
                          Icons.star,
                          size: 32,
                        )
                      : const Icon(
                          Icons.star_border,
                          size: 32,
                        ),
                ),
              ),
              MaterialButton(
                onPressed: () {},
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

  String image() {
    switch (type) {
      case (1):
        return 'beer';
      case (2):
        return 'vine';
      case (3):
        return 'strong';
      default:
        return 'glass';
    }
  }

  String name() {
    switch (type) {
      case (1):
        return 'Пивас';
      case (2):
        return 'Винишко';
      case (3):
        return 'Текилка';
      default:
        return 'Алкоголь';
    }
  }
}
