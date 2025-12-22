class MatchesModel {
  final String name;
  final int age;
  final String height;
  final String education;
  final String location;
  final String profession;
  final String? imageUrl;
  final List<String>? imageList;
  final bool usePageView;

  MatchesModel({
    required this.name,
    required this.age,
    required this.height,
    required this.education,
    required this.location,
    required this.profession,
    this.imageUrl,
    this.imageList,
    this.usePageView = false,
  });
}
