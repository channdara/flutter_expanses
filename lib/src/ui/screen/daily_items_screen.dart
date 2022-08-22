import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/item_model.dart';
import 'package:expenses/src/service/firestore_service.dart';
import 'package:expenses/src/ui/screen/add_item_screen.dart';
import 'package:flutter/material.dart';

class DailyItemsScreen extends StatefulWidget {
  const DailyItemsScreen({Key? key}) : super(key: key);

  String get appBarTitle => 'Expenses on: ${Timestamp.now().toYearMonthDay()}';

  @override
  State<DailyItemsScreen> createState() => _DailyItemsScreenState();
}

class _DailyItemsScreenState extends State<DailyItemsScreen> {
  final FirestoreService _service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.itemQuerySnapshot,
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return ListView.builder(
            padding: 70.0.spacingBottom(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index].data();
              final item = ItemModel.fromJson(data as Map<String, dynamic>);
              return ListTile(
                leading: item.getDisplayIcon(),
                title: Text(
                  item.content,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  item.getDisplayAmount(),
                  style: const TextStyle(fontSize: 12.0),
                ),
                trailing: Text(
                  item.date.toHourMinute(),
                  style: const TextStyle(fontSize: 12.0),
                ),
                onTap: () => context.push(AddItemScreen(item: item)),
              );
            },
          );
        },
      ),
    );
  }
}
