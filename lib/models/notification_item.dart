class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String type; // assignment, announcement, course, system
  final DateTime timestamp;
  final bool isRead;
  final String? actionUrl;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.actionUrl,
  });

  String get timeAgo {
    final difference = DateTime.now().difference(timestamp);
    
    if (difference.inDays > 7) {
      return '${difference.inDays ~/ 7} minggu yang lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  static List<NotificationItem> getSampleNotifications() {
    final now = DateTime.now();
    
    return [
      NotificationItem(
        id: '1',
        title: 'Maintenance Pra UAS Semester Genap 2024/2025',
        message: 'Diinformasikan kepada seluruh pengguna LMS, kami dari tim CeLOE akan melakukan maintenance pada tanggal 12 Juni 2025, untuk meningkatkan layanan server.',
        type: 'announcement',
        timestamp: now.subtract(const Duration(hours: 3, minutes: 30)),
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        title: 'Tugas Terkirim: Laporan Akhir Assessment 3',
        message: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar) pada mata kuliah Desain Antarmuka.',
        type: 'assignment',
        timestamp: now.subtract(const Duration(hours: 81)), // ~3 hari 9 jam
        isRead: false,
      ),
      NotificationItem(
        id: '3',
        title: 'Tugas 01 - UID Android Mobile Game',
        message: 'Mata kuliah DESAIN ANTARMUKA & PENGALAMAN PENGGUNA. Segera cek detail tugas dan tenggat waktunya.',
        type: 'assignment',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        title: 'PENGUMUMAN: Maintenance LMS',
        message: 'Situs LMS tidak dapat diakses mulai pukul 00.00 s/d 06.00 WIB dikarenakan pemeliharaan sistem rutin.',
        type: 'announcement',
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        title: 'Selamat Datang di Smart UIM!',
        message: 'Halo Dandy Candra Pratama, selamat bergabung di Learning Management System Universitas Islam Madura.',
        type: 'system',
        timestamp: now.subtract(const Duration(days: 5)),
        isRead: true,
      ),
    ];
  }
}
