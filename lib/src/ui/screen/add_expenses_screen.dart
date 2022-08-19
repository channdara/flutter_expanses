import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/string_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/enum/item_type.dart';
import 'package:expenses/src/model/purchase_item.dart';
import 'package:expenses/src/model/total_expanses.dart';
import 'package:expenses/src/ui/widget/base_scaffold.dart';
import 'package:expenses/src/ui/widget/elevated_button_widget.dart';
import 'package:expenses/src/ui/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _itemController;
  late TextEditingController _dMeController;
  late TextEditingController _rMeController;
  late TextEditingController _dBeeController;
  late TextEditingController _rBeeController;
  late FocusNode _itemFocusNode;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabListener);
    _itemController = TextEditingController();
    _dMeController = TextEditingController();
    _rMeController = TextEditingController();
    _dBeeController = TextEditingController();
    _rBeeController = TextEditingController();
    _itemFocusNode = FocusNode();
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
    return BaseScaffold(
      appBar: AppBar(title: const Text('Take Note')),
      body: SingleChildScrollView(
        padding: 16.0.spacingAll(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              labelText: 'Item Description',
              prefixIcon: const Icon(Icons.add_chart),
              controller: _itemController,
              focusNode: _itemFocusNode,
            ),
            Container(
              margin: 16.0.spacingVertical(),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: 12.0.circular(),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: 12.0.circular(),
                  color: Theme.of(context).primaryColor,
                ),
                unselectedLabelColor: Colors.grey.shade700,
                tabs: const [
                  Tab(text: 'Me'),
                  Tab(text: 'Bee'),
                  Tab(text: 'Both'),
                ],
              ),
            ),
            if (_tabController.index == 0 || _tabController.index == 2)
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Dollar',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _dMeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const Text('or'),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Riel',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _rMeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            if (_tabController.index == 2) const SizedBox(height: 16.0),
            if (_tabController.index == 1 || _tabController.index == 2)
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Dollar',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _dBeeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const Text('or'),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Riel',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _rBeeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ElevatedButtonWidget(
              margin: 32.0.spacingTop(),
              label: 'Add',
              onPressed: () {
                if (_itemController.text.isEmpty) return;
                final timestamp = Timestamp.now();
                final dMe = _dMeController.text.trim().toDouble();
                final dBee = _dBeeController.text.trim().toDouble();
                final rMe = _rMeController.text.trim().toInt();
                final rBee = _rBeeController.text.trim().toInt();
                final item = PurchaseItem(
                  id: timestamp.seconds,
                  name: _itemController.text.trim(),
                  type: ItemType.getValueByIndex(_tabController.index),
                  dollarMe: dMe,
                  dollarBee: dBee,
                  rielMe: rMe,
                  rielBee: rBee,
                  date: timestamp,
                );
                FirebaseFirestore.instance
                    .collection(TotalExpenses.collection)
                    .doc(timestamp.toYM())
                    .update(TotalExpenses.toUpdateJson(item));
                FirebaseFirestore.instance
                    .collection(PurchaseItem.collection)
                    .doc(timestamp.seconds.toString())
                    .set(item.toJson())
                    .whenComplete(() => _clearController());
              },
            ),
          ],
        ),
      ),
    );
  }
}
