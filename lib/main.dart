import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'OnbordingScreen/splash.dart';
import 'db/providers/addtransaction_provider.dart';
import 'db/providers/category_provider.dart';
import 'db/providers/updateprovider.dart';
import 'models/category/category_model.dart';
import 'models/transactions/transaction_model.dart';



int? isviewsd;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the CategoryTypeAdapter and CategoryModelAdapter
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  // Register the TransactionModelAdapter and open the transactionModel box
  Hive.registerAdapter(transactionModelAdapter());
  // if (!Hive.isBoxOpen(TRANSACTION_DB_NAME)) {
  //   await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
  // }

  // Register the SplashscreensAdapter and open the Splashscreens box
  Hive.registerAdapter(SplashscreensAdapter());
  if (!Hive.isBoxOpen('Splashscreens')) {
    await Hive.openBox<Splashscreens>('Splashscreens');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
// ChangeNotifierProvider(
        //   create: (context) => BottomNavigationBarProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => AddTransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => updateprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryDBProvide(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
