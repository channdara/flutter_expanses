import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../common/base/base_state.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../model/item_template.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_widget.dart';

class SettingItemTemplateScreenAddItem extends StatefulWidget {
  const SettingItemTemplateScreenAddItem({super.key, this.item});

  final ItemTemplate? item;

  bool get willAdd => item == null;

  String get buttonText => willAdd ? 'Add' : 'Update';

  String get appBarTitle => '$buttonText Item';

  String get id => willAdd ? 'ID will generate auto' : item!.id.toString();

  @override
  State<SettingItemTemplateScreenAddItem> createState() =>
      _SettingItemTemplateScreenAddItemState();
}

class _SettingItemTemplateScreenAddItemState
    extends BaseState<SettingItemTemplateScreenAddItem> {
  late TextEditingController _idController;
  late TextEditingController _contentController;
  late FocusNode _contentFocusNode;
  int _id = Timestamp.now().seconds;

  @override
  void initState() {
    _idController = TextEditingController(text: widget.id);
    _contentController = TextEditingController(text: widget.item?.content);
    _contentFocusNode = FocusNode();
    if (widget.willAdd) _contentFocusNode.requestFocus();
    if (!widget.willAdd) _id = widget.item!.id;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _contentController.dispose();
  }

  void _clearController() {
    _contentController.clear();
    _id = Timestamp.now().seconds;
    _contentFocusNode.requestFocus();
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
                labelText: 'ID',
                prefixIcon: const Icon(Icons.numbers),
                enabled: false,
                controller: _idController,
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                labelText: 'Content',
                prefixIcon: const Icon(Icons.description_outlined),
                controller: _contentController,
                focusNode: _contentFocusNode,
              ),
              ElevatedButtonWidget(
                margin: const EdgeInsets.only(top: 32.0),
                label: widget.buttonText,
                onPressed: () {
                  if (_contentController.text.trim().isEmpty) {
                    context.showErrorSnackBar('Content is required!');
                    return;
                  }
                  final item = ItemTemplate(
                    _id,
                    _contentController.text.trim(),
                  );
                  if (widget.willAdd) {
                    databaseService.setItemTemplate(item);
                    _clearController();
                    return;
                  }
                  databaseService.updateItemTemplate(item);
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
