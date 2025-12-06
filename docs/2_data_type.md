**Biến, Kiểu dữ liệu, Hàm và Class**.

## 1. Biến (Variables)
Trong Dart, mọi thứ đều là đối tượng (Object). Có 2 cách chính để khai báo biến: khai báo tường minh (rõ kiểu) và suy luận kiểu (type inference).

### Cách khai báo
*   **`var`**: Dart tự động đoán kiểu dữ liệu dựa trên giá trị gán vào.
*   **Khai báo rõ kiểu**: Chỉ định rõ `String`, `int`, v.v.

### `final` và `const` (Cực kỳ quan trọng)
Trong Flutter, bạn sẽ dùng hai từ khóa này nhiều hơn cả biến thường để tối ưu hiệu năng. Cả hai đều dùng để khai báo biến **không thay đổi giá trị** (immutable), nhưng có sự khác biệt về thời điểm:

*   **`const` (Compile-time constant):** Giá trị phải được biết ngay khi viết code (cứng).
*   **`final` (Run-time constant):** Giá trị được xác định khi chương trình chạy, nhưng chỉ được gán **một lần duy nhất**.

```dart
void main() {
  // 1. Dùng var (Dart tự hiểu là String)
  var name = "Flutter"; 
  // name = 10; // Lỗi! Vì name đã được định kiểu là String.

  // 2. Khai báo rõ kiểu
  int age = 25;

  // 3. const (Biết trước giá trị)
  const double pi = 3.14; 
  
  // 4. final (Chạy mới biết, ví dụ lấy thời gian hiện tại)
  final DateTime now = DateTime.now(); 
  // now = DateTime.now(); // Lỗi! final chỉ được gán 1 lần.
}
```

---

## 2. Các Kiểu Dữ Liệu (Data Types)
Dart là ngôn ngữ định kiểu mạnh (Statically typed).

### Các kiểu cơ bản
*   **`int`**: Số nguyên (ví dụ: `1`, `100`, `-5`).
*   **`double`**: Số thực (ví dụ: `3.14`, `10.5`).
*   **`String`**: Chuỗi ký tự. Có thể dùng dấu nháy đơn `'` hoặc nháy kép `"`.
*   **`bool`**: Logic (`true` hoặc `false`).
*   **`dynamic`**: Chấp nhận mọi kiểu dữ liệu (Giống `any` trong TS). *Nên hạn chế dùng trừ khi cần thiết.*

### Null Safety (An toàn kiểu Null)
Từ phiên bản Dart 2.12, biến mặc định **không được phép Null** (Non-nullable). Để cho phép biến chứa giá trị `null`, bạn phải thêm dấu `?` sau kiểu dữ liệu.

```dart
void main() {
  // String Interpolation (Nội suy chuỗi): Dùng $
  String framework = 'Flutter';
  print('Học $framework rất vui'); // Output: Học Flutter rất vui

  // Null Safety
  int a = 10; // a không bao giờ được null
  
  int? b; // b có thể là số nguyên, hoặc là null
  b = null; // Hợp lệ
  
  // Kiểm tra null
  print(b ?? 0); // Nếu b null thì in ra 0 (Toán tử ??)
}
```

---

## 3. Hàm (Functions)
Hàm trong Dart được thiết kế rất linh hoạt. Có 3 điểm nhấn bạn cần nhớ:

### Cú pháp cơ bản & Arrow Syntax
Nếu hàm chỉ có **một dòng lệnh** trả về giá trị, dùng dấu mũi tên `=>` cho gọn.

```dart
// Cách truyền thống
int add(int a, int b) {
  return a + b;
}

// Arrow Syntax (Hay dùng)
int multiply(int a, int b) => a * b;
```

### Named Parameters (Tham số đặt tên) - Chìa khóa của Flutter
Thay vì truyền tham số theo thứ tự (dễ nhầm lẫn), Dart cho phép đặt tên cho tham số bằng cách bọc chúng trong dấu ngoặc nhọn `{}`.
*   Dùng từ khóa `required` để bắt buộc phải truyền.
*   Có thể gán giá trị mặc định.

```dart
// Định nghĩa hàm
void createUser({required String name, int age = 18}) {
  print('User: $name, Age: $age');
}

void main() {
  // Khi gọi hàm, thứ tự không quan trọng, chỉ cần đúng tên
  createUser(name: "Nam"); 
  createUser(age: 30, name: "Lan"); 
  
  // Đây chính là cách bạn viết Widget trong Flutter:
  // Scaffold(appBar: AppBar(), body: Container());
}
```

---

## 4. Class (Lớp & Đối tượng)
Dart là ngôn ngữ hướng đối tượng thuần túy. Class là bản thiết kế (blueprint), Object là thực thể tạo ra từ bản thiết kế đó.

### Cấu trúc Class & Constructor (Hàm khởi tạo)
Dart cung cấp cú pháp "Syntactic Sugar" (cú pháp ngọt) giúp viết Constructor cực ngắn gọn.

```dart
class Car {
  // Thuộc tính (Properties)
  String brand;
  int year;
  
  // Constructor truyền thống (Dài dòng - Ít dùng)
  // Car(String brand, int year) {
  //   this.brand = brand;
  //   this.year = year;
  // }

  // Constructor rút gọn (Nên dùng)
  Car(this.brand, this.year);
  
  // Named Constructor (Tạo object theo cách khác)
  Car.fromNow(this.brand) : year = 2024;

  // Phương thức (Method)
  void startEngine() {
    print('$brand đang nổ máy...');
  }
}

void main() {
  // Tạo đối tượng (Từ khóa new là tùy chọn trong Dart, thường bỏ đi)
  var myCar = Car('Toyota', 2020);
  myCar.startEngine();

  var newCar = Car.fromNow('VinFast'); // year sẽ tự là 2024
  print(newCar.year);
}
```

### Private Variables (Biến riêng tư)
Trong Dart, không có từ khóa `private` hay `public`.
*   Để đặt thuộc tính là **private** (chỉ dùng được trong nội bộ file thư viện đó), hãy thêm dấu gạch dưới `_` trước tên biến.
*   Ví dụ: `_password`, `_apiKey`.

---

### Tóm tắt để học nhanh:
1.  **Biến:** Ưu tiên dùng `final` nếu không định thay đổi giá trị.
2.  **Kiểu:** Chú ý dấu `?` (Nullable) để tránh lỗi crash app.
3.  **Hàm:** Luyện tập kỹ **Named Parameters** (`{required type name}`) vì 90% code Flutter dùng cái này.
4.  **Class:** Nắm vững cách viết Constructor rút gọn (`this.variable`).