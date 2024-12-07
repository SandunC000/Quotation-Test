import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enhanzer_test/repositories/item_repository.dart';
import 'package:enhanzer_test/services/database_service.dart';
import 'package:enhanzer_test/viewModels/item_view_model.dart';
import 'package:enhanzer_test/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  final itemRepository = ItemRepository(databaseService);
  final itemViewModel = ItemViewModel(itemRepository);
  await itemViewModel.fetchItems();

  runApp(
    ChangeNotifierProvider(
      create: (context) => itemViewModel,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enhanzer Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ItemViewModel(ItemRepository(DatabaseService())),
        child: const HomeView(),
      ),
    );
  }
}
