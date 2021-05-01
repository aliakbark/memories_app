class BaseResponseHeader {
  BaseResponseHeader({
    required this.type,
    required this.message,
    required this.status,
  });

  factory BaseResponseHeader.fromJson(Map<String, dynamic> json) =>
      BaseResponseHeader(
        type: json['type'],
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'status': status,
      };

  String type;
  String message;
  String status;
}
