enum ItemType {
  me(0),
  bee(1),
  both(2);

  const ItemType(this.value);

  final int value;

  static ItemType getItemType(int value) =>
      ItemType.values.singleWhere((element) => element.value == value);
}
