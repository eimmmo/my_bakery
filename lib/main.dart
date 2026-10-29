// ============================================================
// Part 1 answers (lifecycle)
// ============================================================
// a) When a page opens for the first time: initState, then
//    didChangeDependencies, then build.
//
// b) After I press the heart button: only build runs again.
//    setState rebuilds the page, but initState and
//    didChangeDependencies do not run again.
//
// c) When I leave a page and go back: the page I leave (DetailsPage)
//    runs deactivate and then dispose. The page I go back to
//    (ProductsPage) only runs build, because it was still alive under
//    the details page (with push). With go (Login -> Products), the
//    login page is replaced, so it runs deactivate and dispose too.
//
// d) When I resize the browser window: didChangeDependencies and then
//    build run again, many times. This happens because I read the
//    screen size with MediaQuery.sizeOf(context) inside the page, so
//    the page depends on MediaQuery. When the size changes, Flutter
//    tells the page that a dependency changed, so it runs
//    didChangeDependencies and then rebuilds.
//
// ============================================================
// Part 4 answers (short answers)
// ============================================================
// 1) context.go replaces the current route stack with the new page,
//    so there is no back button to the old page. context.push puts
//    the new page on top of the current one, so I can go back.
//    Example of go: Login -> Products (context.goNamed('products')).
//    Example of push: Products -> Details
//    (context.push('/details/$name/$price')).
//
// 2) I used go for Login -> Products because after logging in the
//    user should NOT go back to the login page. I used push for
//    Products -> Details because the user should be able to go back
//    to the products, and because I wait (await) for the result
//    ("... added to cart") when the details page closes.
//
// 3) A path parameter is a part of the path itself and it is needed to
//    reach the page. Example: /details/Butter%20Croissant/35
//    (name and price). A query parameter comes after the "?" and is
//    extra information. Example: /products?user=Guest
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'details_page.dart';
import 'login_page.dart';
import 'products_page.dart';

void main() {
  runApp(const MyApp());
}

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
  scaffoldBackgroundColor: const Color(0xFFFFF8F0),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.brown.shade700,
    foregroundColor: Colors.white,
    titleTextStyle: const TextStyle(
      fontFamily: 'Georgia',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) {
        final user = state.uri.queryParameters['user'] ?? 'Guest';
        return ProductsPage(username: user);
      },
    ),
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final price = int.parse(state.pathParameters['price']!);
        return DetailsPage(name: name, price: price);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Sweet Crumbs',
      theme: appTheme,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Sweet Crumbs',
//       theme: appTheme,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const LoginPage(),
//         '/products': (context) {
//           final username =
//               ModalRoute.of(context)!.settings.arguments as String;
//           return ProductsPage(username: username);
//         },
//       },
//     );
//   }
// }