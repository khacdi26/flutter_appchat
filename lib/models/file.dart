// Class đại diện cho thông tin file
class File {
  final String fileURL; // URL của file
  final String fileName; // Tên file
  final String fileType; // Loại file (image, document, etc.)

  File({
    required this.fileURL,
    required this.fileName,
    required this.fileType,
  });

  // Phương thức chuyển đổi thành bản đồ JSON
  Map<String, dynamic> toMap() {
    return {
      'fileURL': fileURL,
      'fileName': fileName,
      'fileType': fileType,
    };
  }
}
