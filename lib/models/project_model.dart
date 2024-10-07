class Project {
  final int id;
  final String title;
  final String category;
  final double minBudget;
  final double maxBudget;
  final String description;
  final List<String> skills;
  final DateTime publishedDate;
  final int deadline;
  final String workType;
  final String clientName;
  final double clientRating;
  final int clientProjects;

  Project({
    required this.id,
    required this.title,
    required this.category,
    required this.minBudget,
    required this.maxBudget,
    required this.description,
    required this.skills,
    required this.publishedDate,
    required this.deadline,
    required this.workType,
    required this.clientName,
    required this.clientRating,
    required this.clientProjects,
  });
}