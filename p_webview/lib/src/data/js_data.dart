import 'dart:convert';

class JSData {
  final String method;
  final Map data;

  JSData(this.method, this.data);

  JSData copyWith({
    String method,
    Map data,
  }) {
    return JSData(
      method ?? this.method,
      data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'data': data,
    };
  }

  factory JSData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return JSData(
      map['method'],
      Map.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory JSData.fromJson(String source) => JSData.fromMap(json.decode(source));
}
