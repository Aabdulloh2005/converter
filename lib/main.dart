import 'package:currency_converter/bloc/currency_bloc/currency_bloc.dart';
import 'package:currency_converter/bloc/observer/all_observer.dart';
import 'package:currency_converter/repositories/currency_http.dart';
import 'package:currency_converter/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencyBloc(CurrencyRepository()),
        )
      ],
      child: MaterialApp(
        title: 'Currency Converter',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Homepage(),
      ),
    );
  }
}