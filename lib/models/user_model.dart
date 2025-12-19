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
  final String? photoPath; // Path to profile photo

  UserModel({
    required this.nim,
    required this.nama,
    required this.email,
    required this.phone,
    required this.prodi,
    required this.angkatan,
    this.role = 'MAHASISWA',
    this.passwordHash = '',
    this.photoPath,
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
    String? photoPath,
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
      photoPath: photoPath,
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
      'photoPath': photoPath,
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
      photoPath: map['photoPath'],
    );
  }

  UserModel copyWith({
    String? nim,
    String? nama,
    String? email,
    String? phone,
    String? prodi,
    String? angkatan,
    String? role,
    String? passwordHash,
    String? photoPath,
  }) {
    return UserModel(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      prodi: prodi ?? this.prodi,
      angkatan: angkatan ?? this.angkatan,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}
