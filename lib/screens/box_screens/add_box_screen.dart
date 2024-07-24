import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/ble_provider.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/add_box_widgets/connect_blue_button.dart';
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
    lightColor: Colors.white.value,
  );

  @override
  void dispose() {
    super.dispose();

    boxNameCtr.dispose();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

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
                      title: 'Box Name',
                      hint: 'Box 1',
                      inputAction: TextInputAction.done,
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

  void scanBluetoothDevices() async {
    var bleProvider = Provider.of<BleProvider>(context, listen: false);

    await bleProvider.checkBluetoothStatus(
      scaffoldKey: _scaffoldKey,
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
      isConnected: bleProvider.currentDevice != null,
      lightColor: Colors.white.value,
    );

    boxProvider.addNewBox(
      box: box,
    );
  }
}

class BluetoothDeviciesDialog extends StatelessWidget {
  const BluetoothDeviciesDialog({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    bool isLightMode =
        Provider.of<ThemeModeProvider>(context, listen: false).isLight;

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    return Dialog(
      backgroundColor:
          isLightMode ? const Color(0xFFEEF5FB) : const Color(0xFF14191D),
      insetPadding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 10.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetAnimationCurve: Curves.bounceIn,
      insetAnimationDuration: const Duration(seconds: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            Text(
              'Available devices',
              style: textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: of.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Consumer<BleProvider>(builder: (context, blePvr, _) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: blePvr.bleDevices
                        .map(
                          (e) => BleDeviceTile(
                            name: e.platformName,
                            isSelected: e == blePvr.selectedDevice,
                            isCurrent: e == blePvr.currentDevice,
                            onTap: () => blePvr.connectToDevice(
                              context: context,
                              device: e,
                              scaffoldKey: scaffoldKey,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BleDeviceTile extends StatelessWidget {
  const BleDeviceTile({
    super.key,
    required this.name,
    required this.isSelected,
    this.onTap,
    this.isCurrent,
  });

  final String name;
  final bool? isSelected;
  final bool? isCurrent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                isCurrent ?? false
                    ? const Icon(Icons.check_rounded)
                    : Visibility(
                        visible: isSelected ?? false,
                        child: const CupertinoActivityIndicator(),
                      ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
