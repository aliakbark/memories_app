class BaseResponseHeader {
  BaseResponseHeader({
    this.type,
    this.message,
    this.status,
  });

  String type;
  String message;
  String status;

  factory BaseResponseHeader.fromJson(Map<String, dynamic> json) =>
      BaseResponseHeader(
        type: json["type"] == null ? null : json["type"],
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "message": message == null ? null : message,
        "status": status == null ? null : status,
      };
}
