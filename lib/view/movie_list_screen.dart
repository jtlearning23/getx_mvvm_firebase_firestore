import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/movie_controller.dart';
import '../model/movie.dart';
import 'movie_form_screen.dart';

class MovieListScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (movieController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (movieController.filteredMovies.isEmpty) {
          return Center(child: Text('No movies found'));
        }
        return ListView.builder(
          itemCount: movieController.filteredMovies.length,
          itemBuilder: (context, index) {
            final movie = movieController.filteredMovies[index];
            return ListTile(
              title: Text(movie.title),
              subtitle: Text('${movie.genre} | ${movie.director}'),
              onTap: () {
                // Navigate to MovieFormScreen for updating this movie
                Get.to(() => MovieFormScreen(movie: movie));
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _confirmDelete(context, movie);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to MovieFormScreen for adding a new movie
          Get.to(() => MovieFormScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    String genreFilter = '';
    String directorFilter = '';

    Get.defaultDialog(
      title: "Filter Movies",
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Genre'),
            onChanged: (value) {
              genreFilter = value;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Director'),
            onChanged: (value) {
              directorFilter = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              movieController.applyFilters(genreFilter, directorFilter);
              Get.back(); // Close the filter dialog
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }

  // Method to confirm deletion of a movie
  void _confirmDelete(BuildContext context, Movie movie) {
    Get.defaultDialog(
      title: "Delete Movie",
      content: Text("Are you sure you want to delete '${movie.title}'?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            movieController.deleteMovie(movie);  // Call delete method
            Get.back();  // Close the dialog
          },
          child: Text("Delete"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();  // Close the dialog without deleting
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
