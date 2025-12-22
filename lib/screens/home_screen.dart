import 'package:flutter/material.dart';
import 'dart:convert';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import '../models/course.dart';
import '../models/announcement.dart';
import '../models/assignment.dart';
import 'course_detail_screen.dart';
import 'profile_screen.dart';
import 'courses_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onProfileClick;
  const HomeScreen({super.key, this.onProfileClick});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    final UserModel? currentUser = userService.currentUser;
    final String userName = (currentUser?.nama ?? 'GUEST USER').toUpperCase();
    final String userInitials = currentUser?.getInitials() ?? 'GU';

    final List<Course> courses = Course.getSampleCourses();
    final List<Announcement> announcements = Announcement.getSampleAnnouncements();
    final List<Assignment> assignments = Assignment.getSampleAssignments();
    
    // Find an upcoming assignment (for demo, just take the first one or a mock one)
    final upcomingAssignment = assignments.isNotEmpty ? assignments[0] : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(context, userName, userInitials, currentUser),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upcoming Task Section
                  _buildSectionTitle('Tugas Yang Akan Datang'),
                  const SizedBox(height: 12),
                  _buildUpcomingTaskCard(upcomingAssignment),

                  const SizedBox(height: 24),

                  // Announcements Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle('Pengumuman Terakhir'),
                      TextButton(
                        onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationScreen()),
                          );
                        },
                        child: const Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildAnnouncementsList(announcements),

                  const SizedBox(height: 24),

                  // Class Progress Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle('Progres Kelas'),
                      TextButton(
                        onPressed: () {
                          // Navigate to CoursesScreen via MainScreen index 1 if possible
                          // For now just push
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CoursesScreen()),
                          );
                        },
                        child: const Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildCourseProgressList(courses),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String userName, String userInitials, UserModel? user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello,',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.onProfileClick != null) {
                widget.onProfileClick!();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: user?.photoPath != null && user!.photoPath!.isNotEmpty
                          ? (user.photoPath!.startsWith('http')
                              ? Image.network(
                                  user.photoPath!,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => _buildInitialsAvatarSmall(userInitials),
                                )
                              : (user.photoPath!.startsWith('data:')
                                  ? Image.memory(
                                      base64Decode(user.photoPath!.split(',')[1]),
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => _buildInitialsAvatarSmall(userInitials),
                                    )
                                  : Image.asset(
                                      user.photoPath!,
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => _buildInitialsAvatarSmall(userInitials),
                                    )))
                          : _buildInitialsAvatarSmall(userInitials),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
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

  Widget _buildUpcomingTaskCard(Assignment? assignment) {
    if (assignment == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
         // Find the course matching the assignment's course code or just pick one for demo
         final courses = Course.getSampleCourses();
         final course = courses.firstWhere((c) => c.code.contains(assignment.courseCode), orElse: () => courses[1]);
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.assignment_ind, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              assignment.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Waktu Pengumpulan',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Jumat, 20 Desember, 23:59 WIB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return GestureDetector(
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mock Image for Announcement
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: AppColors.primary.withOpacity(0.1),
                      child: Center(
                        child: Icon(Icons.campaign, color: AppColors.primary.withOpacity(0.3), size: 48),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          announcement.content,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseProgressList(List<Course> courses) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.take(4).length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: course.imageUrl != null 
                      ? (course.imageUrl!.startsWith('http') 
                          ? Image.network(course.imageUrl!, width: 40, errorBuilder: (_, __, ___) => const Icon(Icons.book, color: AppColors.primary))
                          : Image.asset(course.imageUrl!, width: 40, errorBuilder: (_, __, ___) => const Icon(Icons.book, color: AppColors.primary)))
                      : const Icon(Icons.book, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.semester,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: course.progress / 100,
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${course.progress}% Selesai',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInitialsAvatarSmall(String initials) {
    return Center(
      child: Text(
        initials,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
