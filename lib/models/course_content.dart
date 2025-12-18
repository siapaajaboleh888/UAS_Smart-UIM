class CourseContent {
  final String id;
  final String title;
  final String info; // e.g., "3 URLs, 2 files, 2 interaction content"
  final bool isCompleted;
  final ContentType type;
  final int week;

  CourseContent({
    required this.id,
    required this.title,
    required this.info,
    this.isCompleted = false,
    required this.type,
    required this.week,
  });
}

enum ContentType { material, task }

class CourseDetailData {
  final List<CourseContent> materials;
  final List<CourseContent> tasks;

  CourseDetailData({
    required this.materials,
    required this.tasks,
  });

  static Map<String, CourseDetailData> getSampleContent() {
    return {
      '1': CourseDetailData(
        materials: [
          CourseContent(id: 'm1', title: 'Pengantar Pemrograman Mobile', info: '2 Video, 1 PDF, 1 Artikel', isCompleted: true, type: ContentType.material, week: 1),
          CourseContent(id: 'm2', title: 'Instalasi Flutter & Dart SDK', info: '1 Video, 2 Panduan Instalasi', isCompleted: true, type: ContentType.material, week: 2),
          CourseContent(id: 'm3', title: 'Stateless vs Stateful Widget', info: '1 Video, 3 Latihan Code', isCompleted: true, type: ContentType.material, week: 3),
          CourseContent(id: 'm4', title: 'Navigasi dan Routing', info: '2 Video, 1 Project Base', isCompleted: false, type: ContentType.material, week: 4),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Kuis 1: Dasar Dart', info: '10 Soal Pilgan', isCompleted: true, type: ContentType.task, week: 2),
          CourseContent(id: 't2', title: 'Tugas 1: Membuat Layout Sederhana', info: 'Deadline: 20 Des 2024', isCompleted: false, type: ContentType.task, week: 4),
        ],
      ),
      '2': CourseDetailData(
        materials: [
          CourseContent(id: 'm1', title: 'Pengantar User Interface Design', info: '3 URLs, 2 files, 2 interactive content', isCompleted: true, type: ContentType.material, week: 1),
          CourseContent(id: 'm2', title: 'Konsep User Interface Design', info: '2 URLs, 1 file, 1 Tugas', isCompleted: true, type: ContentType.material, week: 2),
          CourseContent(id: 'm3', title: 'Interaksi pada User Interface Design', info: '3 URLs, 2 files, 2 interactive content', isCompleted: true, type: ContentType.material, week: 3),
          CourseContent(id: 'm4', title: 'Ethnographic Observation', info: '1 Video, 1 Field Guide', isCompleted: false, type: ContentType.material, week: 4),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Kuis: Prinsip Desain', info: '5 Soal Esai', isCompleted: true, type: ContentType.task, week: 2),
          CourseContent(id: 't2', title: 'Tugas: Wireframing Aplikasi', info: 'Deadline: 22 Des 2024', isCompleted: false, type: ContentType.task, week: 4),
        ],
      ),
      '3': CourseDetailData(
        materials: [
          CourseContent(id: 'm1', title: 'Pengenalan DBMS', info: '1 Video, 2 PDF', isCompleted: true, type: ContentType.material, week: 1),
          CourseContent(id: 'm2', title: 'Entity Relationship Diagram', info: '2 Latihan Mandiri', isCompleted: true, type: ContentType.material, week: 2),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Tugas: Merancang ERD Toko Online', info: 'Deadline: 19 Des 2024', isCompleted: false, type: ContentType.task, week: 3),
        ],
      ),
      // Add more as needed for other IDs...
    };
  }
}
