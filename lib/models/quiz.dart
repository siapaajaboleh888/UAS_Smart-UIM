class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  int? selectedAnswerIndex;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    this.selectedAnswerIndex,
  });
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final Duration duration;
  final int totalMarks;
  final List<Question> questions;
  final DateTime deadline;
  final String method; // e.g., "Penilaian Nilai Tertinggi"

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.totalMarks,
    required this.questions,
    required this.deadline,
    this.method = 'Penilaian Nilai Tertinggi',
  });

  static List<Quiz> getSampleQuizzes() {
    return [
      Quiz(
        id: 'q1',
        title: 'Quiz Review 1',
        description: 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis.\n\nJangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.\n\nKerjakan sebelum hari Jum\'at, 25 Desember 2025 jam 23:59 WIB.',
        duration: const Duration(minutes: 15),
        totalMarks: 100,
        deadline: DateTime(2025, 12, 25, 23, 59),
        questions: [
          Question(
            id: '1',
            text: 'Radio button dapat digunakan untuk menentukan?',
            options: ['Jenis Kelamin', 'Alamat', 'Hobby', 'Riwayat Pendidikan', 'Umur'],
            correctAnswerIndex: 0,
          ),
          Question(
            id: '2',
            text: 'Dalam perancangan ui yang baik, untuk kela yang menyerupai tampilan konten yang ditunjukkan yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu?',
            options: ['Konsistensi', 'Responsif', 'Estetika', 'Kemudahan', 'Kecepatan'],
            correctAnswerIndex: 0,
          ),
          // Add more sample questions...
        ],
      ),
    ];
  }
}
