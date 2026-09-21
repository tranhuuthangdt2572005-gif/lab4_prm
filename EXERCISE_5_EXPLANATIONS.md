# Exercise 5 – Debug & Fix Common UI Errors: Explanations & Solutions

Tài liệu giải thích chi tiết các nguyên nhân và giải pháp cho 4 lỗi giao diện thường gặp nhất trong Flutter theo yêu cầu của bài thực hành Lab 4.

---

## 1. Fix ListView inside Column using `Expanded`

### ❌ Triệu chứng lỗi (Error)
```
FlutterError: Vertical viewport was given unbounded height.
Viewports expand in the scrolling direction to fill their container.
```

### 🔍 Nguyên nhân (Cause)
- Một `Column` sắp xếp các widget con theo chiều dọc và cung cấp cho các con một **chiều cao vô hạn (unbounded height constraints: `maxHeight = double.infinity`)**.
- `ListView` mặc định là một scrollable viewport và cũng cố gắng mở rộng tối đa theo chiều dọc (`double.infinity`).
- Khi đặt trực tiếp một `ListView` bên trong một `Column`, `ListView` không biết kích thước giới hạn là bao nhiêu để tính toán layout và scroll, dẫn đến crash với lỗi unbounded height.

###  Cách sửa (Solution)
Bọc `ListView` trong widget `Expanded` (hoặc `Flexible`):
```dart
Column(
  children: [
    Text('Header'),
    // Sửa lỗi: Bọc ListView trong Expanded
    Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
      ),
    ),
  ],
)
```
*Lưu ý thay thế:* Nếu danh sách ngắn và không cần cuộn riêng biệt, có thể dùng `shrinkWrap: true` và `physics: const NeverScrollableScrollPhysics()`.

---

## 2. Fix Overflow in Small Screens using `SingleChildScrollView`

### ❌ Triệu chứng lỗi (Error)
```
A RenderFlex overflowed by xxx pixels on the bottom.
```
Màn hình xuất hiện dải sọc chéo màu vàng-đen (yellow and black striped banner) ở mép dưới hoặc cạnh phải.

### 🔍 Nguyên nhân (Cause)
- Widget `Column` hoặc `Row` mặc định không thể tự cuộn khi tổng kích thước của các widget con vượt quá kích thước vật lý của màn hình (ví dụ màn hình điện thoại nhỏ, xoay ngang màn hình, hoặc khi bàn phím ảo bật lên làm giảm viewport).

###  Cách sửa (Solution)
Bọc `Column` bằng `SingleChildScrollView`:
```dart
Scaffold(
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        // Các widgets form hoặc nội dung dài
        TextField(),
        SizedBox(height: 20),
        ElevatedButton(...),
      ],
    ),
  ),
)
```
Widget này cho phép toàn bộ nội dung trong `Column` cuộn mượt mà khi chiều cao vượt quá màn hình, loại bỏ hoàn toàn dải sọc cảnh báo overflow.

---

## 3. Fix State Update Issue by adding `setState()`

### ❌ Triệu chứng lỗi (Bug)
- Người dùng nhấn nút, giá trị biến trong code đã tăng lên nhưng **giao diện UI không hề thay đổi**.

### 🔍 Nguyên nhân (Cause)
- Trong một `StatefulWidget`, việc gán giá trị biến thông thường (ví dụ: `_counter++` hoặc `_selectedGenre = value`) chỉ làm thay đổi giá trị trong bộ nhớ RAM của đối tượng `State`.
- Flutter Engine **chỉ kích hoạt vẽ lại (rerun hàm `build`)** khi được thông báo qua cơ chế `setState()`. Nếu không gọi `setState()`, Flutter không biết rằng trạng thái đã thay đổi và sẽ không cập nhật widget tree.

###  Cách sửa (Solution)
Đặt lệnh thay đổi biến vào trong hàm callback `setState(() { ... })`:
```dart
// SAI (Không cập nhật UI):
onPressed: () {
  _counter++;
}

// ĐÚNG (UI tự động re-render và hiển thị giá trị mới):
onPressed: () {
  setState(() {
    _counter++;
  });
}
```

---

## 4. Fix DatePicker BuildContext Errors

### ❌ Triệu chứng lỗi (Error)
```
Navigator operation requested with a context that does not include a Navigator.
hoặc
Looking up a deactivated widget's ancestor is unsafe.
```

### 🔍 Nguyên nhân (Cause)
- Hàm `showDatePicker` (hoặc `showDialog`, `showModalBottomSheet`) cần tìm kiếm widget `Navigator` trong widget tree thông qua `BuildContext` truyền vào.
- Nếu bạn gọi `showDatePicker` với một `context` nằm ở tầng trên `MaterialApp` (ví dụ context của hàm `main()` hoặc `build()` của `MyApp`), nó sẽ không tìm thấy `Navigator`.
- Hoặc nếu gọi `showDatePicker` bất đồng bộ (`async / await`) và sau đó truy cập lại context khi widget đã bị unmount hoặc hủy (`State.mounted == false`), sẽ xảy ra lỗi `Looking up a deactivated widget's ancestor`.

###  Cách sửa (Solution)
1. Luôn truyền `BuildContext` hợp lệ nằm bên dưới `MaterialApp` và `Scaffold` (ví dụ `context` trong hàm `build` của `StatefulWidget` hoặc dùng widget `Builder`).
2. Kiểm tra `mounted` sau các khoảng chờ `await` bất đồng bộ:
```dart
// Cách gọi chuẩn xác:
Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context, // Context hợp lệ từ Builder hoặc State
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  // Kiểm tra mounted trước khi gọi setState() để tránh lỗi bộ nhớ / unmounted context
  if (mounted && picked != null) {
    setState(() {
      _selectedDate = picked;
    });
  }
}
```
Hoặc dùng `Builder`:
```dart
Builder(
  builder: (validContext) {
    return ElevatedButton(
      onPressed: () => _selectDate(validContext),
      child: const Text('Open DatePicker'),
    );
  },
)
```
