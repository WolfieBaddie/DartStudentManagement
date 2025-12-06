Ứng dụng sẽ có các tính năng chuẩn **CRUD**:
1.  **C**reate: Thêm sinh viên mới.
2.  **R**ead: Xem danh sách, tìm kiếm sinh viên.
3.  **U**pdate: Sửa thông tin (ở đây mình sẽ làm tính năng xếp loại tự động).
4.  **D**elete: Xóa sinh viên.

---

### Cấu trúc dự án
Bạn hãy tạo project mới (hoặc dùng project cũ), cấu trúc thư mục nên như sau:
```text
my_student_app/
├── bin/
│   └── main.dart       <-- Chứa hàm main, menu và xử lý nhập liệu
└── lib/
    └── student.dart    <-- Chứa Class Student (Mô hình dữ liệu)
```

---

### BƯỚC 1: Xây dựng Model (File `lib/student.dart`)
Class này sẽ chứa thông tin sinh viên và các logic tính toán điểm.

```dart
// lib/student.dart

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

  // Override hàm toString để in thông tin cho đẹp
  @override
  String toString() {
    return 'ID: $id | Tên: $name | ĐTB: $averageScore | Xếp loại: $rank';
  }
}
```

---

### BƯỚC 2: Xử lý Logic & Giao diện (File `bin/main.dart`)
Tại đây chúng ta sẽ dùng thư viện `dart:io` để đọc dữ liệu từ bàn phím.

```dart
// bin/main.dart

import 'dart:io'; // Thư viện nhập xuất dữ liệu
import 'package:my_student_app/student.dart'; // Import file class của bạn

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
```

---

### Giải thích các kỹ thuật sử dụng trong bài

1.  **`dart:io` & `stdin.readLineSync()`**: Đây là cách Dart đọc dữ liệu người dùng nhập từ Console. Nó luôn trả về `String?` (có thể null), nên ta phải xử lý null.
2.  **Getter (`get averageScore`)**: Trong class `Student`, ta không cần lưu biến `averageScore` cứng. Ta dùng getter để tính toán động. Bất cứ khi nào điểm toán/anh thay đổi, điểm trung bình tự cập nhật.
3.  **List Methods (Sức mạnh của Dart):**
    *   `.add()`: Thêm mới.
    *   `.any((e) => ...)`: Trả về `true` nếu tìm thấy bất kỳ phần tử nào thỏa mãn (Dùng để check trùng ID).
    *   `.removeWhere((e) => ...)`: Xóa phần tử theo điều kiện.
    *   `.where((e) => ...)`: Lọc danh sách (Dùng cho chức năng tìm kiếm).
    *   `.toLowerCase().contains(...)`: Kỹ thuật tìm kiếm tương đối (Ví dụ: tìm "nam" sẽ ra "Nam", "Khánh Nam").
4.  **`double.tryParse(...) ?? 0.0`**: Đây là cách an toàn để chuyển chuỗi sang số. Nếu người dùng nhập chữ "abc", `tryParse` trả về null, toán tử `??` sẽ lấy giá trị mặc định là `0.0`, giúp chương trình không bị crash.

### Cách chạy chương trình
Mở terminal tại thư mục dự án và gõ:
```bash
dart run bin/main.dart
```