import 'package:flutter/material.dart';

import '../../../../common/base/base_state.dart';
import '../../../../common/color_constant.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../model/item_template.dart';
import 'setting_item_template_screen_add_item.dart';

class SettingItemTemplateScreen extends StatefulWidget {
  const SettingItemTemplateScreen({super.key});

  @override
  State<SettingItemTemplateScreen> createState() =>
      _SettingItemTemplateScreenState();
}

class _SettingItemTemplateScreenState
    extends BaseState<SettingItemTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(const SettingItemTemplateScreenAddItem());
        },
      ),
      appBar: AppBar(title: const Text('Item Templates')),
      body: FutureBuilder<List<ItemTemplate>>(
        future: databaseService.getItemTemplates(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return RefreshIndicator(
            onRefresh: awaitSetState,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 70.0),
              itemCount: snapshot.data!.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                if (item == null) return const SizedBox();
                return GestureDetector(
                  onTap: () {
                    context.push(SettingItemTemplateScreenAddItem(item: item));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(16.0).copyWith(top: 0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Container(
                          color: ColorConstant.colorPrimary,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            item.id.toString(),
                            textAlign: TextAlign.end,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(item.content),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
