
// Timeslots coming from database we format them as datetime - 09:30 - 10.00 
String formatHourMinute(String timeString) {
  final parts = timeString.split(':');
  if (parts.length >= 2) {
    return '${parts[0]}:${parts[1]}';
  }
  return timeString;
}

// Pads a single-digit number with a leading zero (e.g. 5 → "05") 
String twoDigits(int n) => n.toString().padLeft(2, '0');

// Formats a DateTime object as a string in the format "dd/MM/yyyy"
String formatDate(DateTime date) {
  return '${twoDigits(date.day)}/'
         '${twoDigits(date.month)}/'
         '${date.year}';
}
