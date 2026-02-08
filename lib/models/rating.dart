class Rating {
  final double rate;
  final int people;

  const Rating({required this.rate, required this.people});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      people: json['people'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'people': people};
  }

  Rating copyWith({double? rate, int? people}) {
    return Rating(rate: rate ?? this.rate, people: people ?? this.people);
  }

  @override
  String toString() => 'Rating(rate: $rate, people: $people)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rating && other.rate == rate && other.people == people;
  }

  @override
  int get hashCode => rate.hashCode ^ people.hashCode;
}
