class SimNumber {
  final int code;
  final String data;
  final String errorMessage;

  SimNumber(
      {required this.code, required this.data, required this.errorMessage});

  factory SimNumber.fromJson(Map<String, dynamic> dataMap) {
    return SimNumber(
        code: dataMap["code"] ?? 404,
        data: dataMap["data"],
        errorMessage: dataMap["errorMessage"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "data": data, "errorMessage": errorMessage};
  }

  @override
  String toString() {
    return 'SimNumber{code: $code, data: $data, errorMessage: $errorMessage}';
  }
}
