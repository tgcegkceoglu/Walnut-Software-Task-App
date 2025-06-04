
enum ApiResponseStatus {
  success,
  failure,
  unauthorized
}

enum ApiStatusCode {
  ok(200),
  error(500),
  unauthorized(401),
  forbidden(403),
  notFound(404);

  final int code;
  const ApiStatusCode(this.code);
}
