
class SelfCareTwo {
  final String title;
  final String url;
  final String imageUrl;

  SelfCareTwo(this.title, this.url, this.imageUrl);

  SelfCareTwo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        url = json['url'],
        imageUrl = json['mobileicon']['path'];
}

  