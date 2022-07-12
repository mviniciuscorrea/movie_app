import 'package:http/http.dart' as http;
import 'package:movie_app/model/configuration.dart';

class MoviesService {
  MoviesService();

  Future countMovies({required String title}) async {
    if (title.isEmpty) {
      return null;
    }

    final config = Configuration();

    final response = await http
        .get(Uri.parse('${config.url}/count?Title=$title'),
            headers: config.header)
        .timeout(
      Duration(seconds: config.timeOut),
      onTimeout: () {
        return http.Response(
          config.timeOutMessage,
          config.timeOutHttpCode,
        );
      },
    );

    return response;
  }
}
