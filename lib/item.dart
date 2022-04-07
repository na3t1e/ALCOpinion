class Item {
  final int index;
  String name;
  String category;
  String? first;
  String? flavor;
  String? during;
  String? after;
  String? cost;
  String? shop;
  int rating;
  String date;

  Item(this.name, this.category, this.first, this.flavor, this.during,
      this.after, this.cost, this.shop, this.rating, this.date,
      {required this.index});
}
