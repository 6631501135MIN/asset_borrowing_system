import 'package:flutter/material.dart';

class BorrowRequest {
  final int borrowingId;
  final String status;
  final DateTime borrowDate;
  final DateTime returnDate;
  final int assetId;
  final String assetCode;
  final String assetName;
  final String categoryName;
  final String categoryImage;
  final String categoryImageUrl;

  BorrowRequest({
    required this.borrowingId,
    required this.status,
    required this.borrowDate,
    required this.returnDate,
    required this.assetId,
    required this.assetCode,
    required this.assetName,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageUrl,
  });

  factory BorrowRequest.fromJson(Map<String, dynamic> json) {
    return BorrowRequest(
      borrowingId: json['borrowing_id'] ?? 0,
      status: json['status'] ?? 'pending',
      borrowDate: DateTime.parse(json['borrow_date']),
      returnDate: DateTime.parse(json['return_date']),
      assetId: json['asset_id'] ?? 0,
      assetCode: json['asset_code'] ?? '',
      assetName: json['asset_name'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryImage: json['category_image'] ?? '',
      categoryImageUrl: json['category_image_url'] ?? '',
    );
  }

  // Get status color based on status
  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return const Color(0xFFFFB020);
      case 'returned':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // Get icon based on category name
  IconData getCategoryIcon() {
    final lowerName = categoryName.toLowerCase();
    if (lowerName.contains('macbook') || lowerName.contains('laptop')) {
      return Icons.laptop_mac;
    } else if (lowerName.contains('ipad') || lowerName.contains('tablet')) {
      return Icons.tablet_mac;
    } else if (lowerName.contains('playstation') || lowerName.contains('ps')) {
      return Icons.sports_esports;
    } else if (lowerName.contains('vr') || lowerName.contains('headset')) {
      return Icons.vrpano;
    } else if (lowerName.contains('camera')) {
      return Icons.camera_alt;
    } else if (lowerName.contains('drone')) {
      return Icons.flight;
    } else if (lowerName.contains('headphone')) {
      return Icons.headphones;
    } else {
      return Icons.devices;
    }
  }

  // Fix image URL if needed (replace IP address)
  String getFixedImageUrl() {
    if (categoryImageUrl.isEmpty) return categoryImageUrl;
    
    // Replace any IP address with the correct one
    final uri = Uri.parse(categoryImageUrl);
    const correctIp = '192.168.1.185';
    
    if (uri.host != correctIp) {
      return categoryImageUrl.replaceAll(
        RegExp(r'http://[\d\.]+:'),
        'http://$correctIp:',
      );
    }
    
    return categoryImageUrl;
  }

  // Capitalize status for display
  String getStatusDisplay() {
    return status[0].toUpperCase() + status.substring(1);
  }
}
