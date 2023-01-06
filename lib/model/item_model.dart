class Item {
  List? image;
  String? name;
  String? weight;
  List? details;
  int? price;
  int? unit;
  String? id;
  String? mrp;
  String? uid;
  Item(
      {this.image,
      this.name,
      this.weight,
      this.details,
      this.price,
      this.id,
      this.unit,
      this.uid,
      this.mrp});

  @override
  bool operator ==(Object other) {
    return (other as Item).id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
