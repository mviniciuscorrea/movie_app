import 'package:flutter/material.dart';
import 'package:movie_app/view/movies/movies_controller.dart';
import 'package:movie_app/widget/button.dart';
import 'package:movie_app/widget/input.dart';
import 'package:provider/provider.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlInputMovieName = TextEditingController();

  MoviesController _movieCtrl = MoviesController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _movieCtrl.create(context: context);
    });
  }

  void _searchAndCountMoves() {
    if (_formKey.currentState!.validate()) {
      _movieCtrl.search(movie: _ctrlInputMovieName.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<MoviesController>(
        create: (context) => MoviesController(),
        child: Builder(
          builder: (context) {
            _movieCtrl = context.read<MoviesController>();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.deepPurple,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 65,
                            ),
                            Input().insertInputRequired(
                              context: context,
                              controller: _ctrlInputMovieName,
                              label: 'Filme',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Consumer<MoviesController>(
                                builder: (context, provider, child) {
                              return _movieCtrl.loading
                                  ? const CircularProgressIndicator()
                                  : Button(
                                      onPressed: _searchAndCountMoves,
                                      text: 'Pesquisar',
                                      icon: Icons.search,
                                    );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                  Consumer<MoviesController>(
                    builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: provider.listMovies,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
