import 'package:firebase_messaging/firebase_messaging.dart';
import '../../utils/app_log/app_log.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  static String? _deviceToken;
  
  static String get deviceToken => _deviceToken ?? "";
  
  // Initialize Firebase Messaging
  static Future<void> initialize() async {
    try {
      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      
      appLog('Firebase Messaging permission status: ${settings.authorizationStatus}');
      
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get FCM token
        _deviceToken = await _firebaseMessaging.getToken();
        appLog('FCM Device Token: $_deviceToken');
        
        // Listen for token refresh
        _firebaseMessaging.onTokenRefresh.listen((newToken) {
          _deviceToken = newToken;
          appLog('FCM Token refreshed: $newToken');
        });
        
        // Handle foreground messages
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          appLog('Received foreground message: ${message.notification?.title}');
        });
        
        // Handle background messages
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          appLog('Message clicked: ${message.notification?.title}');
        });
      }
    } catch (e) {
      appLog('Firebase Messaging initialization error: $e');
    }
  }
  
  // Get current FCM token
  static Future<String?> getToken() async {
    try {
      if (_deviceToken != null) {
        return _deviceToken;
      }
      _deviceToken = await _firebaseMessaging.getToken();
      appLog('FCM Token retrieved: $_deviceToken');
      return _deviceToken;
    } catch (e) {
      appLog('Error getting FCM token: $e');
      return null;
    }
  }
  
  // Delete FCM token
  static Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _deviceToken = null;
      appLog('FCM Token deleted');
    } catch (e) {
      appLog('Error deleting FCM token: $e');
    }
  }
}
