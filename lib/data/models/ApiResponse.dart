class ApiResponse<T> {
  final int status;
  final String message;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic>? json,
    T Function(dynamic) fromJsonT,
  ) {
    try{
      return ApiResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        data: fromJsonT(json['data']),
      );
    }catch(e){
      return ApiResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        data: null,
      );
    }

  }
}
