import 'package:enhanzer_test/utilities/global_exports.dart';

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
      home: const HomeView(),
    );
  }
}
