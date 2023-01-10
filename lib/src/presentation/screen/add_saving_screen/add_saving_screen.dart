import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/string_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/saving_model.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class AddSavingScreen extends StatefulWidget {
  const AddSavingScreen({super.key, this.item});

  final SavingModel? item;

  bool get willAdd => item == null;

  String get appBarTitle => willAdd ? 'Add Saving' : 'Edit Saving';

  String get buttonText => willAdd ? 'Add' : 'Update';

  String get getDate =>
      willAdd ? Timestamp.now().toYearMonthDay() : item!.date.toYearMonthDay();

  @override
  State<AddSavingScreen> createState() => _AddSavingScreenState();
}

class _AddSavingScreenState extends BaseState<AddSavingScreen> {
  late TextEditingController _dollarController;
  late TextEditingController _rielController;
  late TextEditingController _remarkController;
  late TextEditingController _dateController;
  late FocusNode _dollarFocusNode;
  late FocusNode _rielFocusNode;

  Timestamp _timestamp = Timestamp.now();

  @override
  void initState() {
    _dollarController =
        TextEditingController(text: widget.item?.amountDollar.toString());
    _rielController =
        TextEditingController(text: widget.item?.amountRiel.toString());
    _remarkController = TextEditingController(text: widget.item?.remark);
    _dateController = TextEditingController(text: widget.getDate);

    _dollarFocusNode = FocusNode();
    _rielFocusNode = FocusNode();

    if (widget.willAdd) _dollarFocusNode.requestFocus();
    if (!widget.willAdd) _timestamp = widget.item!.date;
    super.initState();
  }

  @override
  void dispose() {
    _dollarController.dispose();
    _rielController.dispose();
    _remarkController.dispose();
    _dateController.dispose();
    _dollarFocusNode.dispose();
    _rielFocusNode.dispose();
    super.dispose();
  }

  void _clearController() {
    final now = Timestamp.now();
    _dollarController.clear();
    _rielController.clear();
    _remarkController.clear();
    _dateController.text = now.toYearMonthDay();
    _dollarFocusNode.requestFocus();
    _timestamp = now;
  }

  void _addSaving(SavingModel item) {
    savingService.addSaving(item);
    savingService.increaseYear(item.date, item);
  }

  void _updateSaving(SavingModel newItem) {
    final oldItem = widget.item!;
    savingService.updateItem(oldItem, newItem);
    savingService.increaseYear(oldItem.date, oldItem, false).whenComplete(() {
      savingService.increaseYear(oldItem.date, newItem).whenComplete(() {
        context.pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      labelText: 'Dollar',
                      prefixIcon: const Icon(Icons.currency_bitcoin),
                      controller: _dollarController,
                      keyboardType: TextInputType.number,
                      focusNode: _dollarFocusNode,
                      onEditingComplete: () => _rielFocusNode.requestFocus(),
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
              const SizedBox(height: 16.0),
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
                        final lastDay = DateTime(now.year + 1, 1, 0).day;
                        showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(now.year),
                          lastDate: DateTime(now.year, 12, lastDay),
                        ).then((value) {
                          if (value == null) return;
                          setState(() {
                            _timestamp = Timestamp.fromDate(value);
                            _dateController.text = _timestamp.toYearMonthDay();
                          });
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                controller: _remarkController,
                labelText: 'Remark (optional)',
                prefixIcon: const Icon(Icons.description_outlined),
              ),
              ElevatedButtonWidget(
                margin: const EdgeInsets.only(top: 16.0),
                label: widget.buttonText,
                onPressed: () {
                  final dollar = _dollarController.text.trim();
                  final riel = _rielController.text.trim();
                  if (dollar.isEmpty && riel.isEmpty) {
                    context.showErrorSnackBar('Amount is required');
                    return;
                  }
                  final saving = SavingModel(
                    id: _timestamp.seconds,
                    date: _timestamp,
                    amountDollar: dollar.toDouble(),
                    amountRiel: riel.toInt(),
                    remark: _remarkController.text.trim(),
                  );
                  if (widget.willAdd) {
                    _addSaving(saving);
                    _clearController();
                    return;
                  }
                  _updateSaving(saving);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
