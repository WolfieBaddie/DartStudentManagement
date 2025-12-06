// bin/main.dart

import 'dart:io'; // Thư viện nhập xuất dữ liệu
import '../lib/student.dart'; // Import file class của bạn

void main() {
  // Danh sách lưu trữ sinh viên (Database tạm thời)
  List<Student> students = [];

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
        showAllStudents(students);
        break;
      case '2':
        addStudent(students);
        break;
      case '3':
        removeStudent(students);
        break;
      case '4':
        findStudent(students);
        break;
      case '0':
        print('Đã thoát chương trình. Tạm biệt!');
        return; // Kết thúc hàm main -> Dừng chương trình
      default:
        print('Lựa chọn không hợp lệ. Vui lòng chọn lại!');
    }
  }
}

// --- CÁC HÀM CHỨC NĂNG ---

// Chức năng 1: Xem danh sách
void showAllStudents(List<Student> list) {
  print('\n--- DANH SÁCH LỚP ---');
  if (list.isEmpty) {
    print('Danh sách đang trống!');
  } else {
    // Sử dụng vòng lặp for-in
    for (var sv in list) {
      print(sv.toString());
    }
    print('Tổng số: ${list.length} sinh viên');
  }
}

// Chức năng 2: Thêm sinh viên
void addStudent(List<Student> list) {
  print('\n--- THÊM SINH VIÊN ---');
  
  stdout.write('Nhập ID: ');
  String id = stdin.readLineSync() ?? ''; // Nếu null thì lấy chuỗi rỗng

  // Kiểm tra ID trùng (Dùng hàm .any để check tồn tại)
  bool isExist = list.any((sv) => sv.id == id);
  if (isExist) {
    print('Lỗi: ID này đã tồn tại!');
    return;
  }

  stdout.write('Nhập Tên: ');
  String name = stdin.readLineSync() ?? 'No Name';

  stdout.write('Điểm Toán: ');
  // double.tryParse: Cố gắng chuyển chuỗi thành số, nếu lỗi trả về null
  double math = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  stdout.write('Điểm Anh: ');
  double eng = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  // Tạo đối tượng và thêm vào List
  Student newSv = Student(
    id: id, 
    name: name, 
    mathScore: math, 
    engScore: eng
  );
  
  list.add(newSv);
  print('✅ Thêm thành công!');
}

// Chức năng 3: Xóa sinh viên
void removeStudent(List<Student> list) {
  stdout.write('\nNhập ID sinh viên cần xóa: ');
  String inputId = stdin.readLineSync() ?? '';

  // Dùng removeWhere: Xóa tất cả phần tử thỏa mãn điều kiện
  // Lưu độ dài cũ để so sánh xem có xóa được ai không
  int oldLength = list.length;
  
  list.removeWhere((sv) => sv.id == inputId);

  if (list.length < oldLength) {
    print('✅ Đã xóa sinh viên có ID $inputId');
  } else {
    print('❌ Không tìm thấy ID $inputId');
  }
}

// Chức năng 4: Tìm kiếm (Nâng cao)
void findStudent(List<Student> list) {
  stdout.write('\nNhập tên cần tìm: ');
  String keyword = stdin.readLineSync() ?? '';

  // Dùng .where để lọc danh sách
  // toLowerCase() để so sánh không phân biệt hoa thường
  List<Student> results = list.where(
    (sv) => sv.name.toLowerCase().contains(keyword.toLowerCase())
  ).toList();

  showAllStudents(results);
}