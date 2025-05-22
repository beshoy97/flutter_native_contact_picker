import 'package:phone_number_picker/sim_number.dart';

sealed class SimPickerCallbackResult {}

class SimPickerSuccessState<T> extends SimPickerCallbackResult {
  final SimNumber data;

  SimPickerSuccessState({required this.data});
}

class SimPickerErrorState extends SimPickerCallbackResult {
  final String errorMessage;
  final int errorCode;

  SimPickerErrorState({required this.errorCode, required this.errorMessage});
}
