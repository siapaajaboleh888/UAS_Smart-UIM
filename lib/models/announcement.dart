class Announcement {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime date;
  final String? courseCode;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    this.courseCode,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} Hari Yang Lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} Jam Yang Lalu';
    } else {
      return '${difference.inMinutes} Menit Yang Lalu';
    }
  }

  static List<Announcement> getSampleAnnouncements() {
    return [
      Announcement(
        id: '1',
        title: 'Pengumuman UAS Semester Genap 2024/2025',
        content: 'Diinformasikan kepada seluruh mahasiswa, UAS akan dilaksanakan secara hybrid (online & offline) mulai tanggal 20 Desember 2025...',
        author: 'Admin IT Smart UIM',
        date: DateTime(2024, 12, 10, 10, 45),
      ),
      Announcement(
        id: '2',
        title: 'Maintenance Sistem Smart UIM',
        content: 'Sistem akan dilakukan maintenance pada hari Minggu, 15 Desember 2025 pukul 00.00 - 06.00 WIB untuk meningkatkan performa sistem.',
        author: 'Admin IT Smart UIM',
        date: DateTime(2024, 12, 8, 14, 30),
      ),
      Announcement(
        id: '3',
        title: 'Pengumpulan Tugas Akhir Semester',
        content: 'Batas akhir pengumpulan tugas akhir semester adalah tanggal 18 Desember 2025 pukul 23:59 WIB. Harap kumpulkan tepat waktu.',
        author: 'Admin IT Smart UIM',
        date: DateTime(2024, 12, 5, 9, 15),
      ),
    ];
  }
}
