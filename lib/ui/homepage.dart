import 'package:currency_converter/bloc/currency_bloc/currency_bloc.dart';
import 'package:currency_converter/bloc/currency_bloc/currency_event.dart';
import 'package:currency_converter/bloc/currency_bloc/currency_state.dart';
import 'package:currency_converter/ui/convertation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CurrencyBloc>().add(FetchCurrencies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              hintText: "USD"),
          controller: _textController,
          onChanged: (value) {
            context.read<CurrencyBloc>().add(
                  FetchCurrenciesByText(text: value),
                );
          },
        ),
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoaded) {
            return ListView.builder(
              itemCount: state.currencies.length,
              itemBuilder: (context, index) {
                final currency = state.currencies[index];
                return ListTile(
                  title: Text(currency.name),
                  subtitle: Text('Rate: ${currency.rate}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConvertationScreen(currency: currency),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load currencies'));
          }
        },
      ),
    );
  }
}
