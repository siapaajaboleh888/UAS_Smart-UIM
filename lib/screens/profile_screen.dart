import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import '../models/course.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ProfileScreen({super.key, this.onBack});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedImagePath;
  final ImagePicker _picker = ImagePicker();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current user from UserService
    final userService = UserService();
    final UserModel? currentUser = userService.currentUser;

    // User data
    final String userName = currentUser?.nama.toUpperCase() ?? 'GUEST USER';
    final String userInitials = currentUser?.getInitials() ?? 'GU';
    final String userEmail = currentUser?.email ?? '-';
    final String userNim = currentUser?.nim ?? '-';
    final String userProdi = currentUser?.prodi ?? '-';
    final String userAngkatan = currentUser?.angkatan ?? '-';
    final String userPhone = currentUser?.phone ?? '-';
    
    return Scaffold(
      body: Column(
        children: [
          // Header with profile photo
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Back button and title
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            if (widget.onBack != null) {
                              widget.onBack!();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  
                  // Profile photo with edit button
                  Stack(
                    children: [
                      // Profile photo
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: _buildProfileImage(
                              currentUser?.photoPath ?? _selectedImagePath,
                              userInitials,
                            ),
                          ),
                        ),
                      ),
                      // Edit button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.primary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // User name
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Tab bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.white,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: 'About Me'),
                        Tab(text: 'Kelas'),
                        Tab(text: 'Edit Profile'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // About Me Tab
                _buildAboutMeTab(
                  userName: userName,
                  userEmail: userEmail,
                  userNim: userNim,
                  userProdi: userProdi,
                  userAngkatan: userAngkatan,
                  userPhone: userPhone,
                ),
                
                // Kelas/Courses Tab
                _buildCoursesTab(),
                
                // Edit Profile Tab
                _buildEditProfileTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAboutMeTab({
    required String userName,
    required String userEmail,
    required String userNim,
    required String userProdi,
    required String userAngkatan,
    required String userPhone,
  }) {
    final now = DateTime.now();
    // Simple date format without locale
    final loginTime = DateFormat('EEEE, dd MMM yyyy, h:mm a').format(now);
    final firstAccess = DateFormat('EEEE, dd MMM yyyy, h:mm a').format(
      DateTime.now().subtract(const Duration(days: 3)),
    );
    
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informasi User
          _buildSectionTitle('Informasi User'),
          const SizedBox(height: 12),
          _buildInfoItem('Email address', userEmail),
          _buildInfoItem('Nomor Induk Mahasiswa', userNim),
          _buildInfoItem('Program Studi', userProdi),
          _buildInfoItem('Angkatan', userAngkatan),
          _buildInfoItem('Nomor Telepon', userPhone),
          
          const SizedBox(height: 24),
          
          // Jadwal Kuliah
          _buildSectionTitle('Jadwal Kuliah'),
          const SizedBox(height: 12),
          _buildInfoItem(
            'Hari Terjadwal Kuliah', 
            'Selasa, Rabu, Kamis (9:30 AM s/d 11:00 PM [3 Hari])',
          ),
          
          const SizedBox(height: 24),
          
          // Website
          _buildSectionTitle('Website'),
          const SizedBox(height: 12),
          _buildInfoItem('URL', 'uim.ac.id'),
          
          const SizedBox(height: 24),
          
          // Aktivitas Login
          _buildSectionTitle('Aktivitas Login'),
          const SizedBox(height: 12),
          _buildInfoItem('First access to site', firstAccess),
          _buildInfoItem('Last access to site', loginTime),
          
          const SizedBox(height: 24),
          
          // Logout Button - Refined Compact Style
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: AppColors.error.withOpacity(0.4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCoursesTab() {
    final courses = Course.getSampleCourses();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Daftar Kelas'),
          const SizedBox(height: 16),
          
          ...courses.map((course) => _buildCourseItem(course)),
        ],
      ),
    );
  }

  Widget _buildCourseItem(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.book, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  course.instructor,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${course.progress}%',
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEditProfileTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Edit Informasi'),
          const SizedBox(height: 16),
          
          _buildEditItem('Edit Nama', Icons.person_outline, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Edit Nama segera hadir!')),
            );
          }),
          
          _buildEditItem('Edit Email', Icons.email_outlined, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Edit Email segera hadir!')),
            );
          }),
          
          _buildEditItem('Edit Nomor Telepon', Icons.phone_outlined, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Edit Telepon segera hadir!')),
            );
          }),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Keamanan'),
          const SizedBox(height: 16),
          
          _buildEditItem('Ganti Password', Icons.lock_outline, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Ganti Password segera hadir!')),
            );
          }),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Preferensi'),
          const SizedBox(height: 16),
          
          _buildEditItem('Notifikasi', Icons.notifications_outlined, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Notifikasi segera hadir!')),
            );
          }),
          
          _buildEditItem('Bahasa', Icons.language_outlined, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Bahasa segera hadir!')),
            );
          }),
          
          _buildEditItem('Tema', Icons.palette_outlined, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Tema segera hadir!')),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
  
  Widget _buildInfoItem(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskCard(
    String courseName,
    String taskName,
    String deadline,
    IconData icon,
    bool isCompleted,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted 
              ? AppColors.success.withOpacity(0.3) 
              : AppColors.primary.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted 
                  ? AppColors.success.withOpacity(0.1) 
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isCompleted ? AppColors.success : AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  taskName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deadline,
                  style: TextStyle(
                    fontSize: 12,
                    color: isCompleted ? AppColors.success : AppColors.warning,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 24,
            ),
        ],
      ),
    );
  }
  
  Widget _buildEditItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textLight,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Pick image from gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (image != null) {
        final userService = UserService();
        
        String photoToSave = image.path;
        
        // Handle Web Base64 conversion
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          photoToSave = 'data:image/png;base64,${base64Encode(bytes)}';
        }
        
        final success = await userService.updateUserPhoto(photoToSave);
        
        if (success && mounted) {
          setState(() {
            _selectedImagePath = photoToSave;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto profil berhasil diperbarui!'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal memilih foto'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  // Build profile image widget
  Widget _buildProfileImage(String? imagePath, String initials) {
    if (imagePath != null && imagePath.isNotEmpty) {
      // Check if it's base64
      if (imagePath.startsWith('data:')) {
        try {
          return Image.memory(
            base64Decode(imagePath.split(',')[1]),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildInitialsAvatar(initials),
          );
        } catch (e) {
          return _buildInitialsAvatar(initials);
        }
      }
      
      // Check if it's a network URL
      if (imagePath.startsWith('http')) {
        return Image.network(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildInitialsAvatar(initials),
        );
      }
      
      // For legacy blob/file or network
      if (kIsWeb) {
        // On web, if it's not base64 or http, it might be a blob or asset path
        return Image.network(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildInitialsAvatar(initials);
          },
        );
      } else {
        // For mobile, use file image
        final file = File(imagePath);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildInitialsAvatar(initials);
            },
          );
        }
      }
    }
    
    // Default to initials
    return _buildInitialsAvatar(initials);
  }
  
  // Build initials avatar
  Widget _buildInitialsAvatar(String initials) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final userService = UserService();
              await userService.logout();
              
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
