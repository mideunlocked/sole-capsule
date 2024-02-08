import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_button.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_text_field.dart';

import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class CheckOutDetailsScreen extends StatefulWidget {
  static const routeName = '/CheckOutDetailsScreen';

  const CheckOutDetailsScreen({super.key});

  @override
  State<CheckOutDetailsScreen> createState() => _CheckOutDetailsScreenState();
}

class _CheckOutDetailsScreenState extends State<CheckOutDetailsScreen> {
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final pinCodeCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final cityCtr = TextEditingController();
  final stateCtr = TextEditingController();
  final countryCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    nameCtr.dispose();
    emailCtr.dispose();
    pinCodeCtr.dispose();
    addressCtr.dispose();
    cityCtr.dispose();
    stateCtr.dispose();
    countryCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 2.h);
    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                title: 'Checkout',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      const CheckoutDetailsHeader(
                        label: 'Personal Details',
                      ),
                      CustomTextField(
                        controller: nameCtr,
                        title: 'Name',
                        hint: 'Enter your name',
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: emailCtr,
                        title: 'Email',
                        hint: 'Enter your email address',
                      ),
                      sizedBox,
                      const Divider(
                        color: Color(0xFFC4C4C4),
                      ),
                      sizedBox,
                      const CheckoutDetailsHeader(
                        label: 'Delivery Details',
                      ),
                      CustomTextField(
                        controller: pinCodeCtr,
                        title: 'Pin Code',
                        hint: 'Enter delivery pin code',
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: addressCtr,
                        title: 'Address',
                        hint: 'Enter delivery address',
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: cityCtr,
                        title: 'City',
                        hint: 'Enter delivery city',
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: stateCtr,
                        title: 'State',
                        hint: 'Enter delivery state',
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: countryCtr,
                        title: 'Country',
                        hint: 'Enter delivery country',
                      ),
                      SizedBox(height: 4.h),
                      CustomButton(
                        onTap: () {},
                        label: 'Continue',
                      ),
                      sizedBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutDetailsHeader extends StatelessWidget {
  const CheckoutDetailsHeader({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}
