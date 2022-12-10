class News {
  String? title;
  String? link;
  String? image;
  String? date;
  String? excerpt;

  News({this.title, this.link, this.image, this.date, this.excerpt});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    image = json['image'];
    date = json['date'];
    excerpt = json['excerpt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['link'] = link;
    data['image'] = image;
    data['date'] = date;
    data['excerpt'] = excerpt;
    return data;
  }

  //format date
  String getFormattedDate() {
    var dateParse = DateTime.parse("${date}");
    return "${dateParse.day}/${dateParse.month}/${dateParse.year}";
  }
}
