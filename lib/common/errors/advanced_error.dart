import 'error_type.dart';

class AdvancedError {
  final String _code;
  final String _description;
  final ErrorsType _errorType;

  String get code => _code;
  String get description => _description;
  ErrorsType get errorType => _errorType;
  
  AdvancedError(this._code,this._description,this._errorType);
  
  static AdvancedError failure = AdvancedError("General.Failure","A failure has accourred", ErrorsType.failure);
  static AdvancedError unexpected = AdvancedError("General.Unexpected","A failure has accourred", ErrorsType.unexpected);
  static AdvancedError validation = AdvancedError("General.Validation","A failure has accourred", ErrorsType.validation);
  static AdvancedError conflict = AdvancedError("General.Conflict","A failure has accourred", ErrorsType.conflict);
  static AdvancedError notFound = AdvancedError("General.NotFound","A failure has accourred", ErrorsType.notFound);
}
