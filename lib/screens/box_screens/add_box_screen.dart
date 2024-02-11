import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/models/box.dart';

import '../../provider/box_provider.dart';
import '../../widgets/add_box_widgets/connect_blue_button.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/general_widgets/successfull_sheet.dart';

class AddBoxScreen extends StatefulWidget {
  static const routeName = '/AddBoxScreen';

  const AddBoxScreen({super.key});

  @override
  State<AddBoxScreen> createState() => _AddBoxScreenState();
}

class _AddBoxScreenState extends State<AddBoxScreen> {
  final boxNameCtr = TextEditingController();

  Box box = Box(
    id: '',
    name: '',
    isOpen: false,
    isLightOn: false,
  );

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
                onTap: () {
                  var of = Theme.of(context);
                  var textTheme = of.textTheme;
                  var titleMedium = textTheme.titleMedium;

                  addNewBox();

                  showSuccesfullSheet(
                    context: context,
                    successMessage: Text(
                      'Box Added',
                      style: titleMedium?.copyWith(fontSize: 20.sp),
                    ),
                    buttonTitle: 'View',
                    buttonFunction: () => Navigator.pushReplacementNamed(
                      context,
                      '/BoxScreen',
                      arguments: box,
                    ),
                  );
                },
                label: 'Add +',
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  void addNewBox() {
    var boxProvider = Provider.of<BoxProvider>(context, listen: false);

    box = Box(
      id: boxProvider.boxes.length.toString(),
      name: boxNameCtr.text.trim(),
      isOpen: false,
      isLightOn: false,
    );

    boxProvider.addNewBox(
      box: box,
    );
  }
}
