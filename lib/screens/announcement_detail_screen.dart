import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/notification_item.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final NotificationItem notification;

  const AnnouncementDetailScreen({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Pengumuman',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'By Admin CeLOE',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.circle,
                        size: 4,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        notification.timeAgo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Image Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: AppColors.primary.withOpacity(0.05),
                        child: Center(
                          child: Icon(
                            Icons.settings_suggest_outlined,
                            size: 80,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      color: AppColors.primary,
                      child: const Text(
                        'MAINTENANCE LMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Message Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Maintenance LMS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _formatMessage(notification.message),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Hormat Kami,\nCeLOE Smart UIM',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'KEMBALI KE NOTIFIKASI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  String _formatMessage(String message) {
    if (notification.title.contains('Maintenance')) {
      return 'Diinformasikan kepada seluruh pengguna LMS, kami dari tim CeLOE akan melakukan maintenance untuk meningkatkan layanan server dalam menghadapi ujian akhir semester (UAS).\n\n'
          'Dengan adanya kegiatan maintenance tersebut, maka situs LMS (smart-uim.ac.id) tidak dapat diakses sementara waktu.\n\n'
          'Demikian informasi ini kami sampaikan, mohon maaf atas ketidaknyamanannya.';
    }
    return message;
  }
}
