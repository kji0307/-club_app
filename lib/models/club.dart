class Club {
  final String id;
  final String name;
  final String category;
  final String description;
  final int members;
  final String location;
  final String meetingDay;
  
  Club({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.members,
    required this.location,
    required this.meetingDay,
  });

  factory Club.fromFirestore(Map<String, dynamic> data, String id) {
    return Club(
      id: id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      members: data['members'] ?? 0,
      location: data['location'] ?? '',
      meetingDay: data['meetingDay'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'members': members,
      'location': location,
      'meetingDay': meetingDay,
    };
  }
} 