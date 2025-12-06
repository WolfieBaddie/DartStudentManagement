## 1. Tạo Project Dart chuẩn (Console Application)

Thay vì tạo file thủ công, chúng ta dùng công cụ dòng lệnh (CLI) của Dart để tạo cấu trúc thư mục chuẩn.

### Bước 1: Mở Terminal
Mở VS Code, nhấn `Ctrl + ~` để mở Terminal (hoặc dùng CMD/Terminal của máy).

### Bước 2: Chạy lệnh tạo project
Di chuyển đến thư mục bạn muốn lưu project, sau đó gõ:

```bash
dart create -t console my_dart_app
```
*   `dart create`: Lệnh tạo dự án.
*   `-t console`: Chọn template là ứng dụng console (giao diện dòng lệnh).
*   `my_dart_app`: Tên dự án (nên viết thường, cách nhau bằng gạch dưới).

### Bước 3: Mở project
Trên VS Code, chọn **File -> Open Folder** và chọn thư mục `my_dart_app` vừa tạo.

**Cấu trúc thư mục bạn sẽ thấy:**
*   **`bin/`**: Chứa file chạy chính (`main.dart`). Đây là cổng vào của ứng dụng.
*   **`lib/`**: Chứa các file code logic, các Class (Đây là nơi bạn viết code chính).
*   **`pubspec.yaml`**: File "trái tim" quản lý cấu hình và thư viện (Dependency).

---

## 2. Cách thêm Dependency (Thư viện bên ngoài)

Lập trình viên giỏi không viết lại mọi thứ, họ dùng thư viện. Ví dụ: Để định dạng tiền tệ, ngày tháng, chúng ta dùng thư viện `intl`.

Có 2 cách để thêm thư viện:

### Cách 1: Dùng dòng lệnh (Khuyên dùng)
Gõ lệnh sau vào terminal của VS Code:
```bash
dart pub add intl
```
Lệnh này sẽ tự động tìm phiên bản mới nhất của thư viện `intl` và thêm vào file `pubspec.yaml`.

### Cách 2: Sửa thủ công file `pubspec.yaml`
Mở file `pubspec.yaml`, tìm phần `dependencies:` và thêm tên thư viện vào:

```yaml
dependencies:
  intl: ^0.19.0 # (Hoặc phiên bản mới nhất)
```
*Lưu ý: Trong YAML, thụt đầu dòng (indentation) rất quan trọng. Phải thụt lề đúng cấp.*

Sau khi lưu file, VS Code thường sẽ tự chạy lệnh `dart pub get` để tải thư viện về.

---

## 3. Tạo và Sử dụng Class trong cấu trúc Project

Chúng ta sẽ thực hành bài toán: **Quản lý Sinh viên**.
*   Tạo Class `Student` trong thư mục `lib`.
*   Sử dụng thư viện `intl` để định dạng ngày sinh.
*   Gọi và sử dụng Class này ở `bin/main.dart`.

### Bước 1: Tạo file Class trong `lib/`
Tạo file mới: `lib/student.dart`.

```dart
// lib/student.dart

// 1. Import thư viện intl đã cài
import 'package:intl/intl.dart';

class Student {
  String id;
  String name;
  DateTime dateOfBirth;
  double score;

  // Constructor
  Student({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    this.score = 0.0,
  });

  // Method 1: Lấy tuổi
  int get age {
    return DateTime.now().year - dateOfBirth.year;
  }

  // Method 2: In thông tin (Sử dụng intl để format ngày)
  void showInfo() {
    // Định dạng ngày tháng kiểu Việt Nam (dd/MM/yyyy)
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateOfBirth);
    
    print('-------------------------');
    print('SV: $name (ID: $id)');
    print('Ngày sinh: $formattedDate (Tuổi: $age)');
    print('Điểm: $score -> Xếp loại: ${_classify()}');
  }

  // Method private (chỉ dùng trong nội bộ class này)
  String _classify() {
    if (score >= 8.0) return 'Giỏi';
    if (score >= 5.0) return 'Khá';
    return 'Trung bình';
  }
}
```

### Bước 2: Gọi Class trong `bin/main.dart`
Bây giờ chúng ta quay lại file `bin/main.dart` (xóa code cũ đi) và import class vừa viết.

```dart
// bin/main.dart

// Cách import file trong cùng project
// Khuyên dùng cú pháp 'package:tên_project/đường_dẫn_trong_lib'
import 'package:my_dart_app/student.dart'; 

void main() {
  // 1. Tạo danh sách sinh viên
  List<Student> classroom = [];

  // 2. Thêm sinh viên vào danh sách
  classroom.add(
    Student(
      id: 'SV001', 
      name: 'Nguyễn Văn A', 
      dateOfBirth: DateTime(2002, 5, 20), // Năm, tháng, ngày
      score: 8.5
    )
  );

  classroom.add(
    Student(
      id: 'SV002', 
      name: 'Trần Thị B', 
      dateOfBirth: DateTime(2003, 11, 15), 
      score: 6.0
    )
  );

  // 3. Duyệt danh sách và hiển thị
  print('DANH SÁCH LỚP HỌC:');
  for (var sv in classroom) {
    sv.showInfo();
  }
}
```

---

## 4. Chạy chương trình

Mở Terminal và gõ lệnh:

```bash
dart run
```

**(Hoặc `dart run bin/main.dart`)**

### Kết quả mong đợi:
```text
DANH SÁCH LỚP HỌC:
-------------------------
SV: Nguyễn Văn A (ID: SV001)
Ngày sinh: 20/05/2002 (Tuổi: 22)
Điểm: 8.5 -> Xếp loại: Giỏi
-------------------------
SV: Trần Thị B (ID: SV002)
Ngày sinh: 15/11/2003 (Tuổi: 21)
Điểm: 6.0 -> Xếp loại: Khá
```

### Tổng kết kiến thức phần này:
1.  **Project Structure:** Code logic để ở `lib/`, file chạy để ở `bin/`.
2.  **Pubspec.yaml:** Nơi khai báo thư viện. Dùng `dart pub add` để thêm.
3.  **Import:**
    *   Import thư viện: `import 'package:tên_thư_viện/...'`
    *   Import file của mình: `import 'package:tên_project/tên_file_trong_lib.dart'`

Bạn hãy thử làm theo các bước trên nhé. Nếu gặp lỗi ở bước nào, cứ nhắn lại mình sẽ giải thích kỹ hơn!