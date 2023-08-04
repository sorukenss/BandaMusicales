import 'package:dand_names/pages/status.dart';
import 'package:dand_names/services/services.dart';
import 'package:flutter/material.dart';

import 'package:dand_names/pages/pages.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  SocketService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName :(_) => const HomeScreen(),
          StatusScreen.routeName: (_) => const StatusScreen(),
        },
      ),
    );
  }
}