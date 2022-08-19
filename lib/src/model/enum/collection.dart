enum Collection {
  purchaseItems('purchase_items'),
  // purchaseItems('purchase_items_debug'),
  totalExpenses('total_expenses');
  // totalExpenses('total_expenses_debug');

  const Collection(this.value);

  final String value;
}
