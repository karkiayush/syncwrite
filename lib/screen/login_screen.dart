import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sync_write/colors.dart';
import 'package:sync_write/repository/auth_repository.dart';
import 'package:sync_write/screen/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);

    final errorModel = await ref
        .read(authRepositoryProvider)
        .signInWithGoogle();

    if (errorModel.error == null) {
      /* Before navigating to the home screen, we need to store it in the userProvider */
      ref.read(userProvider.notifier).update((state) => errorModel.data);

      /* Taking users to the home screen */
      navigator.replace('/');
    } else {
      sMessenger.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* ref.watch(authRepositoryProvider).signInWithGoogle(); */

    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref, context),
          icon: Image.asset("assets/images/g-logo-2.png", height: 30),
          label: const Text(
            "Sign In with Google",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(150, 50),
            backgroundColor: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
