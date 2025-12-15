class UserModel {
  final String nim;
  final String nama;
  final String email;
  final String phone;
  final String prodi;
  final String angkatan;
  final String role;

  UserModel({
    required this.nim,
    required this.nama,
    required this.email,
    required this.phone,
    required this.prodi,
    required this.angkatan,
    this.role = 'MAHASISWA',
  });

  // Get initials for avatar
  String getInitials() {
    List<String> nameParts = nama.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return nama.substring(0, 2).toUpperCase();
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'nim': nim,
      'nama': nama,
      'email': email,
      'phone': phone,
      'prodi': prodi,
      'angkatan': angkatan,
      'role': role,
    };
  }

  // Create from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nim: map['nim'] ?? '',
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      prodi: map['prodi'] ?? '',
      angkatan: map['angkatan'] ?? '',
      role: map['role'] ?? 'MAHASISWA',
    );
  }
}
