sealed class CurrencyEvent {}

class FetchCurrencies extends CurrencyEvent {}

class FetchCurrenciesByText extends CurrencyEvent {
  final String text;

  FetchCurrenciesByText({required this.text});
}
