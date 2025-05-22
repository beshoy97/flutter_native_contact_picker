import 'package:phone_number_picker/sim_picker.dart';

import 'mobile_number_picker_platform_interface.dart';

class MobileNumberPicker {
  Future<SimPickerCallbackResult> getMobileNumbers() {
    return MobileNumberPickerPlatform.instance.getMobileNumbers();
  }
}
