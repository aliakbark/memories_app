class BaseRequestHeader {
  BaseRequestHeader({
    required this.type,
  });

  factory BaseRequestHeader.fromJson(Map<String, dynamic> json) =>
      BaseRequestHeader(
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
      };

  String type;
}
