import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/user_provider.dart';
import 'package:recipe/shared/widget/gradient_background.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .checkAuthStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return GradientBackground(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      colors: [
        GradientData(
          color: const Color(0xFFCF5EEE),
          offset: Offset(0, width / 2),
          radius: 119,
        ),
        GradientData(
          color: const Color(0xFF8F90F2),
          offset: Offset(width + 60, height / 2),
          radius: 119,
        ),
        GradientData(
          color: const Color(0xFF72B8F4),
          offset: Offset(width / 2, height),
          radius: 119,
        ),
      ],
      backgroundColor: const Color(0xFF131314),
      child: Center(
        child: Image.asset(
          'assets/images/app_logo.png',
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
