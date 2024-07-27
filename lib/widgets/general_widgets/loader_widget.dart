import 'package:flutter/material.dart';

import 'custom_progress_inidicator.dart';

void showCustomLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => const LoaderWidget(),
  );
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: CustomProgressIndicator(),
      ),
    );
  }
}
