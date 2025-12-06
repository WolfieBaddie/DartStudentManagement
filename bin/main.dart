// bin/main.dart

import 'dart:io'; // Thư viện nhập xuất dữ liệu
import 'package:student_management/database_helper.dart';
import 'package:student_management/student.dart';

void main() {
  // Danh sách lưu trữ sinh viên (Database tạm thời)
  final dbHelper = DatabaseHelper("students");

  while (true) {
    // 1. Hiển thị MENU
    print('\n================ QUẢN LÝ SINH VIÊN ================');
    print('1. Xem danh sách sinh viên');
    print('2. Thêm sinh viên mới');
    print('3. Xóa sinh viên theo ID');
    print('4. Tìm kiếm sinh viên theo tên');
    print('0. Thoát');
    stdout.write('Chọn chức năng (0-4): '); // stdout.write không xuống dòng

    // 2. Nhập lựa chọn từ bàn phím
    String? choice = stdin.readLineSync();

    // 3. Xử lý rẽ nhánh
    switch (choice) {
      case '1':
        var list = dbHelper.getAllStudent();
        showList(list);
        break;
      case '2':
         addStudentUI(dbHelper);
        break;
      case '3':
        deleteStudentUI(dbHelper);
        break;
      case '4':
        searchStudentUI(dbHelper);
        break;
      case '0':
        dbHelper.close(); // Đóng kết nối
        print('Bye!');
        exit(0);
      default:
        print('Lựa chọn không hợp lệ. Vui lòng chọn lại!');
    }
  }
}

// --- CÁC HÀM UI ---

void showList(List<Student> list) {
  print('\n--- KẾT QUẢ ---');
  if (list.isEmpty) print('Trống!');
  for (var sv in list) {
    print(sv.toString());
  }
}

void addStudentUI(DatabaseHelper db) {
  stdout.write('ID: ');
  String id = stdin.readLineSync() ?? '';
  stdout.write('Tên: ');
  String name = stdin.readLineSync() ?? '';
  stdout.write('Điểm Toán: ');
  double math = double.tryParse(stdin.readLineSync()!) ?? 0.0;
  stdout.write('Điểm Anh: ');
  double eng = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  Student sv = Student(id: id, name: name, mathScore: math, engScore: eng);
  
  // Gọi hàm Insert của Database
  db.addStudent(sv);
}

void deleteStudentUI(DatabaseHelper db) {
  stdout.write('Nhập ID cần xóa: ');
  String id = stdin.readLineSync() ?? '';
  
  bool success = db.deleteStudent(id);
  if (success) {
    print('✅ Đã xóa thành công.');
  } else {
    print('❌ Không tìm thấy ID này.');
  }
}

void searchStudentUI(DatabaseHelper db) {
  stdout.write('Nhập tên cần tìm: ');
  String name = stdin.readLineSync() ?? '';
  
  var list = db.searchByNames(name);
  showList(list);
}