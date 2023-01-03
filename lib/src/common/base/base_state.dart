import 'package:flutter/widgets.dart';

import '../../service/expanses_service.dart';
import '../../service/saving_service.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @protected
  final ExpansesService expansesService = ExpansesService();

  @protected
  final SavingService savingService = SavingService();

  @protected
  Future<void> awaitSetState() async => Future<void>.delayed(
        const Duration(milliseconds: 100),
        () => setState(() {}),
      );
}
