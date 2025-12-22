

import 'package:european_single_marriage/data/response/status.dart';

class ResponseState<T> {
  Status? status;
  T? data;
  String? message;

  ResponseState(this.status, this.data, this.message);

  ResponseState.loading() : status = Status.LOADING;
  ResponseState.completed(this.data) : status = Status.COMPLETED;
  ResponseState.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}
