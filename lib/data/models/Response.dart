class Response<T> {
  final int status;
  final String message;
  final T data;

  Response({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return Response(
      status: json['status'] as int,
      message: json['message'] as String,
      data: fromJsonT(json['data']),
    );
  }
}
