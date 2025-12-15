class Assignment {
  final String id;
  final String title;
  final String courseCode;
  final DateTime deadline;
  final bool isSubmitted;
  final String? submittedDate;
  final String? grade;
  final String? fileName;

  Assignment({
    required this.id,
    required this.title,
    required this.courseCode,
    required this.deadline,
    this.isSubmitted = false,
    this.submittedDate,
    this.grade,
    this.fileName,
  });

  bool get isOverdue => DateTime.now().isAfter(deadline) && !isSubmitted;
  bool get isDueSoon {
    final now = DateTime.now();
    final difference = deadline.difference(now);
    return difference.inDays <= 3 && difference.inDays >= 0 && !isSubmitted;
  }

  static List<Assignment> getSampleAssignments() {
    return [
      Assignment(
        id: '1',
        title: 'Tugas UAS - Smart UIM Mobile App',
        courseCode: 'TIF-2201',
        deadline: DateTime(2025, 12, 31, 23, 59),
        isSubmitted: true,
        submittedDate: '15 Desember 2025',
        fileName: 'Moh_Syaiful_Anam_2022020100078.pdf',
      ),
      Assignment(
        id: '2',
        title: 'Laporan Praktikum Basis Data',
        courseCode: 'TIF-2203',
        deadline: DateTime(2025, 12, 20, 23, 59),
       isSubmitted: true,
        submittedDate: '15 Desember 2025',
      ),
      Assignment(
        id: '3',
        title: 'Project Akhir UI/UX Design',
        courseCode: 'TIF-2202',
        deadline: DateTime(2025, 12, 22, 23, 59),
        isSubmitted: true,
        submittedDate: '15 Desember 2025',
      ),
    ];
  }
}
