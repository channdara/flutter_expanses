enum Collection {
  // purchaseItems('purchase_items'),
  purchaseItems('purchase_items_debug'),
  // dailyExpenses('daily_expenses'),
  dailyExpenses('daily_expenses_debug'),
  // totalExpenses('monthly_expenses');
  totalExpenses('monthly_expenses_debug');

  const Collection(this.value);

  final String value;
}
