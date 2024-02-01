import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_text_field.dart';

import '../../widgets/general_widgets/custom_back_button.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class AddBoxScreen extends StatefulWidget {
  static const routeName = '/AddBoxScreen';

  const AddBoxScreen({super.key});

  @override
  State<AddBoxScreen> createState() => _AddBoxScreenState();
}

class _AddBoxScreenState extends State<AddBoxScreen> {
  final boxNameCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    boxNameCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const CustomAppBar(
                      title: 'Add box',
                    ),
                    SizedBox(height: 4.h),
                    CustomTextField(
                      controller: boxNameCtr,
                      title: 'Box Name',
                      hint: 'Box 1',
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 3.h),
                    const ConnectBlueButton(),
                  ],
                ),
              ),
              CustomButton(
                onTap: () {},
                label: 'Add +',
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectBlueButton extends StatelessWidget {
  const ConnectBlueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(15);

    return InkWell(
      onTap: () {},
      borderRadius: borderRadius,
      child: Container(
        width: 100.w,
        height: 7.h,
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF5FB),
          border: Border.all(
            color: const Color(0xFFB7B7B7),
          ),
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            Icon(
              Icons.bluetooth_rounded,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 2.w),
            const Text('Pair with device'),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Column(
      children: [
        SizedBox(height: 2.h),
        Stack(
          alignment: Alignment.center,
          children: [
            const Row(
              children: [
                CustomBackButton(),
              ],
            ),
            Text(
              title,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
