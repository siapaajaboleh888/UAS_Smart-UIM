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
          CourseContent(id: 'm4', title: 'Layouting & Basic Widgets', info: '2 Video, 4 Latihan Code', isCompleted: true, type: ContentType.material, week: 4),
          CourseContent(id: 'm5', title: 'Navigation & Routing', info: '1 Video, 2 Latihan Code', isCompleted: true, type: ContentType.material, week: 5),
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
            description: 'Konsep dasar User Interface Design menjadi dasar dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk dipelajari bersama-sama dengan pengguna, lalu dipelajari juga poin-poin penting pada interaction design seperti: visibility, feedback, limitation, consistency, dan affordance. Dan terakhir materi conceptual dan perceptual design Interaction akan memberikan gambaran bagaimana bentuk dari Interaction.',
            isCompleted: true,
            type: ContentType.material,
            week: 2,
            subItems: [
              MeetingSubItem(title: 'Zoom Meeting Synchronous', icon: Icons.link, isCompleted: true),
              MeetingSubItem(title: 'Prinsip Perancangan Antarmuka Pengguna', icon: Icons.description, isCompleted: true),
              MeetingSubItem(title: 'UID Guidelines and Principles', icon: Icons.description, isCompleted: true),
              MeetingSubItem(title: 'User Profile', icon: Icons.person_outline, isCompleted: true),
              MeetingSubItem(title: 'Principles of User Interface Design UI', icon: Icons.link, isCompleted: true),
            ],
            relatedTasks: [
              CourseContent(
                id: 't_q1',
                title: 'Quiz Review UI',
                info: 'KUIS',
                description: 'Silahkan kerjakan kuis ini sebelum kelas berakhir. kuis ini masuk sebagai nilai performa komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.',
                deadline: 'Minggu, 20 Maret 2022 jam 23:59 WIB',
                isCompleted: true,
                type: ContentType.task,
                week: 2,
              ),
              CourseContent(
                id: 't_a1',
                title: 'Tugas 01 - UID Android Mobile Game',
                info: 'TUGAS',
                description: '1. Buatlah desain template (wireframe) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan. 2. Desain yang dibuat harus meliputi seluruh tampilan pada aplikasi game, dari pertama kali aplikasi dibuka.',
                deadline: 'Senin, 21 Maret 2022 jam 23:59 WIB',
                isCompleted: false,
                type: ContentType.task,
                week: 2,
              ),
            ],
          ),
          CourseContent(
            id: 'm3',
            title: 'Interaksi pada User Interface Design',
            info: '3 URLs, 2 files, 3 Interactive Content',
            description: 'Mempelajari bagaimana merancang interaksi yang intuitif antara pengguna dan sistem.',
            isCompleted: true,
            type: ContentType.material,
            week: 3,
            subItems: [
              MeetingSubItem(title: 'Teori Interaksi', icon: Icons.description, isCompleted: true),
              MeetingSubItem(title: 'Latihan Prototyping', icon: Icons.touch_app, isCompleted: true),
            ],
          ),
          CourseContent(
            id: 'm4',
            title: 'Ethnographic Observation',
            info: '3 URLs, 2 files, 3 Interactive Content',
            description: 'Menggunakan teknik observasi etnografi untuk memahami kebutuhan pengguna dalam lingkungan alami mereka.',
            isCompleted: true,
            type: ContentType.material,
            week: 4,
            subItems: [
              MeetingSubItem(title: 'Panduan Observasi', icon: Icons.visibility, isCompleted: true),
              MeetingSubItem(title: 'Studi Kasus Etnografi', icon: Icons.article, isCompleted: true),
            ],
          ),
          CourseContent(
            id: 'm5',
            title: 'UID Testing',
            info: '3 URLs, 2 files, 3 Interactive Content',
            description: 'Melakukan pengujian antarmuka pengguna untuk memvalidasi desain dan meningkatkan pengalaman pengguna.',
            isCompleted: true,
            type: ContentType.material,
            week: 5,
            subItems: [
              MeetingSubItem(title: 'Metodologi Testing', icon: Icons.checklist_rtl, isCompleted: true),
              MeetingSubItem(title: 'Analisis Hasil Testing', icon: Icons.analytics, isCompleted: true),
            ],
          ),
          CourseContent(
            id: 'm6',
            title: 'Assessment 1',
            info: '3 URLs, 2 files, 3 Interactive Content',
            description: 'Evaluasi pertama untuk mengukur pemahaman mahasiswa terhadap materi yang telah diajarkan.',
            isCompleted: true,
            type: ContentType.material,
            week: 6,
            subItems: [
              MeetingSubItem(title: 'Review Materi 1-5', icon: Icons.menu_book, isCompleted: true),
              MeetingSubItem(title: 'Quiz Persiapan', icon: Icons.quiz, isCompleted: true),
            ],
          ),
        ],
        tasks: [
          CourseContent(id: 't1', title: 'Quiz Review 01', info: 'KUIS', deadline: '25 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 1),
          CourseContent(id: 't2', title: 'Tugas 01 - UID Android Mobile Game', info: 'TUGAS', deadline: '28 Desember 2025 23:59 WIB', isCompleted: false, type: ContentType.task, week: 2),
          CourseContent(id: 't3', title: 'Kuis - Assessment 1', info: 'Pertemuan 6', deadline: '30 Desember 2025 23:59 WIB', isCompleted: true, type: ContentType.task, week: 6),
          CourseContent(id: 't4', title: 'Tugas Observasi Etnografi', info: 'TUGAS', deadline: '10 Januari 2026 23:59 WIB', isCompleted: false, type: ContentType.task, week: 4),
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

