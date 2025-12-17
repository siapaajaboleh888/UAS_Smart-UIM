import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
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
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  
                  // Profile photo
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      userInitials,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
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
                        Tab(text: 'Tasks'),
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
                
                // Tasks Tab
                _buildTasksTab(),
                
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
    final loginTime = DateFormat('EEEE, dd MMM yyyy, h:mm a', 'id_ID').format(now);
    
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
          _buildInfoItem('First access to site', 'Minggu, 15 Des 2024, 8:45 AM'),
          _buildInfoItem('Last access to site', loginTime),
          
          const SizedBox(height: 32),
          
          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
  
  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Tugas Aktif'),
          const SizedBox(height: 16),
          
          _buildTaskCard(
            'Pemrograman Mobile',
            'UAS - Membuat Aplikasi LMS',
            'Deadline: 20 Des 2024',
            Icons.code,
            false,
          ),
          
          _buildTaskCard(
            'Basis Data',
            'Tugas 3 - Normalisasi Database',
            'Deadline: 18 Des 2024',
            Icons.storage,
            false,
          ),
          
          _buildTaskCard(
            'Jaringan Komputer',
            'Praktek - Konfigurasi Router',
            'Deadline: 22 Des 2024',
            Icons.router,
            false,
          ),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Tugas Selesai'),
          const SizedBox(height: 16),
          
          _buildTaskCard(
            'Pemrograman Web',
            'Tugas 2 - Laravel CRUD',
            'Selesai: 15 Des 2024',
            Icons.web,
            true,
          ),
          
          _buildTaskCard(
            'Algoritma',
            'Quiz 1 - Sorting Algorithm',
            'Selesai: 10 Des 2024',
            Icons.quiz,
            true,
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
