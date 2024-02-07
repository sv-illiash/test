class CashedModel {
  static const String idFieldName = 'id';
  static const String titleFieldName = 'title';
  static const String descriptionFieldName = 'description';
  static const String imageUrlFieldName = 'imageUrl';

  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;

  CashedModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      idFieldName: id,
      titleFieldName: title,
      descriptionFieldName: description,
      imageUrlFieldName: imageUrl,
    };
  }

  factory CashedModel.fromMap(Map<String, dynamic> map) {
    return CashedModel(
      id: map[idFieldName],
      title: map[titleFieldName],
      imageUrl: map[imageUrlFieldName],
      description: map[descriptionFieldName],
    );
  }
}
