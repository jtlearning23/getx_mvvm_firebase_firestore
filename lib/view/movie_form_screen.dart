import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/movie_controller.dart';
import '../model/movie.dart';

class MovieFormScreen extends StatelessWidget {
  final MovieController movieController = Get.find<MovieController>();
  final Movie? movie;


  MovieFormScreen({this.movie});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // If a movie is passed in for editing, populate the fields with its data
    if (movie != null) {
      titleController.text = movie!.title;
      genreController.text = movie!.genre;
      directorController.text = movie!.director;
      releaseDateController.text = movie!.releaseDate;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(movie == null ? 'Add Movie' : 'Update Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: genreController, decoration: InputDecoration(labelText: 'Genre')),
            TextField(controller: directorController, decoration: InputDecoration(labelText: 'Director')),
            TextField(controller: releaseDateController, decoration: InputDecoration(labelText: 'Release Date')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Movie newMovie = Movie(
                  id: movie?.id ?? '',  // Use the existing movie's id if updating
                  title: titleController.text,
                  genre: genreController.text,
                  director: directorController.text,
                  releaseDate: releaseDateController.text,
                );

                if (movie == null) {
                  // If no movie is passed, add a new movie
                  movieController.addMovie(newMovie);
                } else {
                  // If a movie is passed, update the existing movie
                  movieController.updateMovie(newMovie);
                }

                Get.back();
              },
              child: Text(movie == null ? 'Add Movie' : 'Update Movie'),
            ),

          ],
        ),
      ),
    );
  }
}
