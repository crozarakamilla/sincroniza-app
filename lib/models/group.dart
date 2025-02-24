class Group {
  const Group({
    required this.id,
    required this.name,
    required this.users,
    required this.events,
  });

  final String id;
  final String name;
  final List<String> users;
  final List<String> events;
}
