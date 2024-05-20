final String tableNotes = 'favorites';

class FavoritesFields {
  static final List<String> values = [id, title, navPos, fromPos, toPos];

  static final String id = '_id';
  static final String title = 'title';
  static final String navPos = 'navPos';
  static final String fromPos = 'fromPos';
  static final String toPos = 'toPos';
}

class Favorites {
  final int id;
  final String title;
  final String navPos;
  final String fromPos;
  final String toPos;

  const Favorites({this.id, this.title, this.navPos, this.fromPos, this.toPos});

  static Favorites fromJson(Map<String, Object> json) => Favorites(
        id: json[FavoritesFields.id] as int,
        title: json[FavoritesFields.title] as String,
        navPos: json[FavoritesFields.navPos] as String,
        fromPos: json[FavoritesFields.fromPos] as String,
        toPos: json[FavoritesFields.toPos] as String,
      );

  Map<String, Object> toJson() => {
        FavoritesFields.id: id,
        FavoritesFields.title: title,
        FavoritesFields.navPos: navPos,
        FavoritesFields.fromPos: fromPos,
        FavoritesFields.toPos: toPos
      };

  Favorites copy(
          {int id,
          String title,
          String navPos,
          String fromPos,
          String toPos}) =>
      Favorites(
          id: id ?? this.id,
          title: title ?? this.title,
          navPos: navPos ?? this.navPos,
          fromPos: fromPos ?? this.fromPos,
          toPos: toPos ?? this.toPos);
}
