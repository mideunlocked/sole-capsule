import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/box_widgets/delete_box_button.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class BoxSettingsScreen extends StatefulWidget {
  static const routeName = '/BoxSettingsScreen';

  const BoxSettingsScreen({super.key});

  @override
  State<BoxSettingsScreen> createState() => _BoxSettingsScreenState();
}

class _BoxSettingsScreenState extends State<BoxSettingsScreen> {
  final boxNameCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    boxNameCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Column(
            children: [
              const CustomAppBar(
                title: 'Settings',
              ),
              SizedBox(height: 3.h),
              CustomTextField(
                controller: boxNameCtr,
                title: 'Box Name',
                hint: 'Enter box name',
              ),
              SizedBox(height: 4.h),
              const DeleteBoxButton(
                boxId: '',
              ),
              const Spacer(),
              CustomButton(
                onTap: () {},
                label: 'Save',
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
