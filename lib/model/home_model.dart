class HomeModel {
  final String name;
  final String imageUrl;
  final int viewedYou;
  final int sentRequests;
  final int receivedRequests;
  final int acceptedRequests;
  final double profileCompletion;

  HomeModel({
    required this.name,
    required this.imageUrl,
    required this.viewedYou,
    required this.sentRequests,
    required this.receivedRequests,
    required this.acceptedRequests,
    required this.profileCompletion,
  });
}
