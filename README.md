# mobile_number_picker

`mobile_number_picker` is a Flutter package designed to streamline the process of retrieving phone number hints from the user's device. It leverages the Phone Number Hint API, which is powered by Google Play services, to seamlessly display a user's SIM-based phone numbers as hints.

## Features

- No Additional Permissions: The package does not require any additional permission requests, ensuring a smooth user experience.
- Eliminates Manual Input: Users no longer need to manually type in their phone numbers, reducing input errors and saving time.
- No Google Account Required: Usage of the Phone Number Hint API does not necessitate a Google account, enhancing accessibility.
- Not Tied to Sign-in/Sign-up Workflows: The functionality provided by mobile_number_picker is not restricted to sign-in or sign-up processes, offering versatility in application.
- Wide Android Version Support: The package offers broader compatibility across various Android versions compared to Autofill solutions.

## DEMO
TODO:p => Link to demo gif

## Getting Started

### Installation

To integrate `mobile_number_picker` into your Flutter project, simply add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  mobile_number_picker: ^0.0.7
```

Then, run flutter pub get to install the package.

## Example

```Dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mobile_number_picker/mobile_number_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _phoneNumber;
  final _simNumberPickerPlugin = MobileNumberPicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> getPhoneNumbers() async {
    SimPicker? simPicker;
    try {
      simPicker = await _simNumberPickerPlugin.getMobileNumbers();
    } on PlatformException {
      simPicker = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      switch (simPicker) {
        case SuccessState():
          _phoneNumber = (simPicker.data as SimNumber).data;
        case ErrorState():
          _phoneNumber = simPicker.errorMessage;
        default:
          _phoneNumber = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(child: _body2()),
      ),
    );
  }

  Widget _body2() {
    return InkWell(
      child: Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
              'Phone number: ${(_phoneNumber)}',
            )),
      ),
      onTap: () {
        getPhoneNumbers();
      },
    );
  }
}
