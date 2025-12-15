class Course {
  final String id;
  final String name;
  final String code;
  final String instructor;
  final String semester;
  final int progress;
  final int totalStudents;
  final String? imageUrl;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.instructor,
    required this.semester,
    required this.progress,
    this.totalStudents = 30,
    this.imageUrl,
  });

  static List<Course> getSampleCourses() {
    return [
      Course(
        id: '1',
        name: 'PEMROGRAMAN MOBILE',
        code: 'TIF-2201 [RSA]',
        instructor: 'Rofi Uddin, S.Kom., M.Kom',
        semester: '2024/2025',
        progress: 92,
      ),
      Course(
        id: '2',
        name: 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
        code: 'TIF-2202 [MSA]',
        instructor: 'Moh. Syaiful Anam',
        semester: '2024/2025',
        progress: 88,
      ),
      Course(
        id: '3',
        name: 'SISTEM BASIS DATA',
        code: 'TIF-2203 [AHM]',
        instructor: 'Ahmad Mahfud',
        semester: '2024/2025',
        progress: 90,
      ),
      Course(
        id: '4',
        name: 'JARINGAN KOMPUTER',
        code: 'TIF-2204 [FZL]',
        instructor: 'Faisal',
        semester: '2024/2025',
        progress: 85,
      ),
      Course(
        id: '5',
        name: 'ALGORITMA DAN STRUKTUR DATA',
        code: 'TIF-2205 [NUR]',
        instructor: 'Nur Hidayah',
        semester: '2024/2025',
        progress: 91,
      ),
      Course(
        id: '6',
        name: 'REKAYASA PERANGKAT LUNAK',
        code: 'TIF-2206 [IKH]',
        instructor: 'Ikhwan',
        semester: '2024/2025',
        progress: 87,
      ),
      Course(
        id: '7',
        name: 'KECERDASAN BUATAN',
        code: 'TIF-2207 [ZIN]',
        instructor: 'Zainuddin',
        semester: '2024/2025',
        progress: 89,
      ),
    ];
  }
}
