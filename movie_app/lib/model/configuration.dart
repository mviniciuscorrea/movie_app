class Configuration {
  final url = 'http://10.0.2.2:3000/api/movies';
  final timeOut = 15;
  final timeOutHttpCode = 503;
  final timeOutMessage = 'Tempo limite atingido';
  final header = {"Content-Type": "application/json"};
}
