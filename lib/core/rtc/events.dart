import 'dart:convert';

enum Events { interfaceValueChanged }

class InterfaceValueChangeData {
  final String interfaceId;
  final double value;
  InterfaceValueChangeData({
    required this.interfaceId,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'interface': interfaceId,
      'value': value,
    };
  }

  factory InterfaceValueChangeData.fromMap(Map<String, dynamic> map) {
    return InterfaceValueChangeData(
      interfaceId: map['interface'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InterfaceValueChangeData.fromJson(String source) => InterfaceValueChangeData.fromMap(json.decode(source));
}
