class Floor {
  final int level;
  final String label;
  final String imageUrl;
  final List<Room> rooms;

  Floor({
    required this.level,
    required this.label,
    required this.imageUrl,
    this.rooms = const [],
  });
}

class Room {
  final String id;
  final String name;
  final double x;
  final double y;

  Room({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
  });
} 