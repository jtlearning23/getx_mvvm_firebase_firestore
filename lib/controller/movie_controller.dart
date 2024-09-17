import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/movie.dart';


class MovieController extends GetxController {
  var movieList = <Movie>[].obs;
  var filteredMovies = <Movie>[].obs; // This will hold the filtered movies
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    isLoading(true);
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('movies').get();

      movieList.value = snapshot.docs.map((doc) {
        return Movie(
          id: doc.id,
          title: doc['title'],
          genre: doc['genre'],
          director: doc['director'], releaseDate: doc['releaseDate'],
        );
      }).toList();

      filteredMovies.value = movieList; // Initialize filtered list
    } finally {
      isLoading(false);
    }
  }

  // Method to filter movies based on genre and director
  void applyFilters(String genre, String director) {
    filteredMovies.value = movieList.where((movie) {
      final matchesGenre = genre.isEmpty || movie.genre.toLowerCase().contains(genre.toLowerCase());
      final matchesDirector = director.isEmpty || movie.director.toLowerCase().contains(director.toLowerCase());
      return matchesGenre && matchesDirector;
    }).toList();
  }

  // Method to add a movie
// Method to add a movie
  void addMovie(Movie movie) async {
    // Create a new document reference with a unique ID
    DocumentReference docRef = FirebaseFirestore.instance.collection('movies').doc();

    // Assign the document ID to the movie's id field
    movie.id = docRef.id;

    // Add the movie data to Firestore, including the ID
    await docRef.set({
      'id': movie.id,  // Store the ID
      'title': movie.title,
      'genre': movie.genre,
      'director': movie.director,
      'releaseDate': movie.releaseDate,  // Include releaseDate
    });

    // Fetch the data from Firestore
    DocumentSnapshot snapshot = await docRef.get();

    // Print the document data
    if (snapshot.exists) {
      print('MovieFormScreen : Movie added successfully: ${snapshot.data()}');
    } else {
      print('No such document exists!');
    }

    fetchMovies(); // Refresh movie list
  }

// Method to update a movie
  void updateMovie(Movie movie) async {
    // Update the existing movie document by its ID
    await FirebaseFirestore.instance.collection('movies').doc(movie.id).update({
      'id': movie.id,  // Ensure the ID is part of the update
      'title': movie.title,
      'genre': movie.genre,
      'director': movie.director,
      'releaseDate': movie.releaseDate,  // Include releaseDate
    });


    // Fetch the updated data from Firestore
    DocumentReference docRef = FirebaseFirestore.instance.collection('movies').doc(movie.id);
    DocumentSnapshot snapshot = await docRef.get();

    // Print the updated document data
    if (snapshot.exists) {
      print('Movie updated successfully: ${snapshot.data()}');
    } else {
      print('No such document exists!');
    }


    fetchMovies(); // Refresh movie list
  }

  // In your MovieController class

  void deleteMovie(Movie movie) async {
    await FirebaseFirestore.instance.collection('movies').doc(movie.id).delete();
    fetchMovies();  // Refresh the movie list after deletion
  }
}
