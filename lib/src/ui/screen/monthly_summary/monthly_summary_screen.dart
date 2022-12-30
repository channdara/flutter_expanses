import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/monthly_summary.dart';
import 'monthly_summary_screen_list_widget.dart';

class MonthlySummaryScreen extends StatefulWidget {
  const MonthlySummaryScreen({super.key, required this.date});

  final Timestamp date;

  String get appBarTitle => 'Summary on: ${date.toYearMonth()}';

  @override
  State<MonthlySummaryScreen> createState() => _MonthlySummaryScreenState();
}

class _MonthlySummaryScreenState extends BaseState<MonthlySummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: FutureBuilder<List<MonthlySummary>>(
        future: firestoreService.getMonthlySummary(widget.date),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) return const SizedBox();
          return RefreshIndicator(
            onRefresh: awaitSetState,
            child: MonthlySummaryScreenListWidget(docs: snapshot.data!),
          );
        },
      ),
    );
  }
}
