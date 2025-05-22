import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number_picker/mobile_number_picker.dart';
import 'package:phone_number_picker/sim_picker.dart';

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
    SimPickerCallbackResult? simPicker;
    try {
      simPicker = await _simNumberPickerPlugin.getMobileNumbers();
    } on PlatformException {
      simPicker = null;
    }

    if (!mounted) return;

    setState(() {
      switch (simPicker) {
        case SimPickerSuccessState():
          _phoneNumber = simPicker.data.data;
        case SimPickerErrorState():
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
