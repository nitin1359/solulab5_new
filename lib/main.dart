import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/blocs/auth_bloc/auth_bloc.dart';
import 'package:solulab5/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_event.dart';
import 'package:solulab5/loggedin_check.dart';
import 'package:solulab5/repositories/auth_repository.dart';
import 'package:solulab5/repositories/product_repository.dart';
import 'package:solulab5/screens/home_screen.dart';
import 'package:solulab5/screens/nav_screen/cart_screen.dart';
import 'package:solulab5/screens/nav_screen/favourite_screen.dart';
import 'package:solulab5/screens/nav_screen/profile_screen.dart';
import 'package:solulab5/screens/onboarding_screen.dart';
import 'package:solulab5/screens/sign_in_screen.dart';
import 'package:solulab5/screens/sign_up_screen.dart';
import 'package:solulab5/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
                productRepository:
                    RepositoryProvider.of<ProductRepository>(context))
              ..add(LoadProducts()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: const Color(0xFFF9F9F9),
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          // home: const LoggedInCheck(),
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/signin': (context) => SignInScreen(),
            '/signup': (context) => SignUpScreen(),
            '/home': (context) => HomeScreen(),
            '/': (context) =>
                const LoggedInCheck(), // Keep in mind this will be the Initial Route always mainly the splash Symbol
            '/favorite': (context) => const FavoriteScreen(),
            '/cart': (context) => const CartScreen(),
            '/profile': (context) => const ProfileScreen(),
          },
        ),
      ),
    );
  }
}
