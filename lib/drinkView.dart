import 'package:flutter/material.dart';
import 'drinkChange.dart';
import 'item.dart';

class DrinkView extends StatefulWidget {
  final Item item;

  const DrinkView({Key? key, required this.item}) : super(key: key);

  @override
  State<DrinkView> createState() => _DrinkViewState();
}

class _DrinkViewState extends State<DrinkView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
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
                padding: const EdgeInsets.fromLTRB(16, 16, 40, 16),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DrinkChange(item: widget.item),
                  ),
                ),
                child: Text(
                  'Редактировать',
                  style: montserratBig.apply(fontSizeFactor: 0.375),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  132 -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Center(
                    child: Text(
                      '*${widget.item.name}*',
                      style: montserrat.apply(fontSizeFactor: 1.6),
                    ),
                  ),
                  Items(
                    text: widget.item.category,
                  ),
                  Items(
                    text: widget.item.first == ''
                        ? 'Был испробован'
                        : widget.item.first!,
                  ),
                  Items(
                    text: widget.item.flavor == ''
                        ? 'Вкус не определен'
                        : widget.item.flavor!,
                  ),
                  Items(
                    text: widget.item.during == ''
                        ? 'Во время потребления присутствуют признаки жизни'
                        : widget.item.during!,
                  ),
                  Items(
                    text: widget.item.after == ''
                        ? 'Спустя 7 часов признаков жизни не обнаружено'
                        : widget.item.after!,
                  ),
                  Items(
                    text:
                        widget.item.cost == '' ? 'Бесценно' : widget.item.cost!,
                  ),
                  Items(
                    text: widget.item.shop == ''
                        ? 'Найдено где-то'
                        : widget.item.shop!,
                  ),
                  Items(
                    text: widget.item.date,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12, left: 12, top: 24, bottom: 24),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 94,
                            child: Text(
                              'Оценка вкусняшки',
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
                                  (index) => (widget.item.rating > index)
                                      ? Image.asset(
                                          'assets/fill_star.png',
                                          width: 34,
                                          height: 34,
                                        )
                                      : Image.asset(
                                          'assets/empty_star.png',
                                          width: 34,
                                          height: 34,
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 150,
                        child: Image.asset(
                          'assets/ok.png',
                          height: 53,
                          width: 143,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Items extends StatelessWidget {
  final String text;

  const Items({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle montserrat = const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 2,
              color: const Color.fromRGBO(242, 182, 109, 0.8),
            )),
        child: Text(
          text,
          style: montserrat.apply(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
