import 'package:crytocurrecy_with_bloc/blocs/crypto/crypto_bloc.dart';
import 'package:crytocurrecy_with_bloc/repositories/crypto_repository.dart';
import 'package:crytocurrecy_with_bloc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoBloc>(
      create: (_) => CryptoBloc(
        cryptoRepository: CryptoRepository(),
      )..add(AppStarted()),
      child: MaterialApp(
        title: 'Flutter Crypto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.pinkAccent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
