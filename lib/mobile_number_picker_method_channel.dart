import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:phone_number_picker/sim_number.dart';
import 'package:phone_number_picker/sim_picker.dart';

import 'mobile_number_picker_platform_interface.dart';

/// An implementation of [MobileNumberPickerPlatform] that uses method channels.
class MethodChannelMobileNumberPicker extends MobileNumberPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_number_picker');

  @override
  Future<SimPickerCallbackResult> getMobileNumbers() async {
    final numberHint = await methodChannel.invokeMethod('getMobileNumbers');
    Map<String, dynamic> object = jsonDecode(numberHint);
    switch (object["code"] as int) {
      case 200:
        return SimPickerSuccessState(data: SimNumber.fromJson(object));
      default:
        return SimPickerErrorState(
          errorMessage: object["errorMessage"],
          errorCode: object["code"],
        );
    }
  }
}
