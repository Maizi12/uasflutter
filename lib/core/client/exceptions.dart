abstract class Failure {
  final int? statusCode;
  final String? message;

  const Failure({this.statusCode, this.message});
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? message;

  const ServerFailure(this.statusCode, this.message);

  @override
  String toString() {
    return 'ServerFailure(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) =>
      other is ServerFailure &&
      other.message == message &&
      other.statusCode == statusCode;

  @override
  int get hashCode => message.hashCode;
}

class NoDataFailure extends Failure {
  @override
  bool operator ==(Object other) => other is NoDataFailure;

  @override
  int get hashCode => 0;
}

class CacheFailure extends Failure {
  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}

class UnauthenticatedFailure extends Failure {}
