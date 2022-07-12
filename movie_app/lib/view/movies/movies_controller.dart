import 'package:flutter/material.dart';
import 'package:movie_app/model/movies.dart' as model;
import 'package:movie_app/services/movies.dart';
import 'package:movie_app/styles/style.dart';
import 'package:movie_app/widget/alertdlg.dart';

class MoviesController extends ChangeNotifier {
  Widget _listMovies = Container();
  bool _loading = false;

  late BuildContext _context;
  final _service = MoviesService();

  Widget get listMovies => _listMovies;
  bool get loading => _loading;

  void create({required BuildContext context}) {
    _context = context;
  }

  void search({required String movie}) {
    _unfocus(context: _context);

    _loading = true;
    _listMovies = Container();

    notifyListeners();

    _service.countMovies(title: movie).then((resp) {
      if (resp.statusCode == 200) {
        final body = model.moviesFromJson(resp.body);

        if (body.total > 0) {
          _buildListMovies(listMovies: body);
        } else {
          _loading = false;
          notifyListeners();

          AlertDlg().showWarning(
            title: 'Atenção',
            body: 'Nenhum filme encontrado',
            context: _context,
          );
        }
      } else {
        _loading = false;
        notifyListeners();

        AlertDlg().showWarning(
          title: 'Requisição Inválida (${resp.statusCode.toString()})',
          body: resp.body.toString(),
          context: _context,
        );
      }
    });
  }

  _buildListMovies({required model.Movies listMovies}) {
    final styles = Styles();
    List<Widget> chips = [];

    for (var mv in listMovies.moviesByYear) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Chip(
            side: const BorderSide(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.solid,
            ),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            avatar: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                mv.movies.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            label: Text(
              mv.year.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                //color: _style.corBase2(),
              ),
            ),
          ),
        ),
      );
    }

    _listMovies = Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: styles.colorPrimary(),
                fontSize: 22.5,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: listMovies.total.toString(),
                ),
                const TextSpan(
                  text: ' títulos encontrados',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Wrap(
            spacing: 3,
            runSpacing: 5,
            children: chips,
          ),
        ],
      ),
    );

    _loading = false;
    notifyListeners();
  }

  void _unfocus({required BuildContext context}) {
    var currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
