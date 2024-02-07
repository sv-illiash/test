class MovieEntity {
  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;

  MovieEntity(
      {required this.id, required this.title, required this.imageUrl, required this.description});
}
