import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/box_provider.dart';
import '../../widgets/box_widgets/connect_wi_fi_button.dart';
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
  var boxNameCtr = TextEditingController();

  Map<String, dynamic> args = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getRouteArgs();
  }

  @override
  void dispose() {
    super.dispose();

    boxNameCtr.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: PaddedScreenWidget(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomAppBar(
                    title: 'Settings',
                  ),
                  SizedBox(height: 3.h),
                  CustomTextField(
                    controller: boxNameCtr,
                    title: 'POD Name',
                    hint: 'Enter POD name',
                    inputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 4.h),
                  ConnectWifiButton(
                    boxId: args['id'],
                  ),
                  SizedBox(height: 3.h),
                  DeleteBoxButton(
                    boxId: args['id'],
                  ),
                  const Spacer(),
                  CustomButton(
                    onTap: () => editBoxName(
                      boxId: args['id'],
                    ),
                    label: 'Save',
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getRouteArgs() {
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    boxNameCtr = TextEditingController(
      text: args['name'],
    );
  }

  void editBoxName({required String boxId}) {
    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      var boxPvr = Provider.of<BoxProvider>(context, listen: false);

      boxPvr.editBoxName(
          id: boxId,
          newName: boxNameCtr.text.trim(),
          scaffoldKey: _scaffoldKey);

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
