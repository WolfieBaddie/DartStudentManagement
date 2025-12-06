# Nhập Môn Ngôn Ngữ Dart & Hướng Dẫn Cài Đặt

## 1. Dart là gì?
**Dart** là ngôn ngữ lập trình mã nguồn mở, đa mục đích, hướng đối tượng (OOP) được phát triển bởi **Google** vào năm 2011.

Ban đầu, Dart được sinh ra với tham vọng thay thế JavaScript, nhưng hiện nay nó được biết đến nhiều nhất là **trái tim của Flutter** - framework phát triển ứng dụng đa nền tảng (Mobile, Web, Desktop) hàng đầu hiện nay.

Về cú pháp, Dart mang phong cách **C-style** (giống C, Java, C#) nhưng hiện đại và ngắn gọn hơn.

## 2. Tại sao Dart?

Dưới đây là 4 lý do khiến Dart trở thành ngôn ngữ đáng học nhất cho lập trình viên ứng dụng (Client-side):

*   **⚡ Dành cho Flutter:** Nếu muốn làm chủ Flutter để viết app chạy trên cả iOS và Android, bạn **bắt buộc** phải giỏi Dart. Dart được tối ưu hóa riêng để render giao diện (UI) cực nhanh.
*   **🚀 Hiệu năng kép (JIT & AOT):**
    *   **JIT (Just-in-Time):** Giúp biên dịch cực nhanh khi đang code, tạo ra tính năng **Hot Reload** thần thánh (sửa code thấy ngay kết quả không cần chạy lại app).
    *   **AOT (Ahead-of-Time):** Khi xuất bản ứng dụng, Dart biên dịch thành mã máy (native code), giúp app chạy mượt như app viết bằng Swift hay Kotlin.
*   **🛡️ Null Safety:** Dart có cơ chế bảo vệ code khỏi các lỗi `null` (giá trị rỗng) cực kỳ chặt chẽ, giúp giảm thiểu tối đa tình trạng app bị crash đột ngột (tính năng này mạnh hơn cả Java hay JS cũ).
*   **dễ học:** Nếu bạn đã từng học C, C++, Java hay JavaScript, bạn có thể đọc hiểu code Dart ngay lập tức. Cú pháp của nó rất trong sáng và tường minh.

## 3. Cài đặt môi trường phát triển (VS Code)

Để lập trình Dart chuyên nghiệp, **Visual Studio Code (VS Code)** là IDE nhẹ và mạnh mẽ nhất được khuyên dùng.

### Bước 1: Cài đặt Dart SDK
Dart SDK là bộ công cụ cốt lõi để biên dịch và chạy code Dart.

*   **Windows:**
    *   Cách dễ nhất: Tải file cài đặt tại [Dart SDK Archive](https://dart.dev/get-dart/archive).
    *   Hoặc dùng Chocolatey (PowerShell): `choco install dart-sdk`
*   **macOS:**
    *   Sử dụng Homebrew (Terminal): `brew tap dart-lang/dart && brew install dart`
*   **Linux:**
    *   Sử dụng `apt-get` theo hướng dẫn trên trang chủ.

> **Kiểm tra:** Sau khi cài, mở Terminal (hoặc CMD) và gõ: `dart --version`. Nếu hiện ra phiên bản (ví dụ: `Dart SDK version 3.x.x`) là thành công.

### Bước 2: Cài đặt Visual Studio Code
Tải và cài đặt bản mới nhất tại: [code.visualstudio.com](https://code.visualstudio.com/)

### Bước 3: Cài đặt Extension cho VS Code (Quan trọng)
1.  Mở VS Code.
2.  Bấm vào biểu tượng **Extensions** bên thanh trái (hoặc nhấn `Ctrl+Shift+X`).
3.  Tìm kiếm từ khóa **"Dart"**.
4.  Chọn Extension đầu tiên (của *Dart Code*) và bấm **Install**.
    *   *Mẹo:* Bạn nên cài luôn Extension **"Flutter"**, nó sẽ tự động cài luôn cả Dart và hỗ trợ tốt hơn cho việc hiển thị code.

## 4. Viết chương trình "Hello World" đầu tiên

Để kiểm tra mọi thứ đã hoạt động trơn tru, hãy viết dòng code đầu tiên.

1.  Tạo một thư mục mới trên máy tính, đặt tên là `HocDart`.
2.  Mở thư mục đó bằng VS Code (**File** -> **Open Folder**).
3.  Tạo một file mới tên là `main.dart` (đuôi file Dart bắt buộc là `.dart`).
4.  Nhập đoạn code sau:

```dart
// Mọi chương trình Dart đều bắt đầu từ hàm main()
void main() {
  print('Hello World! Chào mừng đến với Dart.');
  
  var year = 2024;
  print('Năm hiện tại là: $year');
}
```

5.  **Chạy chương trình:**
    *   Nhìn lên góc trên bên phải file code, bạn sẽ thấy nút **Run** (Hình tam giác) hoặc chữ **Run | Debug** ngay trên hàm `main`. Bấm vào đó.
    *   Hoặc mở Terminal trong VS Code (`Ctrl + ~`) và gõ lệnh:
        ```bash
        dart run main.dart
        ```

**Kết quả:**
Nếu cửa sổ **Debug Console** hiện ra dòng chữ: `Hello World! Chào mừng đến với Dart.` thì xin chúc mừng, bạn đã sẵn sàng cho buổi học đầu tiên!