class GetCityDetails {
  final String title;
  final int woeid;

  GetCityDetails(this.title, this.woeid);

  GetCityDetails.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        woeid = json['woied'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'woied': woeid,
  };
}
