class BaseResponse {
  int code;
  String msg;
  int timestamp;

  BaseResponse(this.code, this.msg, this.timestamp);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
