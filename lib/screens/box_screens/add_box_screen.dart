import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/ble_provider.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/add_box_widgets/connect_blue_button.dart';
import '../../widgets/box_widgets/bluetooth_deviceies_dialog.dart';
import '../../widgets/box_widgets/fonts_display_sheet.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/general_widgets/successfull_sheet.dart';
import 'box_screen.dart';

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
    lightIntensity: 50,
    isConnected: false,
    imagePath: '',
    fontFamily: '',
    lightColor: Colors.white.value,
  );

  @override
  void dispose() {
    super.dispose();

    boxNameCtr.dispose();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  String fontFamily = '';
  void getFontFamily(String newFont) => setState(() => fontFamily = newFont);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
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
                      title: 'Pod Name',
                      hint: 'Box 1',
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: fontFamilySelector,
                          borderRadius: BorderRadius.circular(10),
                          child: const Text('Select pod font'),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    ConnectBlueButton(
                      onTap: scanBluetoothDevices,
                    ),
                  ],
                ),
              ),
              CustomButton(
                onTap: () {
                  if (boxNameCtr.text.isEmpty) {
                    return;
                  }
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
                      BoxScreen.routeName,
                      arguments: box,
                    ),
                  );
                },
                label: 'Add +',
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  void fontFamilySelector() {
    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLight = tmPvr.isLight;
    Color bgColor = isLight
        ? Theme.of(context).scaffoldBackgroundColor
        : const Color(0xFF101417);

    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (ctx) => FontsDisplaySheet(
        name: boxNameCtr.text.trim(),
        fontFamily: fontFamily,
        getFont: getFontFamily,
      ),
    );
  }

  void scanBluetoothDevices() async {
    var bleProvider = Provider.of<BleProvider>(context, listen: false);

    await bleProvider.checkBluetoothStatus(
      scaffoldKey: _scaffoldKey,
      context: context,
    );

    showAvailableDevicesDialog();
  }

  void showAvailableDevicesDialog() {
    showDialog(
      context: context,
      builder: (ctx) => BluetoothDeviciesDialog(
        scaffoldKey: _scaffoldKey,
      ),
    );
  }

  void addNewBox() {
    var boxProvider = Provider.of<BoxProvider>(context, listen: false);
    var bleProvider = Provider.of<BleProvider>(context, listen: false);

    box = Box(
      id: boxProvider.boxes.length.toString(),
      name: boxNameCtr.text.trim(),
      isOpen: false,
      isLightOn: false,
      lightIntensity: 50,
      imagePath: '',
      fontFamily: fontFamily,
      isConnected: bleProvider.currentDevice != null,
      lightColor: Colors.white.value,
    );

    boxProvider.addNewBox(
      box: box,
    );
  }
}
