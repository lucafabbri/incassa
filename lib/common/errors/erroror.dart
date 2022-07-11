import 'advanced_error.dart';


class ErrorOr<TValue> {
  TValue? _value;
  List<AdvancedError> errors = [];

  TValue get value {
    if (isError) {
      throw Exception(
          "Value can be retrieved only when the result is not an error.");
    }
    return _value!;
  }

  bool get isError => errors.isNotEmpty;

  AdvancedError? get firstError => errors.isNotEmpty ? errors.first : null;

  ErrorOr(TValue value) {
    _value = value;
  }
  ErrorOr.withError(AdvancedError error, {TValue? value}) {
    errors.add(error);
  }
  ErrorOr.withErrors(List<AdvancedError> errors, {TValue? value}) {
    errors.addAll(errors);
  }

  void iterate(
      Function(TValue) onValue, Function(List<AdvancedError>) onError) {
    if (isError) {
      onError(errors);
      return;
    }
    onValue(value);
  }

  void iterateFirst(
      Function(TValue) onValue, Function(AdvancedError) onFirstError) {
    if (isError) {
      onFirstError(firstError!);
      return;
    }
    onValue(value);
  }

  void match<TResult>(TResult Function(TValue) onValue,
      TResult Function(List<AdvancedError>) onError) {
    if (isError) {
      onError(errors);
      return;
    }
    onValue(value);
  }

  void matchFirst<TResult>(TResult Function(TValue) onValue,
      TResult Function(AdvancedError) onFirstError) {
    if (isError) {
      onFirstError(firstError!);
      return;
    }
    onValue(value);
  }
}
