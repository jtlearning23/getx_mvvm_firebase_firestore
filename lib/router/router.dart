
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../view/movie_form_screen.dart';
import '../view/movie_list_screen.dart';

class AppRoutes {
  static const MOVIE_LIST_SCREEN = "/movie-list";
  static const MOVIE_ADD_SCREEN = "/movie-add";

  static final routes = [
    GetPage(
      name: MOVIE_LIST_SCREEN,
      page: () => MovieListScreen(),
    ),
    GetPage(
      name: MOVIE_ADD_SCREEN,
      page: () =>  MovieFormScreen(),
    ),
  ];

}
