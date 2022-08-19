enum ItemType {
  me(1),
  bee(2),
  both(3);

  const ItemType(this.value);

  final int value;

  static ItemType getValueBy(int number) =>
      ItemType.values.singleWhere((element) => element.value == number);

  static ItemType getValueByIndex(int index) =>
      ItemType.values.singleWhere((element) => element.value == (index + 1));
}
