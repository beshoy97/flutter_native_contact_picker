import 'package:phone_number_picker/sim_picker.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_number_picker_method_channel.dart';

abstract class MobileNumberPickerPlatform extends PlatformInterface {

  MobileNumberPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobileNumberPickerPlatform _instance =
      MethodChannelMobileNumberPicker();

  /// The default instance of [MobileNumberPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobileNumberPicker].
  static MobileNumberPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobileNumberPickerPlatform] when
  /// they register themselves.
  static set instance(MobileNumberPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<SimPickerCallbackResult> getMobileNumbers() {
    throw UnimplementedError('getMobileNumbers() has not been implemented.');
  }
}
