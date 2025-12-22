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
          Question(
            id: '3',
            text: 'Apa yang dimaksud dengan User Experience (UX)?',
            options: ['Keindahan tampilan visual', 'Pengalaman pengguna saat berinteraksi dengan produk', 'Kecepatan loading website', 'Jumlah fitur yang ada di aplikasi', 'Keamanan data pengguna'],
            correctAnswerIndex: 1,
          ),
          Question(
            id: '4',
            text: 'Warna manakah yang biasanya melambangkan keberhasilan atau konfirmasi positif dalam UI?',
            options: ['Merah', 'Kuning', 'Hijau', 'Biru', 'Hitam'],
            correctAnswerIndex: 2,
          ),
          Question(
            id: '5',
            text: 'Manakah dari berikut ini yang merupakan prinsip "Affordance" dalam desain?',
            options: ['Memberikan instruksi teks yang panjang', 'Karakteristik visual benda yang memberi petunjuk cara penggunaannya', 'Menggunakan gambar beresolusi tinggi', 'Menaruh banyak tombol di layar', 'Menggunakan font yang unik'],
            correctAnswerIndex: 1,
          ),
          Question(
            id: '6',
            text: 'Komponen UI yang digunakan untuk memilih satu atau lebih pilihan dari daftar disebut?',
            options: ['Radio Button', 'Text Field', 'Checkbox', 'Toggle Switch', 'Slider'],
            correctAnswerIndex: 2,
          ),
          Question(
            id: '7',
            text: 'Apa tujuan utama dari pembuatan Wireframe?',
            options: ['Menentukan warna akhir desain', 'Memilih font yang akan digunakan', 'Merancang struktur dan tata letak dasar', 'Membuat animasi transisi', 'Menulis kode program'],
            correctAnswerIndex: 2,
          ),
          Question(
            id: '8',
            text: 'Dalam hukum Fitts, waktu yang dibutuhkan untuk mencapai target bergantung pada?',
            options: ['Warna target', 'Jarak dan ukuran target', 'Kontras target', 'Jenis perangkat input', 'Tingkat kecerahan layar'],
            correctAnswerIndex: 1,
          ),
          Question(
            id: '9',
            text: 'Apa singkatan dari RGB?',
            options: ['Red Green Blue', 'Red Grey Black', 'Real Green Blue', 'Random Grey Blue', 'Red gold Blue'],
            correctAnswerIndex: 0,
          ),
          Question(
            id: '10',
            text: 'Istilah untuk navigasi yang menunjukkan lokasi pengguna dalam hierarki aplikasi adalah?',
            options: ['Side Bar', 'Tab Bar', 'Breadcrumbs', 'Navigation Drawer', 'Bottom Nav'],
            correctAnswerIndex: 2,
          ),
          Question(
            id: '11',
            text: 'Fokus utama dari "Interaction Design" adalah?',
            options: ['Membuat logo perusahaan', 'Mendesain hubungan antara orang dan produk yang mereka gunakan', 'Menentukan harga produk', 'Membangun database server', 'Memasarkan produk ke media sosial'],
            correctAnswerIndex: 1,
          ),
          Question(
            id: '12',
            text: 'White space dalam desain UI berguna untuk?',
            options: ['Menambah ukuran file gambar', 'Menghilangkan informasi penting', 'Membantu fokus pengguna dan menghindari kekacauan visual', 'Menurunkan kualitas desain', 'Menghemat penggunaan warna'],
            correctAnswerIndex: 2,
          ),
          Question(
            id: '13',
            text: 'Manakah yang bukan merupakan elemen dari UI Design?',
            options: ['Tipografi', 'Ikonografi', 'Backend Database', 'Palet Warna', 'Layout'],
            correctAnswerIndex: 2,
          ),
          Question(
            id: '14',
            text: 'Apa itu "Information Architecture"?',
            options: ['Cara data disimpan di server', 'Struktural organisasi informasi dalam aplikasi', 'Bahasa pemrograman yang digunakan', 'Sistem keamanan jaringan', 'Kecepatan transfer data'],
            correctAnswerIndex: 1,
          ),
          Question(
            id: '15',
            text: 'Prinsip desain yang menekankan pada elemen yang paling penting agar menonjol disebut?',
            options: ['Keseimbangan', 'Hierarki Visual', 'Kontras', 'Repetisi', 'Proporsi'],
            correctAnswerIndex: 1,
          ),
        ],
      ),
    ];
  }
}
