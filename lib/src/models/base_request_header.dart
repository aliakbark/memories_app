class BaseRequestHeader {
  BaseRequestHeader({
    this.type,
  });

  String type;

  factory BaseRequestHeader.fromJson(Map<String, dynamic> json) =>
      BaseRequestHeader(
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
      };
}
