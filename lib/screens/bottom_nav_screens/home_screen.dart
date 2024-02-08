import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_progress_inidicator.dart';

import '../../provider/user_provider.dart';
import '../../widgets/box_widgets/add_box_tile.dart';
import '../../widgets/box_widgets/box_tile.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({
    super.key,
  });

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  bool isLoading = false;
  bool isInitial = true;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return SafeArea(
      child: PaddedScreenWidget(
        child: RefreshIndicator(
          onRefresh: getUserData,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home',
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    'My Boxes',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: isLoading == true
                    ? const Center(child: CustomProgressIndicator())
                    : GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 3.h,
                          crossAxisSpacing: 5.w,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: 3,
                        itemBuilder: (ctx, index) =>
                            index == 2 ? const AddBoxTile() : const BoxTile(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getUserData() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    if (isInitial) {
      setState(() {
        isLoading = true;
      });
    }

    await userProvider.getUser(scaffoldKey: _scaffoldKey);

    setState(() {
      isLoading = false;
      isInitial = false;
    });
  }
}
