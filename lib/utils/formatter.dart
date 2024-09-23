import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    final formattedDate = DateFormat('d MMMM yyyy').format(date);
    final formattedTime = DateFormat('h:mm a').format(date);
    return 'on $formattedDate at $formattedTime';
  }
}
