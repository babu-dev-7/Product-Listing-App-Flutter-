import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/hive/hive_service.dart';

import 'features/product/data/datasource/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  final dataSource = ProductRemoteDataSource();
  final repo = ProductRepositoryImpl(dataSource);
  final usecase = GetProducts(repo);

  runApp(MyApp(usecase));
}

class MyApp extends StatelessWidget {
  final GetProducts usecase;

  const MyApp(this.usecase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C5CE7),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF2D3436),
          titleTextStyle: TextStyle(
            color: Color(0xFF2D3436),
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      home: BlocProvider(
        create: (_) => ProductBloc(usecase),
        child: const MainPage(),
      ),
    );
  }
}