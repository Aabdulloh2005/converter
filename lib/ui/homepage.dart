import 'package:currency_converter/bloc/currency_bloc.dart';
import 'package:currency_converter/bloc/currency_state.dart';
import 'package:currency_converter/ui/convertation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency Converter')),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoaded) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final currency = state.list[index];
                return ListTile(
                  title: Text(currency.name),
                  subtitle: Text('Rate: ${currency.currency}'),
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
          } else if (state is CurrencyError) {
            return Center(child: Text('Error: ${state.errorText}'));
          } else {
            return const Center(child: Text('Failed to load currencies'));
          }
        },
      ),
    );
  }
}
