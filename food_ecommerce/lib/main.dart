import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/components/app_theme.dart';
import 'package:food_ecommerce/ui/cubits/favorite_cubit.dart';
import 'package:food_ecommerce/ui/cubits/main_cubit.dart';
import 'package:food_ecommerce/ui/cubits/product_basket_cubit.dart';
import 'package:food_ecommerce/ui/cubits/product_details_cubit.dart';

import 'package:food_ecommerce/ui/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainCubit()..loadProducts()),
        BlocProvider(create: (_) => ProductDetailsCubit()),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => ProductBasketCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: const MainScreen(),
      ),
    );
  }
}
