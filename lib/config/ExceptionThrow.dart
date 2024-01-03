// ignore_for_file: file_names

class ExceptionThrow {
  throwInternetException() {
    return {'status': 'error', 'message': 'Check Your Internet Connection'};
  }

  throwServerException() {
    return {'status': 'error', 'message': 'Unknown Server Error'};
  }
}
