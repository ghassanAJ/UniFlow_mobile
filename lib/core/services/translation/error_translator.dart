// import 'package:easy_localization/easy_localization.dart';

// class ErrorTranslator {
//   /// Translates common error messages to their localized equivalents
//   /// This function checks if an error message corresponds to a known
//   /// translation key and returns the translated version if available
//   static String translateErrorMessage(String message) {
//     if (message.isEmpty) return message;
    
//     // Map of common error messages to their translation keys
//     final errorMap = {
//       'Connection Timeout, please try again': 'connection_timeout',
//       'Send Timeout, please try again': 'send_timeout',
//       'Receive Timeout, please try again': 'receive_timeout',
//       'Bad SSL Certificate': 'bad_ssl_certificate',
//       'Something went wrong, please try again.': 'something_went_wrong',
//       'Invalid request': 'invalid_request',
//       'Unauthorized access, please login again': 'unauthorized_access',
//       'Resource not found': 'resource_not_found',
//       'Validation error': 'validation_error',
//       'Server Error': 'server_error',
//       'You don\'t have permission to perform this action': 'permission_denied',
//       'Request was cancelled by user': 'request_cancelled',
//       'Connection error, please check your internet': 'connection_error',
//       'Unknown error occurred': 'unknown_error',
//       'Refresh failed': 'refresh_failed',
//       'An error occurred!': 'general_error',
//       'Server error!': 'server_error_generic',
//       'No Data': 'no_data',
//       'No Connection , Pleas Try Agen': 'no_connection',
//       // OTP related errors
//       'OTP verification failed': 'otp_verification_failed',
//       'Invalid OTP': 'otp_verification_failed',
//       'OTP expired': 'otp_verification_failed',
//       'Wrong OTP code': 'otp_verification_failed',
//       'Invalid code': 'otp_verification_failed',
//       'OTP code is invalid': 'otp_verification_failed',
//       'OTP code has expired': 'otp_verification_failed',
//       'The OTP code is incorrect': 'otp_verification_failed',
//       'Failed to send OTP': 'failed_to_send_otp',
//       'OTP send failed': 'failed_to_send_otp',
//     };

//     // Normalize message for comparison (trim and lowercase)
//     final normalizedMessage = message.trim();
    
//     // Check exact match first (case-sensitive)
//     final exactKey = errorMap[normalizedMessage];
//     if (exactKey != null) {
//       return exactKey.tr();
//     }

//     // Check case-insensitive match
//     final lowerMessage = normalizedMessage.toLowerCase();
//     for (final entry in errorMap.entries) {
//       if (entry.key.toLowerCase() == lowerMessage) {
//         return entry.value.tr();
//       }
//     }

//     // Check for OTP-related keywords (partial match)
//     if (lowerMessage.contains('otp') || 
//         lowerMessage.contains('code') && 
//         (lowerMessage.contains('invalid') || 
//          lowerMessage.contains('wrong') || 
//          lowerMessage.contains('incorrect') || 
//          lowerMessage.contains('expired') ||
//          lowerMessage.contains('failed'))) {
//       return 'otp_verification_failed'.tr();
//     }

//     // If not a known error message, return as is
//     return message;
//   }
// }