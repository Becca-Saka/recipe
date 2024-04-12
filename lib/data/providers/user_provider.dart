import 'package:flutter/material.dart';
import 'package:recipe/data/models/user_model.dart';
import 'package:recipe/data/services/authentication_service.dart';
import 'package:recipe/ui/home_view.dart';
import 'package:recipe/ui/sign_in.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  final AuthenticationsService _authenticationsService =
      AuthenticationsService();
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> checkAuthStatus(BuildContext context) async {
    try {
      final user = _authenticationsService.currentUser;
      if (user != null) {
        currentUser = await _authenticationsService.getCurrentUserData();
        _goToHomeView(context);
      } else {
        _goToSignInView(context);
      }
    } on Exception catch (e) {
      _goToSignInView(context);
    }
  }

  Future<void> logInWithGoogleUser() async {
    setLoading(true);
    await _authenticationsService.logInWithGoogleUser();
    setLoading(false);
  }

  Future<void> logInSilently(BuildContext context) async {
    setLoading(true);
    final response = await _authenticationsService.logInSilently();
    setLoading(false);
    if (response) {
      currentUser = await _authenticationsService.getCurrentUserData();

      notifyListeners();
      _goToHomeView(context);
    }
  }

  void _goToHomeView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const HomeView()));
  }

  void _goToSignInView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignInView()));
  }
}
