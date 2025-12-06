// lib/student.dart
import "package:sqlite3/sqlite3.dart";

class Student {
  String id;
  String name;
  double mathScore;
  double engScore;

  // Constructor với Named Parameters & required
  Student({
    required this.id,
    required this.name,
    required this.mathScore,
    required this.engScore,
  });

  // Getter: Tính điểm trung bình (Tự động tính khi được gọi)
  double get averageScore => (mathScore + engScore) / 2;

  // Getter: Xếp loại học lực dựa trên điểm trung bình
  String get rank {
    if (averageScore >= 8.0) return 'Giỏi';
    if (averageScore >= 6.5) return 'Khá';
    if (averageScore >= 5.0) return 'Trung Bình';
    return 'Yếu';
  }
  
  Map<String, dynamic> toMap()
  {
    return{
      'id': id,
      'name': name,
      'mathScore': mathScore,
      'engScore': engScore
    };
  }

  factory Student.fromRow(Row row)
  {
      return Student(
        id: row['id'] as String,
        name: row['name'] as String,
        mathScore: row['mathScore'] as double,
        engScore: row['engScore'] as double
      );
  }


  // Override hàm toString để in thông tin cho đẹp
  @override
  String toString() {
    return 'ID: $id | Tên: $name | ĐTB: $averageScore | Xếp loại: $rank';
  }
}