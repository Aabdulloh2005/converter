import 'package:currency_converter/models/currency.dart';

sealed class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> currencies;
  CurrencyLoaded(this.currencies);
}

class CurrencyError extends CurrencyState {}
