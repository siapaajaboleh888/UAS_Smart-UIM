import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserModel {
  final String nim;
  final String nama;
  final String email;
  final String phone;
  final String prodi;
  final String angkatan;
  final String role;
  final String passwordHash; // Store hashed password

  UserModel({
    required this.nim,
    required this.nama,
    required this.email,
    required this.phone,
    required this.prodi,
    required this.angkatan,
    this.role = 'MAHASISWA',
    this.passwordHash = '',
  });

  // Hash password using SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Create user with password
  factory UserModel.withPassword({
    required String nim,
    required String nama,
    required String email,
    required String phone,
    required String prodi,
    required String angkatan,
    required String password,
    String role = 'MAHASISWA',
  }) {
    return UserModel(
      nim: nim,
      nama: nama,
      email: email,
      phone: phone,
      prodi: prodi,
      angkatan: angkatan,
      role: role,
      passwordHash: hashPassword(password),
    );
  }

  // Verify password
  bool verifyPassword(String password) {
    return passwordHash == hashPassword(password);
  }

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
      'passwordHash': passwordHash,
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
      passwordHash: map['passwordHash'] ?? '',
    );
  }
}
