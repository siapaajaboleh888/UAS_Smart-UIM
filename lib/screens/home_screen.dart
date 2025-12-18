import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import '../models/course.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500, // Optimize size for local storage
        imageQuality: 70,
      );
      
      if (image != null) {
        final userService = UserService();
        debugPrint('📸 Image picked: ${image.name}');
        
        String photoToSave = image.path;
        
        if (kIsWeb) {
          debugPrint('🌐 Processing for Web...');
          final bytes = await image.readAsBytes();
          photoToSave = 'data:image/png;base64,${base64Encode(bytes)}';
          debugPrint('✅ Converted to Base64 (length: ${photoToSave.length})');
        }
        
        await userService.updateUserPhoto(photoToSave);
        if (mounted) setState(() {}); 
      }
    } catch (e) {
      debugPrint('❌ Error picking image: $e');
    }
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
    final String? userPhoto = currentUser?.photoPath;

    // Profile photo logic
    ImageProvider? profileImage;
    if (userPhoto != null && userPhoto.isNotEmpty) {
      if (userPhoto.startsWith('data:')) {
        try {
          profileImage = MemoryImage(base64Decode(userPhoto.split(',')[1]));
        } catch (e) {
          debugPrint('❌ Error decoding Base64 image: $e');
        }
      } else if (kIsWeb) {
        // Only use NetworkImage if it's not a temporary blob
        if (!userPhoto.startsWith('blob:')) {
          profileImage = NetworkImage(userPhoto);
        }
      } else {
        final file = File(userPhoto);
        if (file.existsSync()) {
          profileImage = FileImage(file);
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header with profile photo
          SizedBox(
            height: 275,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Top bar with Back Button and Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.maybePop(context),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        
                        // Profile photo
                        GestureDetector(
                          onTap: _pickImage,
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.primary.withOpacity(0.1),
                                  backgroundImage: profileImage,
                                  child: profileImage == null
                                      ? Text(
                                          userInitials,
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // User name
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Floating Tab Bar
                Positioned(
                  bottom: 0,
                  left: 24,
                  right: 24,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: TabBar(
                        controller: _tabController,
                        indicator: UnderlineTabIndicator(
                          borderSide: const BorderSide(width: 3.0, color: AppColors.primary),
                          insets: const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
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
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 10),
          
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
                
                // Tasks/Kelas Tab
                _buildTasksTab(context),
                
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
    final loginTime = DateFormat('EEEE, d MMMM yyyy, h:mm a').format(now);
    final firstAccess = DateFormat('EEEE, d MMMM yyyy, h:mm a').format(
      DateTime.now().subtract(const Duration(days: 102)), // Example data from ref
    );
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informasi User
          _buildSectionTitle('Informasi User'),
          const SizedBox(height: 12),
          _buildInfoItem('Email address', userEmail),
          _buildInfoItem('Program Studi', userProdi),
          _buildInfoItem('Fakultas', 'Informatika'), // Default or mock
          
          const SizedBox(height: 24),
          
          // Aktivitas Login
          _buildSectionTitle('Aktivitas Login'),
          const SizedBox(height: 12),
          _buildInfoItem('First access to site', firstAccess),
          _buildInfoItem('Last access to site', '$loginTime (now)'),
          
          const SizedBox(height: 32),
          
          // Small Logout Button at the bottom right
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => _showLogoutDialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  
  Widget _buildTasksTab(BuildContext context) {
    // Get sample courses from model
    final List<Course> courses = Course.getSampleCourses().take(3).toList(); // Show first 3 for profile
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Daftar Kelas'),
          const SizedBox(height: 16),
          
          ...courses.map((course) => _buildMiniCourseCard(context, course)),
          
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                // Potential navigation to full courses screen if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gunakan menu "Kelas Saya" di bawah untuk melihat semua kelas.')),
                );
              },
              child: const Text('Lihat Selengkapnya'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCourseCard(BuildContext context, Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textLight.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              image: course.imageUrl != null
                  ? DecorationImage(
                      image: course.imageUrl!.startsWith('http')
                          ? NetworkImage(course.imageUrl!) as ImageProvider
                          : AssetImage(course.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: course.imageUrl == null
                ? const Icon(Icons.book, color: AppColors.primary, size: 20)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  course.instructor,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
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
    final userService = UserService();
    final user = userService.currentUser;
    final nameController = TextEditingController(text: user?.nama);
    final phoneController = TextEditingController(text: user?.phone);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Data Personal'),
          const SizedBox(height: 16),
          
          _buildTextField('Nama Lengkap', nameController, Icons.person_outline),
          const SizedBox(height: 16),
          _buildTextField('Nomor Telepon', phoneController, Icons.phone_android_outlined),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Keamanan'),
          const SizedBox(height: 16),
          
          _buildEditItem('Ganti Password', Icons.lock_outline, () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Ganti Password segera hadir!')),
            );
          }),
          
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profil berhasil diperbarui secara lokal!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textLight.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textLight.withOpacity(0.2)),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
      ],
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
