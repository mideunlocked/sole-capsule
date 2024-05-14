import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'delete_box_sheet.dart';

class DeleteBoxButton extends StatelessWidget {
  const DeleteBoxButton({
    super.key,
    required this.boxId,
  });

  final String boxId;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return SizedBox(
      height: 4.5.h,
      child: FloatingActionButton.extended(
        heroTag: 'delete',
        elevation: 0,
        backgroundColor: const Color(0xFFFFE4E4),
        label: Text(
          'Delete POD',
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.red,
          ),
        ),
        onPressed: () => showDeleteBoxSheet(
          context: context,
          boxId: boxId,
        ),
      ),
    );
  }
}
