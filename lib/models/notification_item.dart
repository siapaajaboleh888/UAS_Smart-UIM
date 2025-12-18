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
      // Tugas baru
      NotificationItem(
        id: '1',
        title: 'Tugas Baru: UAS Pemrograman Mobile',
        message: 'Dosen telah memberikan tugas baru dengan deadline 20 Desember 2025. Jangan lupa selesaikan tepat waktu!',
        type: 'assignment',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      
      // Pengumuman
      NotificationItem(
        id: '2',
        title: 'Pengumuman: Perubahan Jadwal Kuliah',
        message: 'Kuliah Basis Data hari Rabu dipindahkan ke hari Kamis jam 10:00. Harap catat perubahan ini.',
        type: 'announcement',
        timestamp: now.subtract(const Duration(hours: 5)),
        isRead: false,
      ),
      
      // Deadline reminder
      NotificationItem(
        id: '3',
        title: 'Reminder: Tugas Akan Segera Berakhir',
        message: 'Tugas Normalisasi Database akan berakhir dalam 2 hari. Segera submit!',
        type: 'assignment',
        timestamp: now.subtract(const Duration(hours: 8)),
        isRead: true,
      ),
      
      // Nilai tugas
      NotificationItem(
        id: '4',
        title: 'Nilai Tugas 2 Sudah Keluar',
        message: 'Nilai untuk tugas Laravel CRUD sudah tersedia. Anda mendapat nilai: 85/100. Bagus!',
        type: 'course',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
      ),
      
      // Materi baru
      NotificationItem(
        id: '5',
        title: 'Materi Baru: Flutter State Management',
        message: 'Dosen telah mengunggah materi baru tentang Provider dan Riverpod. Silakan dipelajari.',
        type: 'course',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        isRead: true,
      ),
      
      // System notification
      NotificationItem(
        id: '6',
        title: 'Selamat Datang di Smart UIM!',
        message: 'Terima kasih telah bergabung dengan Learning Management System Universitas Islam Madura.',
        type: 'system',
        timestamp: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
      
      // Quiz notification
      NotificationItem(
        id: '7',
        title: 'Quiz: Algoritma Sorting Tersedia',
        message: 'Quiz 1 untuk mata kuliah Algoritma sudah dapat dikerjakan. Waktu pengerjaan: 60 menit.',
        type: 'assignment',
        timestamp: now.subtract(const Duration(days: 4)),
        isRead: true,
      ),
      
      // Course update
      NotificationItem(
        id: '8',
        title: 'Update: Jadwal Office Hours',
        message: 'Pak Dosen akan mengadakan sesi tanya jawab online setiap Jumat pukul 14:00 via Zoom.',
        type: 'announcement',
        timestamp: now.subtract(const Duration(days: 5)),
        isRead: true,
      ),
    ];
  }
}
