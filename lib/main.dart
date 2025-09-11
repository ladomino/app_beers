import 'package:app_beers/shared/app_router.dart';
import 'package:app_beers/ui/pages/beers_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _createTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Times New Roman', 
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: const Key('BeersApp'),
      title: 'Flutter Beers App',
      theme: _createTheme(Brightness.light),
      darkTheme: _createTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: Key('Beers'),
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              //ref.read(searchHelperProvider).searchString = value;
            },
            decoration: const InputDecoration(
              hintText: 'Search Beers',
              prefixIcon: Icon(Icons.search, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onSubmitted: (value) {
              // The search will be handled by the JokesListPage
            },
          ),
        ),
      ),
      body: BeersListPage(),
    );
  }
}
