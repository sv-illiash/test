class DetailMovieEntity {
  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final double popularity;

  DetailMovieEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.popularity});
}
