import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/string_extension.dart';
import '../../../model/saving_model.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class AddSavingScreen extends StatefulWidget {
  const AddSavingScreen({super.key, this.item});

  final SavingModel? item;

  bool get willAdd => item == null;

  String get appBarTitle => willAdd ? 'Add Saving' : 'Edit Saving';

  String get buttonText => willAdd ? 'Add' : 'Update';

  @override
  State<AddSavingScreen> createState() => _AddSavingScreenState();
}

class _AddSavingScreenState extends BaseState<AddSavingScreen> {
  late TextEditingController _amountController;
  late TextEditingController _remarkController;
  late FocusNode _amountFocusNode;

  Timestamp _timestamp = Timestamp.now();

  @override
  void initState() {
    _amountController =
        TextEditingController(text: widget.item?.amount.toString());
    _remarkController = TextEditingController(text: widget.item?.remark);

    _amountFocusNode = FocusNode();

    if (widget.willAdd) _amountFocusNode.requestFocus();
    if (!widget.willAdd) _timestamp = widget.item!.date;
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _remarkController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _clearController() {
    _amountController.clear();
    _remarkController.clear();
    _amountFocusNode.requestFocus();
    _timestamp = Timestamp.now();
  }

  void _addSaving(SavingModel item) {

  }

  void _updateSaving(SavingModel oldItem, SavingModel newItem) {}

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
                controller: _amountController,
                focusNode: _amountFocusNode,
                labelText: 'Saving amount',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.currency_bitcoin),
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                controller: _remarkController,
                labelText: 'Remark (optional)',
                prefixIcon: const Icon(Icons.currency_bitcoin),
              ),
              ElevatedButtonWidget(
                margin: const EdgeInsets.only(top: 16.0),
                label: widget.buttonText,
                onPressed: () {
                  if (_amountController.text.trim().isEmpty) {
                    context.showErrorSnackBar('Amount is required');
                    return;
                  }
                  final saving = SavingModel(
                    id: _timestamp.seconds,
                    date: _timestamp,
                    amount: _amountController.text.trim().toDouble(),
                    remark: _remarkController.text.trim(),
                  );
                  if (widget.willAdd) {
                    _addSaving(saving);
                    _clearController();
                    return;
                  }
                  _updateSaving(widget.item!, saving);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
