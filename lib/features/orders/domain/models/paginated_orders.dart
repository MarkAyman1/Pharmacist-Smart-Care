class PaginatedOrders<T> {
  final List<T> items;
  final int totalPages;
  final int pageNumber;
  final bool hasNext;

  PaginatedOrders({
    required this.items,
    required this.totalPages,
    required this.pageNumber,
    required this.hasNext,
  });

  factory PaginatedOrders.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedOrders(
      items: (json['items'] as List)
          .map((e) => fromJsonT(e))
          .toList(),
      totalPages: json['totalPages'],
      pageNumber: json['pageNumber'],
      hasNext: json['hasNext'],
    );
  }
}