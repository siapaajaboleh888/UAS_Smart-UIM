import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/notification_item.dart';
import 'announcement_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = NotificationItem.getSampleNotifications();
  String selectedFilter = 'all'; // all, unread, read

  List<NotificationItem> get filteredNotifications {
    if (selectedFilter == 'unread') {
      return notifications.where((n) => !n.isRead).toList();
    } else if (selectedFilter == 'read') {
      return notifications.where((n) => n.isRead).toList();
    }
    return notifications;
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void _markAsRead(String id) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = NotificationItem(
          id: notifications[index].id,
          title: notifications[index].title,
          message: notifications[index].message,
          type: notifications[index].type,
          timestamp: notifications[index].timestamp,
          isRead: true,
          actionUrl: notifications[index].actionUrl,
        );
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      notifications = notifications.map((n) => NotificationItem(
        id: n.id,
        title: n.title,
        message: n.message,
        type: n.type,
        timestamp: n.timestamp,
        isRead: true,
        actionUrl: n.actionUrl,
      )).toList();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Semua notifikasi ditandai sudah dibaca'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteNotification(String id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notifikasi dihapus'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'BATAL',
          onPressed: () {
            // Could implement undo functionality here
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notifikasi'),
            if (unreadCount > 0)
              Text(
                '$unreadCount belum dibaca',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        actions: [
          if (unreadCount > 0)
            IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: 'Tandai semua sudah dibaca',
              onPressed: _markAllAsRead,
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('Semua'),
              ),
              const PopupMenuItem(
                value: 'unread',
                child: Text('Belum Dibaca'),
              ),
              const PopupMenuItem(
                value: 'read',
                child: Text('Sudah Dibaca'),
              ),
            ],
          ),
        ],
      ),
      body: filteredNotifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final notification = filteredNotifications[index];
                return _buildNotificationCard(notification);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selectedFilter == 'unread' 
                ? Icons.notifications_active_outlined
                : Icons.notifications_off_outlined,
            size: 80,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            selectedFilter == 'unread'
                ? 'Tidak ada notifikasi baru'
                : 'Tidak ada notifikasi',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedFilter == 'unread'
                ? 'Anda sudah membaca semua notifikasi'
                : 'Belum ada notifikasi untuk ditampilkan',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    IconData icon;
    Color iconColor;
    
    switch (notification.type) {
      case 'assignment':
        icon = Icons.assignment;
        iconColor = AppColors.warning;
        break;
      case 'announcement':
        icon = Icons.campaign;
        iconColor = AppColors.accent;
        break;
      case 'course':
        icon = Icons.school;
        iconColor = AppColors.primary;
        break;
      case 'system':
        icon = Icons.info_outline;
        iconColor = AppColors.textSecondary;
        break;
      default:
        icon = Icons.notifications;
        iconColor = AppColors.primary;
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (direction) {
        _deleteNotification(notification.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: notification.isRead 
              ? Colors.white 
              : AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? AppColors.textLight.withOpacity(0.2)
                : AppColors.primary.withOpacity(0.3),
            width: notification.isRead ? 1 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (!notification.isRead) {
                _markAsRead(notification.id);
              }
              
              if (notification.type == 'announcement') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnnouncementDetailScreen(notification: notification),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Membuka: ${notification.title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: notification.isRead 
                                      ? FontWeight.w600 
                                      : FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        
                        const SizedBox(height: 6),
                        
                        Text(
                          notification.message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.textLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              notification.timeAgo,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
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
          ),
        ),
      ),
    );
  }
}
