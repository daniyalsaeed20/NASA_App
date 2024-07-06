class ResponseHandler {
  static handleResponse({required int statusCode}) {
    switch (statusCode) {
      case 400:
        return 'Bad Request: The server could not understand the request due to invalid syntax.';
      case 401:
        return 'Unauthorized: The client must authenticate itself to get the requested response.';
      case 403:
        return 'Forbidden: The client does not have access rights to the content.';
      case 404:
        return 'Not Found: The server can not find the requested resource.';
      case 500:
        return 'Internal Server Error: The server has encountered a situation it doesn\'t know how to handle.';
      case 502:
        return 'Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from the upstream server.';
      case 503:
        return 'Service Unavailable: The server is not ready to handle the request.';
      case 504:
        return 'Gateway Timeout: The server is acting as a gateway or proxy and did not receive a timely response from the upstream server.';
      default:
        return 'Failed to load APODs: Unexpected error occurred with status code $statusCode.';
    }
  }
}
