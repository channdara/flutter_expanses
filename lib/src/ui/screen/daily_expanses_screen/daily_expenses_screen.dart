import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/base/base_state.dart';
import '../../../common/color_constant.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/item_model.dart';
import '../../../model/month_model.dart';
import '../add_item_screen/add_item_screen.dart';
import 'daily_expenses_screen_list.dart';
import 'daily_expenses_screen_summary.dart';

class DailyExpensesScreen extends StatefulWidget {
  const DailyExpensesScreen({super.key});

  @override
  State<DailyExpensesScreen> createState() => _DailyExpensesScreenState();
}

class _DailyExpensesScreenState extends BaseState<DailyExpensesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Timestamp> _tabBarItems = [];
  Timestamp _date = Timestamp.now();

  @override
  void initState() {
    super.initState();
    _generateTabBarItems();
    _tabController = TabController(
      length: _tabBarItems.length,
      initialIndex: _getCurrentTabBarIndex(),
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  void _generateTabBarItems() {
    final DateTime now = DateTime.now();
    final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    List.generate(
      lastDayOfMonth.day,
      (index) {
        final date = DateTime(now.year, now.month, index + 1);
        final timestamp = Timestamp.fromDate(date);
        _tabBarItems.add(timestamp);
      },
    );
  }

  int _getCurrentTabBarIndex() {
    final DateTime now = DateTime.now();
    return _tabBarItems.indexWhere((element) => element.day == now.day);
  }

  void _tabControllerListener() {
    if (_tabController.indexIsChanging) {
      _date = _tabBarItems[_tabController.index];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(height: size, color: ColorConstant.colorPrimary),
              Container(
                margin: EdgeInsets.only(top: size / 2),
                child: FutureBuilder<MonthModel>(
                  future: firestoreService.getCurrentMonthSummary(
                    Timestamp.now(),
                  ),
                  builder: (context, snapshot) {
                    final item = snapshot.data;
                    return DailyExpensesScreenSummary(item: item);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              DateFormat('dd MMMM yyyy').format(_date.toDate()),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(top: 4.0),
            shape: const RoundedRectangleBorder(),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              padding: const EdgeInsets.all(4.0),
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              tabs: _tabBarItems
                  .map((e) => Tab(child: Text(e.getDay())))
                  .toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ItemModel>>(
              future: firestoreService.getPurchasedItems(_date),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) return const SizedBox();
                return RefreshIndicator(
                  onRefresh: awaitSetState,
                  child: DailyExpensesScreenList(docs: snapshot.data!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
