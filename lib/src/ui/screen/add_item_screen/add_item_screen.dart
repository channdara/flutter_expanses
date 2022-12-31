import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/string_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/enum/item_type.dart';
import '../../../model/item_model.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';
import 'add_item_screen_tab_bar.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key, this.item});

  final ItemModel? item;

  bool get willAdd => item == null;

  String get appBarTitle => willAdd ? 'Take Note' : 'Edit Note';

  String get buttonText => willAdd ? 'Add' : 'Update';

  String get getDate =>
      willAdd ? Timestamp.now().toYearMonthDay() : item!.date.toYearMonthDay();

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends BaseState<AddItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _itemController;
  late TextEditingController _dollarController;
  late TextEditingController _rielController;
  late TextEditingController _dateController;
  late FocusNode _itemFocusNode;
  late FocusNode _dollarFocusNode;
  late FocusNode _rielFocusNode;

  Timestamp timestamp = Timestamp.now();

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: widget.item?.type.value ?? 0,
      length: ItemType.values.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabListener);

    _itemController = TextEditingController(text: widget.item?.content);
    _dollarController = TextEditingController(text: widget.item?.totalDollar());
    _rielController = TextEditingController(text: widget.item?.totalRiel());
    _dateController = TextEditingController(text: widget.getDate);

    _itemFocusNode = FocusNode();
    _dollarFocusNode = FocusNode();
    _rielFocusNode = FocusNode();
    if (widget.willAdd) _itemFocusNode.requestFocus();
    if (!widget.willAdd) timestamp = widget.item!.date;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _itemController.dispose();
    _dollarController.dispose();
    _rielController.dispose();
    _dateController.dispose();
    _itemFocusNode.dispose();
    _dollarFocusNode.dispose();
    _rielFocusNode.dispose();
    super.dispose();
  }

  void _handleTabListener() {
    if (!_tabController.indexIsChanging) return;
    setState(() {});
  }

  void _clearController() {
    _itemController.clear();
    _dollarController.clear();
    _rielController.clear();
    timestamp = Timestamp.now();
    _dateController.text = Timestamp.now().toYearMonthDay();
    _tabController.animateTo(0);
    _itemFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormFieldWidget(
                labelText: 'Item Description',
                prefixIcon: const Icon(Icons.description_outlined),
                controller: _itemController,
                focusNode: _itemFocusNode,
                onEditingComplete: () => _rielFocusNode.requestFocus(),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Dollar',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _dollarController,
                      keyboardType: TextInputType.number,
                      focusNode: _dollarFocusNode,
                    ),
                  ),
                  const Text(' or '),
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Riel',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _rielController,
                      keyboardType: TextInputType.number,
                      focusNode: _rielFocusNode,
                    ),
                  ),
                ],
              ),
              AddItemScreenTabBar(controller: _tabController),
              Stack(
                children: [
                  TextFormFieldWidget(
                    labelText: 'Timestamp',
                    prefixIcon: const Icon(Icons.edit_calendar),
                    enabled: widget.willAdd,
                    controller: _dateController,
                  ),
                  if (widget.willAdd)
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        height: 48.0,
                        width: double.infinity,
                      ),
                      onTap: () {
                        final now = DateTime.now();
                        showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: now.subtract(const Duration(days: 7)),
                          lastDate: now,
                        ).then((value) {
                          if (value == null) return;
                          setState(() {
                            timestamp = Timestamp.fromDate(value);
                            _dateController.text = timestamp.toYearMonthDay();
                          });
                        });
                      },
                    ),
                ],
              ),
              ElevatedButtonWidget(
                margin: const EdgeInsets.only(top: 16.0),
                label: widget.buttonText,
                onPressed: () {
                  if (_itemController.text.trim().isEmpty) {
                    context.showErrorSnackBar('Item Description is required');
                    return;
                  }
                  final newItem = _createPurchaseItem();
                  if (widget.willAdd) {
                    _addPurchaseItem(newItem);
                    _clearController();
                    return;
                  }
                  _updatePurchasedItem(widget.item!, newItem);
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ItemModel _createPurchaseItem() {
    final type = ItemType.getItemType(_tabController.index);
    double dollarMe = 0.0;
    double dollarBee = 0.0;
    int rielMe = 0;
    int rielBee = 0;
    switch (type) {
      case ItemType.me:
        {
          dollarMe = _dollarController.text.trim().toDouble();
          rielMe = _rielController.text.trim().toInt();
          break;
        }
      case ItemType.bee:
        {
          dollarBee = _dollarController.text.trim().toDouble();
          rielBee = _rielController.text.trim().toInt();
          break;
        }
      case ItemType.both:
        {
          final splitDollar = _dollarController.text.trim().toDouble() / 2;
          final splitRiel = _rielController.text.trim().toInt() / 2;
          dollarMe = splitDollar;
          dollarBee = splitDollar;
          rielMe = splitRiel.toInt();
          rielBee = splitRiel.toInt();
          break;
        }
    }
    return ItemModel(
      id: timestamp.seconds,
      content: _itemController.text.trim(),
      type: type,
      dollarMe: dollarMe,
      dollarBee: dollarBee,
      rielMe: rielMe,
      rielBee: rielBee,
      date: timestamp,
    );
  }

  void _addPurchaseItem(ItemModel item) {
    firestoreService.addItem(item);
    firestoreService.increaseMonth(item.date, item);
    firestoreService.increaseDay(item.date, item);
  }

  void _updatePurchasedItem(ItemModel oldItem, ItemModel newItem) {
    firestoreService.updateItem(oldItem, newItem);
    firestoreService
        .increaseDay(oldItem.date, oldItem, isIncrement: false)
        .whenComplete(() {
      firestoreService.increaseDay(oldItem.date, newItem);
    });
    firestoreService
        .increaseMonth(oldItem.date, oldItem, isIncrement: false)
        .whenComplete(() {
      firestoreService.increaseMonth(oldItem.date, newItem);
    });
  }
}
