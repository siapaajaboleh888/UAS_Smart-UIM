import 'package:flutter/material.dart';

class MeetingSubItem {
  final String title;
  final bool isCompleted;
  final IconData icon;

  MeetingSubItem({
    required this.title,
    this.isCompleted = false,
    required this.icon,
  });
}

class CourseContent {
  final String id;
  final String title;
  final String info; // e.g., "3 URLs, 2 files, 2 interaction content"
  final String description;
  final bool isCompleted;
  final ContentType type;
  final int week;
  final String deadline;
  final List<MeetingSubItem> subItems;
  final List<CourseContent> relatedTasks;

  CourseContent({
    required this.id,
    required this.title,
    required this.info,
    this.description = '',
    this.isCompleted = false,
    required this.type,
    required this.week,
    this.deadline = '',
    this.subItems = const [],
    this.relatedTasks = const [],
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
          CourseContent(
            id: 'm1',
            title: 'Pengantar Pemrograman Mobile',
            info: '2 Video, 1 PDF, 1 Artikel',
            description: 'Materi ini membahas dasar-dasar pengembangan aplikasi mobile menggunakan Flutter dan Dart.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Zoom Meeting Synchronous', icon: Icons.videocam, isCompleted: true),
              MeetingSubItem(title: 'Pengantar Pemrograman Mobile', icon: Icons.description, isCompleted: true),
              MeetingSubItem(title: 'Dasar-dasar Flutter', icon: Icons.code, isCompleted: true),
              MeetingSubItem(title: 'Instalasi Lingkungan Kerja', icon: Icons.settings, isCompleted: true),
            ],
            relatedTasks: [
              CourseContent(id: 't1_m1', title: 'Quiz Review 01', info: 'KUIS', deadline: '25 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
            ],
          ),
          CourseContent(id: 'm2', title: 'Instalasi Flutter & Dart SDK', info: '1 Video, 2 Panduan Instalasi', isCompleted: true, type: ContentType.material, week: 2),
          CourseContent(id: 'm3', title: 'Stateless vs Stateful Widget', info: '1 Video, 3 Latihan Code', isCompleted: true, type: ContentType.material, week: 3),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Quiz Review 01', info: 'KUIS', deadline: '25 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
          CourseContent(id: 't2', title: 'Tugas 01 - Instalasi SDK', info: 'TUGAS', deadline: '28 Desember 2025 23:59 WIB', isCompleted: false, type: ContentType.task, week: 2),
          CourseContent(id: 't3', title: 'Kuis - Assessment 2', info: 'Pertemuan 3', deadline: '30 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 3),
        ],
      ),
      '2': CourseDetailData(
        materials: [
          CourseContent(
            id: 'm1',
            title: 'Pengantar User Interface Design',
            info: '3 URLs, 2 files, 2 interaction content',
            description: 'Interface yang dibangun murni mempertahankan prinsip-prinsip desain yang ada. Hal ini diterapkan agar interaksi yang terbangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip-prinsip desain diharapkan akan mendukung pengguna dalam menggunakan aplikasi secara baik. Pelajaran mengenai prinsip UID ini sudah pernah dipelajari dalam mata kuliah Implementasi Desain Antarmuka Pengguna tetap pada matakuliah ini akan direview kembali sehingga dapat menjadi bekal saat memulai mempelajari mengenai User Experience.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Zoom Meeting synchronous', icon: Icons.link, isCompleted: false),
              MeetingSubItem(title: 'Pengantar User Interface Design', icon: Icons.description, isCompleted: true),
              MeetingSubItem(title: 'Empat Teori Dasar Antarmuka Pengguna', icon: Icons.article, isCompleted: true),
              MeetingSubItem(title: 'Empat Teori Dasar Antarmuka Pengguna', icon: Icons.article, isCompleted: true),
              MeetingSubItem(title: 'User Interface Design for Beginner', icon: Icons.play_circle_fill, isCompleted: true),
              MeetingSubItem(title: '10 Prinsip Desain', icon: Icons.lightbulb, isCompleted: true),
              MeetingSubItem(title: 'Best Practice UI Design', icon: Icons.check_circle_outline, isCompleted: true),
            ],
            relatedTasks: [
              CourseContent(id: 't1_m1', title: 'Quiz Dasar UI', info: 'KUIS', deadline: '15 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
            ],
          ),
          CourseContent(
            id: 'm2',
            title: 'Konsep User Interface Design',
            info: '2 URLs, 1 file, 1 Tugas',
            description: 'Membahas konsep-konsep mendalam dalam perancangan antarmuka pengguna.',
            isCompleted: true,
            type: ContentType.material,
            week: 2,
            subItems: [
              MeetingSubItem(title: 'Materi Konsep UI', icon: Icons.description, isCompleted: true),
              MeetingSubItem(title: 'Video Tutorial Design', icon: Icons.play_circle, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Quiz Review 01', info: 'KUIS', deadline: '25 Februari 2021 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
          CourseContent(id: 't2', title: 'Tugas 01 - UID Android Mobile Game', info: 'TUGAS', deadline: '28 Februari 2021 23:59 WIB', isCompleted: false, type: ContentType.task, week: 2),
          CourseContent(id: 't3', title: 'Kuis - Assessment 2', info: 'Pertemuan 3', deadline: '25 Februari 2021 23:59 WIB', isCompleted: true, type: ContentType.task, week: 3),
        ],
      ),
      '3': CourseDetailData(
        materials: [
          CourseContent(
            id: 'm1',
            title: 'Pengenalan DBMS',
            info: '1 Video, 2 PDF',
            description: 'Pengenalan tentang Database Management System dan peranannya dalam aplikasi.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Apa itu DBMS?', icon: Icons.help_outline, isCompleted: true),
              MeetingSubItem(title: 'Instalasi MySQL', icon: Icons.terminal, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Quiz Basis Data 1', info: 'KUIS', deadline: '20 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
        ],
      ),
      '4': CourseDetailData(
        materials: [
          CourseContent(
            id: 'm1',
            title: 'Dasar Jaringan Komputer',
            info: '1 Video, 1 Materi PDF',
            description: 'Mempelajari konsep dasar jaringan, topologi, dan model OSI.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Pengenalan Jaringan', icon: Icons.network_check, isCompleted: true),
              MeetingSubItem(title: 'Topologi Jaringan', icon: Icons.hub, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Latihan Topologi', info: 'TUGAS', deadline: '22 Desember 2025 23:59 WIB', isCompleted: false, type: ContentType.task, week: 1),
        ],
      ),
      '5': CourseDetailData(
        materials: [
          CourseContent(
            id: 'm1',
            title: 'Pengenalan Algoritma',
            info: '1 Video, 2 Latihan Mandiri',
            description: 'Membahas definisi algoritma dan cara penyelesaian masalah secara sistematis.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Flowchart Dasar', icon: Icons.account_tree, isCompleted: true),
              MeetingSubItem(title: 'Pseudocode', icon: Icons.data_array, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Kuis Logika Dasar', info: 'KUIS', deadline: '24 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
        ],
      ),
      '6': CourseDetailData(
        materials: [
          CourseContent(
            id: 'm1',
            title: 'SDLC (Software Development Life Cycle)',
            info: '1 Video, 1 Artikel',
            description: 'Mengenal siklus hidup pengembangan perangkat lunak.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Model Waterfall', icon: Icons.waterfall_chart, isCompleted: true),
              MeetingSubItem(title: 'Agile Methodology', icon: Icons.speed, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Tugas Analisis SDLC', info: 'TUGAS', deadline: '26 Desember 2025 23:59 WIB', isCompleted: false, type: ContentType.task, week: 1),
        ],
      ),
      '7': CourseDetailData(
        materials: [
          CourseContent(
            id: 'm1',
            title: 'Pengenalan AI',
            info: '1 Video, 1 PDF',
            description: 'Sejarah dan perkembangan Kecerdasan Buatan.',
            isCompleted: true,
            type: ContentType.material,
            week: 1,
            subItems: [
              MeetingSubItem(title: 'Turing Test', icon: Icons.psychology, isCompleted: true),
              MeetingSubItem(title: 'Machine Learning Basics', icon: Icons.smart_toy, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Kuis AI Modern', info: 'KUIS', deadline: '28 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
        ],
      ),
    };
  }


}

