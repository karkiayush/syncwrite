import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sync_write/const/app_strings.dart';
import 'package:sync_write/models/error_model.dart';
import 'package:sync_write/repository/auth_repository.dart';
import 'package:sync_write/router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  /* As long as, errorModel is null, that means it is fetching the data and as long as it is fetching the data, its gonna be null. So we can display a circular progress indicator till that loading time. */
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();

    /* Means there is data, data loading is finished, so display the actual content */
    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        textTheme: GoogleFonts.recursiveTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          final user = ref.watch(userProvider);

          if (user != null && user.token.isNotEmpty) {
            return loggedInRoute;
          }
          return loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

/*keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android*/


// web client secret
// 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


/* podcastswearelitehot%#@!?<>9843 */

/* 
mongodb pw: AZ9IZsNX4UE5ocz6
username: karkiayush619
*/