import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';
import 'package:varanasi_mobile_app/utils/router.dart';
import 'package:varanasi_mobile_app/widgets/responsive_sizer.dart';

import 'utils/theme.dart';

class Varanasi extends StatelessWidget {
  const Varanasi({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: AppStrings.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
