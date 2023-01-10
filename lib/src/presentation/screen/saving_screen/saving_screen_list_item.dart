import 'package:flutter/material.dart';

import '../../../common/color_constant.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/saving_model.dart';
import '../add_saving_screen/add_saving_screen.dart';

class SavingScreenListItem extends StatelessWidget {
  const SavingScreenListItem({super.key, required this.item});

  final SavingModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AddSavingScreen(item: item)),
      child: Card(
        margin: const EdgeInsets.all(16.0).copyWith(top: 0.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: ColorConstant.colorPrimary,
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                item.date.toYearMonthDay(),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'ProductSan',
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text: item.getDisplayAmount,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ' has been added to the saving account',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Remark: ${item.getRemark}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
