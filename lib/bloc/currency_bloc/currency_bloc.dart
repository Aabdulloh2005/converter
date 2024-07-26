import 'package:bloc/bloc.dart';
import 'package:currency_converter/bloc/currency_bloc/currency_event.dart';
import 'package:currency_converter/bloc/currency_bloc/currency_state.dart';
import 'package:currency_converter/repositories/currency_http.dart';
import 'package:stream_transform/stream_transform.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;
  CurrencyBloc(this.repository) : super(CurrencyInitial()) {
    on<FetchCurrencies>(_onFetchCurrencies);
    on<FetchCurrenciesByText>(
      _onFetchCurrenciesByText,
      transformer: (events, mapper) =>
          events.throttle(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }

  void _onFetchCurrencies(FetchCurrencies event, emit) async {
    emit(CurrencyLoading());
    try {
      final currencies = await repository.fetchCurrencies();
      emit(CurrencyLoaded(currencies));
    } catch (_) {
      emit(CurrencyError());
    }
  }

  void _onFetchCurrenciesByText(FetchCurrenciesByText event, emit) async {
    emit(CurrencyLoading());
    try {
      final currencies = await repository.fetchCurrencies();
      emit(CurrencyLoaded(
        currencies
            .where((element) =>
                element.name.toLowerCase().contains(event.text.toLowerCase()))
            .toList(),
      ));
    } catch (_) {
      emit(CurrencyError());
    }
  }
}