import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/base/base_state.dart';
import '../../common/extension/context_extension.dart';
import '../../common/extension/double_extension.dart';
import '../../common/extension/string_extension.dart';
import '../../model/enum/item_type.dart';
import '../../model/item_model.dart';
import '../widget/add_item/tab_bar_widget.dart';
import '../widget/elevated_button_widget.dart';
import '../widget/text_form_field_widget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({
    super.key,
    this.item,
  });

  final ItemModel? item;

  bool get isAddAction => item == null;

  String get appBarTitle => isAddAction ? 'Take Note' : 'Edit Note';

  String get buttonText => isAddAction ? 'Add' : 'Update';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends BaseState<AddItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _itemController;
  late TextEditingController _dMeController;
  late TextEditingController _rMeController;
  late TextEditingController _dBeeController;
  late TextEditingController _rBeeController;
  late FocusNode _itemFocusNode;

  bool get _myTextFieldEnabled => [0, 2].contains(_tabController.index);

  bool get _beeTextFieldEnabled => [1, 2].contains(_tabController.index);

  @override
  void initState() {
    _tabController = TabController(length: ItemType.values.length, vsync: this);
    if (!widget.isAddAction) _tabController.animateTo(widget.item!.type.value);
    _tabController.addListener(_handleTabListener);
    _itemController = TextEditingController(text: widget.item?.content);
    _dMeController =
        TextEditingController(text: widget.item?.dollarMe.toString());
    _rMeController =
        TextEditingController(text: widget.item?.rielMe.toString());
    _dBeeController =
        TextEditingController(text: widget.item?.dollarBee.toString());
    _rBeeController =
        TextEditingController(text: widget.item?.rielBee.toString());
    _itemFocusNode = FocusNode()..requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _itemController.dispose();
    _dMeController.dispose();
    _rMeController.dispose();
    _dBeeController.dispose();
    _rBeeController.dispose();
    _itemFocusNode.dispose();
    super.dispose();
  }

  void _handleTabListener() {
    if (!_tabController.indexIsChanging) return;
    setState(() {});
  }

  void _clearController() {
    _itemController.clear();
    _dMeController.clear();
    _rMeController.clear();
    _dBeeController.clear();
    _rBeeController.clear();
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
          padding: 16.0.spacingAll(),
          child: Column(
            children: [
              TextFormFieldWidget(
                labelText: 'Item Description',
                prefixIcon: const Icon(Icons.add_chart),
                controller: _itemController,
                focusNode: _itemFocusNode,
              ),
              TabBarWidget(controller: _tabController),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Dollar',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _dMeController,
                      keyboardType: TextInputType.number,
                      enabled: _myTextFieldEnabled,
                    ),
                  ),
                  const Text(' or '),
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Riel',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _rMeController,
                      keyboardType: TextInputType.number,
                      enabled: _myTextFieldEnabled,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Dollar',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _dBeeController,
                      keyboardType: TextInputType.number,
                      enabled: _beeTextFieldEnabled,
                    ),
                  ),
                  const Text(' or '),
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Riel',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _rBeeController,
                      keyboardType: TextInputType.number,
                      enabled: _beeTextFieldEnabled,
                    ),
                  ),
                ],
              ),
              ElevatedButtonWidget(
                margin: 32.0.spacingTop(),
                label: widget.buttonText,
                onPressed: () {
                  if (_itemController.text.isEmpty) return;
                  final timestamp = Timestamp.now();
                  final newItem = _createPurchaseItem(timestamp);
                  if (widget.isAddAction) {
                    _addPurchaseItem(newItem);
                    _clearController();
                    return;
                  }
                  _updatePurchasedItem(timestamp, widget.item!, newItem);
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ItemModel _createPurchaseItem(Timestamp timestamp) {
    final dMe = _dMeController.text.trim().toDouble();
    final dBee = _dBeeController.text.trim().toDouble();
    final rMe = _rMeController.text.trim().toInt();
    final rBee = _rBeeController.text.trim().toInt();
    return ItemModel(
      id: timestamp.seconds,
      content: _itemController.text.trim(),
      type: ItemType.getItemType(_tabController.index),
      dollarMe: dMe,
      dollarBee: dBee,
      rielMe: rMe,
      rielBee: rBee,
      date: timestamp,
    );
  }

  void _addPurchaseItem(ItemModel item) {
    firebaseService.addItem(item);
    firebaseService.increaseMonth(item);
    firebaseService.increaseDay(item);
  }

  void _updatePurchasedItem(
    Timestamp timestamp,
    ItemModel oldItem,
    ItemModel newItem,
  ) {
    firebaseService.updateItem(oldItem.id, newItem);
    firebaseService
        .increaseDay(oldItem, isIncrement: false)
        .whenComplete(() => firebaseService.increaseDay(newItem));
    firebaseService
        .increaseMonth(oldItem, isIncrement: false)
        .whenComplete(() => firebaseService.increaseMonth(newItem));
  }
}
