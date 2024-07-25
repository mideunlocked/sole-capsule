import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/delivery_details.dart';
import '../../models/users.dart';
import '../../provider/user_provider.dart';
import '../../widgets/checkout_widgets/check_out_detail_header.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class CheckOutDetailsScreen extends StatefulWidget {
  static const routeName = '/CheckOutDetailsScreen';

  const CheckOutDetailsScreen({super.key});

  @override
  State<CheckOutDetailsScreen> createState() => _CheckOutDetailsScreenState();
}

class _CheckOutDetailsScreenState extends State<CheckOutDetailsScreen> {
  var nameCtr = TextEditingController();
  var emailCtr = TextEditingController();
  var numberCtr = TextEditingController();
  var pinCodeCtr = TextEditingController();
  var addressCtr = TextEditingController();
  var cityCtr = TextEditingController();
  var stateCtr = TextEditingController();
  var countryCtr = TextEditingController();

  @override
  void initState() {
    super.initState();

    getDeliveryDetails();
  }

  @override
  void dispose() {
    super.dispose();

    nameCtr.dispose();
    emailCtr.dispose();
    numberCtr.dispose();
    pinCodeCtr.dispose();
    addressCtr.dispose();
    cityCtr.dispose();
    stateCtr.dispose();
    countryCtr.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 2.h);
    return Scaffold(
      body: PaddedScreenWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: 'Checkout',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                        inputType: TextInputType.name,
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: emailCtr,
                        title: 'Email',
                        hint: 'Enter your email address',
                        inputType: TextInputType.emailAddress,
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: numberCtr,
                        title: 'Phone Number',
                        hint: 'Enter your contact number',
                        inputType: TextInputType.phone,
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
                        title: 'Zip Code',
                        hint: 'Enter delivery zip code',
                        inputType: TextInputType.number,
                        maxLength: 6,
                      ),
                      sizedBox,
                      CustomTextField(
                        controller: addressCtr,
                        title: 'Address',
                        hint: 'Enter delivery address',
                        inputType: TextInputType.streetAddress,
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
                        inputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 4.h),
                      CustomButton(
                        onTap: updateDeliveryDetails,
                        label: 'Continue',
                      ),
                      sizedBox,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDeliveryDetails() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Users user = userProvider.user;
    DeliveryDetails details = user.deliveryDetails;

    nameCtr = TextEditingController(text: details.name);
    addressCtr = TextEditingController(text: details.address);
    numberCtr = TextEditingController(text: details.number);
    emailCtr = TextEditingController(text: details.email);
    pinCodeCtr = TextEditingController(text: details.pinCode);
    cityCtr = TextEditingController(text: details.city);
    stateCtr = TextEditingController(text: details.state);
    countryCtr = TextEditingController(text: details.country);
  }

  void updateDeliveryDetails() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      await userProvider
          .updateDeliveryDetails(
            details: DeliveryDetails(
              name: nameCtr.text.trim(),
              city: cityCtr.text.trim(),
              state: stateCtr.text.trim(),
              email: emailCtr.text.trim(),
              number: numberCtr.text.trim(),
              country: countryCtr.text.trim(),
              pinCode: pinCodeCtr.text.trim(),
              address: addressCtr.text.trim(),
            ),
            scaffoldKey: _scaffoldKey,
        context: context,
          )
          .then(
            (_) => Navigator.pop(context),
          );
    }
  }
}
