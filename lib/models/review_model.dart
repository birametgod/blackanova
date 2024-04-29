
List<Map<String, dynamic>> reviewList = [
  {
    "name" : "Iris",
    "image" : "assets/images/blackGirl.png",
    "rating": "5",
    "comment": "I had a wonderful experience at the hairdresser! The stylist did an amazing job with my hai...",
    "date": "07 Mar 2023"
  },
  {
    "name" : "Chelsea",
    "image" : "assets/images/blackGirl.png",
    "rating": "5",
    "comment": "The hairdresser was great! I got the exact style I wanted and it looked amazing! My stylist...",
    "date": "06 Mar 2023"
  },
  {
    "name" : "Seynabou",
    "image" : "assets/images/blackGirl.png",
    "rating": "5",
    "comment": "My haircut is fantastic now and it really suits me. My stylist was really friendly and pa...",
    "date": "20 Fev 2023"
  }
];

class Review {
  final String name;
  final String rating;
  final String comment;
  final String date;
  final String image;

  Review({required this.name, required this.rating, required this.comment, required this.date, required this.image});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        name: json['name'],
        rating: json['rating'],
        comment: json['comment'],
        date: json['date'],
        image: json['image']
    );
  }
}