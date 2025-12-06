# 1. Câu Lệnh Điều Kiện & Rẽ Nhánh

### 1.1 `if`, `else if`, `else`
Cú pháp y hệt Java/C++.

```dart
void main() {
  int score = 75;

  if (score >= 90) {
    print('Xuất sắc');
  } else if (score >= 70) {
    print('Khá'); // Chạy vào đây
  } else {
    print('Cần cố gắng');
  }
}
```

### 1.2 Toán tử 3 ngôi (Ternary Operator) - *Cực quan trọng trong Flutter*
Thay vì viết `if-else` dài dòng để gán giá trị, Dart (và Flutter) cực chuộng cách viết này.

**Cú pháp:** `điều_kiện ? giá_trị_nếu_đúng : giá_trị_nếu_sai`

```dart
void main() {
  bool isLoggedIn = false;

  // Cách viết if-else thường
  /*
  String status;
  if (isLoggedIn) {
    status = "Online";
  } else {
    status = "Offline";
  }
  */

  // Cách viết Dart (Ngắn gọn)
  String status = isLoggedIn ? "Online" : "Offline";
  print(status); // Offline
}
```

### 1.3 `switch` - `case`
Dùng khi bạn có một biến cần so sánh với nhiều giá trị cụ thể.

```dart
void main() {
  String rank = 'A';

  switch (rank) {
    case 'A':
      print('Tuyệt vời!');
      break; // Nhớ break để không trôi xuống dưới
    case 'B':
      print('Làm tốt lắm');
      break;
    default:
      print('Không xác định');
  }
}
```

---

# 2. Các Vòng Lặp (Loops)

### 2.1 Vòng lặp `for` (Cổ điển)
Dùng khi biết rõ số lần lặp hoặc cần chỉ số `i`.

```dart
for (int i = 0; i < 5; i++) {
  print('Lần lặp thứ $i');
}
```

### 2.2 Vòng lặp `for-in` (Hiện đại)
Dùng để duyệt qua các phần tử trong danh sách mà không quan tâm đến chỉ số `index`. Rất sạch sẽ và dễ đọc.

```dart
var fruits = ['Táo', 'Cam', 'Xoài'];

for (var fruit in fruits) {
  print('Tôi thích ăn $fruit');
}
```

### 2.3 `while` và `do-while`
*   `while`: Kiểm tra điều kiện **trước** khi chạy (có thể không chạy lần nào).
*   `do-while`: Chạy code **trước** rồi mới kiểm tra (chắc chắn chạy ít nhất 1 lần).

```dart
int number = 0;

// while
while (number < 3) {
  print('While: $number');
  number++;
}

// do-while
do {
  print('Do-While chạy ít nhất 1 lần');
} while (number < 0); // Điều kiện sai ngay lập tức nhưng vẫn in 1 lần
```

### 2.4 `break` và `continue`
*   `break`: Thoát khỏi vòng lặp ngay lập tức.
*   `continue`: Bỏ qua lần lặp hiện tại, nhảy sang lần lặp kế tiếp.

---

# 3. Kiểu dữ liệu nâng cao: `List` (Mảng)

Nếu trong Java bạn có `Array[]` (cố định) và `ArrayList` (động), thì trong Dart **chỉ có `List`**. Mặc định `List` trong Dart hoạt động giống hệt `ArrayList` trong Java (co giãn kích thước thoải mái).

### 3.1 Khai báo List
```dart
void main() {
  // 1. List số nguyên
  List<int> numbers = [1, 5, 10]; 
  
  // 2. List chuỗi
  List<String> names = ['An', 'Bình'];
  
  // 3. List rỗng (Cần khai báo kiểu)
  List<double> prices = []; 
}
```

### 3.2 Các thao tác cơ bản (Thêm, Sửa, Xóa)
```dart
void main() {
  List<String> todoList = ['Học Dart'];

  // Thêm phần tử (Add)
  todoList.add('Tập thể dục'); // ['Học Dart', 'Tập thể dục']
  
  // Thêm nhiều phần tử
  todoList.addAll(['Nấu ăn', 'Ngủ']);

  // Lấy độ dài
  print(todoList.length); // 4

  // Truy cập phần tử (bằng index, bắt đầu từ 0)
  print(todoList[0]); // Học Dart
  print(todoList.first); // Học Dart
  print(todoList.last);  // Ngủ

  // Sửa phần tử
  todoList[1] = 'Chạy bộ';

  // Xóa phần tử
  todoList.remove('Nấu ăn'); // Xóa theo giá trị
  todoList.removeAt(0);      // Xóa phần tử đầu tiên (index 0)
}
```

### 3.3 Duyệt và Xử lý List kiểu "Functional" (Rất quan trọng)
Ngoài `for` và `for-in`, Dart cung cấp các hàm cực mạnh để xử lý List, giúp code ngắn gọn hơn nhiều. Đây là phong cách bạn sẽ dùng suốt trong Flutter.

Giả sử có danh sách: `List<int> nums = [1, 2, 3, 4, 5, 6];`

**1. `.forEach()` - Duyệt nhanh**
```dart
nums.forEach((n) => print(n));
```

**2. `.map()` - Chuyển đổi dữ liệu (Mapping)**
Biến đổi list này thành list khác. Ví dụ: Bình phương tất cả các số.
```dart
// toList() dùng để chuyển kết quả trở lại thành List
var squaredNums = nums.map((n) => n * n).toList(); 
print(squaredNums); // [1, 4, 9, 16, 25, 36]
```

**3. `.where()` - Lọc dữ liệu (Filtering)**
Lấy ra các phần tử thỏa mãn điều kiện. Ví dụ: Lấy số chẵn.
```dart
var evenNums = nums.where((n) => n % 2 == 0).toList();
print(evenNums); // [2, 4, 6]
```

**Kết hợp (Chaining):**
Bạn có thể nối các hàm này lại với nhau (Giống Java Streams).
```dart
// Lấy số chẵn, sau đó bình phương chúng
var result = nums
    .where((n) => n % 2 == 0) // Lọc chẵn
    .map((n) => n * n)        // Bình phương
    .toList();

print(result); // [4, 16, 36]
```

### Tóm tắt sự khác biệt với Java:
1.  Không cần `new ArrayList<>()`, chỉ cần `[]`.
2.  Không cần `System.out.println`, dùng `print`.
3.  Toán tử 3 ngôi `? :` được dùng cực nhiều thay cho `if-else` đơn giản.
4.  Các hàm `.map`, `.where` (tương đương Java Stream API) được tích hợp sẵn vào List, dùng rất gọn.