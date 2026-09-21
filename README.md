# Lab 4 – Flutter UI Fundamentals

Dự án hoàn thành đầy đủ 5 bài tập (Exercise 1 đến Exercise 5) của Module 4: Flutter UI Fundamentals.

---

## 📱 Cấu trúc thư mục dự án

```
lib/
├── main.dart                               # Màn hình chính Menu điều hướng + Global ThemeMode
└── exercises/
    ├── core_widgets_demo.dart              # Exercise 1: Text, Icon, Image.network, Card, ListTile
    ├── input_controls_demo.dart            # Exercise 2: Slider, Switch, RadioGroup, DatePicker
    ├── layout_demo.dart                    # Exercise 3: Column, Row, Padding, ListView.builder
    ├── app_structure_theme_demo.dart       # Exercise 4: Scaffold, AppBar, FAB & ThemeData + Dark Mode
    └── common_ui_fixes_demo.dart           # Exercise 5: Debug & Fix 4 lỗi UI kinh điển trong Flutter
test/
└── widget_test.dart                        # Bộ kiểm thử tự động (Unit / Widget Test) cho cả 5 bài tập
EXERCISE_5_EXPLANATIONS.md                  # Tài liệu phân tích nguyên nhân & giải pháp cho Exercise 5
```

---

## 🎯 Chi tiết 5 bài tập (Exercises)

### 1. Exercise 1 – Core Widgets Demo (`lib/exercises/core_widgets_demo.dart`)
- **Headline Text**: Tiêu đề `"Welcome to Flutter UI"`.
- **Icon**: Sử dụng `Icon(Icons.movie, size: 72, color: Colors.blue)`.
- **Image.network**: Hiển thị ảnh kèm `loadingBuilder` và `errorBuilder` dự phòng.
- **Card + ListTile**: Thẻ hiển thị Movie Item có `leading: Icon(Icons.star)`, title và subtitle.

### 2. Exercise 2 – Input Widgets Demo (`lib/exercises/input_controls_demo.dart`)
- **Slider**: Điều chỉnh điểm đánh giá (Rating) từ 0 - 100, hiển thị giá trị thời gian thực.
- **Switch**: Bật/tắt trạng thái hoạt động của phim (`Is movie active?`).
- **RadioListTile**: Chọn thể loại phim (`Action` / `Comedy`) với `RadioGroup`.
- **DatePicker**: Nút mở hộp thoại chọn ngày qua `showDatePicker()`.

### 3. Exercise 3 – Layout Basics (`lib/exercises/layout_demo.dart`)
- Sử dụng `Column` phân chia bố cục theo chiều dọc.
- Sử dụng `Padding` và `SizedBox` với khoảng cách chuẩn (8, 12, 16px).
- Hiển thị danh sách phim bằng `ListView.builder` (Avatar, Inception, Interstellar, Joker) với `CircleAvatar` và `Card`.

### 4. Exercise 4 – App Structure with Scaffold & Theme (`lib/exercises/app_structure_theme_demo.dart`)
- Cấu trúc màn hình hoàn chỉnh với `Scaffold`, `AppBar`, `Body`, và `FloatingActionButton`.
- Tùy chỉnh giao diện bằng `ThemeData` (màu sắc, typography, CardTheme, AppBarTheme).
- Nút chuyển đổi giao diện **Dark Mode / Light Mode** mượt mà với `ThemeMode`.

### 5. Exercise 5 – Debug & Fix Common UI Errors (`lib/exercises/common_ui_fixes_demo.dart`)
- **Fix 1: ListView inside Column**: Sửa lỗi unbounded height bằng cách bọc `ListView` trong `Expanded`.
- **Fix 2: Screen Overflow**: Sửa lỗi sọc vàng đen `RenderFlex overflowed` bằng cách bọc nội dung trong `SingleChildScrollView`.
- **Fix 3: State Update Issue**: Sửa lỗi UI không cập nhật khi biến thay đổi bằng cách gọi `setState()`.
- **Fix 4: DatePicker BuildContext Error**: Sửa lỗi context không hợp lệ khi gọi `showDatePicker` bằng `Builder` context hợp lệ và kiểm tra `mounted`.
- Chi tiết xem tại [EXERCISE_5_EXPLANATIONS.md](file:///d:/ki8/prm/login/EXERCISE_5_EXPLANATIONS.md).

---

## 🚀 Hướng dẫn chạy ứng dụng

### 1. Phân tích mã nguồn (Static analysis)
```bash
flutter analyze
```

### 2. Chạy bộ kiểm thử tự động (Unit / Widget tests)
```bash
flutter test
```

### 3. Chạy ứng dụng trên thiết bị / máy ảo / Chrome
```bash
flutter run
```
hoặc chọn thiết bị trong VS Code / Android Studio và bấm `F5` / `Run Without Debugging`.
