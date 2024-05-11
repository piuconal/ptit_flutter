# 1. Công nghệ

- **Framework:** Flutter (sử dụng ngôn ngữ Dart)
- **Tích hợp Firebase các tính năng:**
  + **Realtime Database:** Đồng bộ dữ liệu ứng dụng (lưu số thứ tự sinh viên)
  + **Authentication:** Xác thực người dùng bằng email/password (Admin/Client)
  + **Storage:** Lưu trữ hình ảnh sinh viên
  + **Firestore Database:** NoSQL lưu trữ:
    1. Thông tin sinh viên
    2. Thông báo hẹn lịch của từng sinh viên (theo uid)

# 2. Vai trò, chức năng chính

### a) Đăng nhập
- Kiểm tra email đăng nhập có chứa chuỗi “stu.ptit.com.vn” để dẫn tới trang sinh viên. Ngược lại, dẫn tới trang admin.
- **Tài khoản admin** được thêm trực tiếp từ Firebase.

### b) Admin (Quản lý sinh viên)
- Sử dụng mail chính chủ để có thể đổi mật khẩu trên Firebase.
- Thêm / Sửa / Xóa / Tìm kiếm (theo tên/mã/ngành(khóa)) thông tin sinh viên.
- Lọc danh sách (Khóa / Ngành).

**Chú thích:** Khi thêm sinh viên, hệ thống sẽ tự động sinh mã sinh viên và tài khoản đăng nhập của sinh viên.

**Ví dụ:** 
Vũ Trọng Hiếu / Ngành: Công nghệ thông tin / Khóa: D20
=> **Tài khoản:** hieuvt@stu.ptit.com.vn (tên viết thường + 2 chữ cái đầu viết thường của họ + đệm)
=> **Mật khẩu:** D20CNTTxxx (Khóa + Các chữ cái đầu của ngành + xxx: lấy từ realtime database)

### c) Client (Sinh viên)
- Xem thông tin tuyển sinh (cố định thông tin, gắn link dẫn đến [QLDT.PTIT](https://qldt.ptit.edu.vn/#/home))
- Thêm / Hẹn giờ và ghi chú gửi thông báo đến điện thoại người dùng.
- Xem thông tin cá nhân.

# 3. Giao diện ứng dụng
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/f0a34ee8-080e-495b-b07d-9996753bcdb4)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/1e00c15e-5457-4b2d-8bf8-ee65c4016f5b)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/d40fd11b-fa6b-471d-a23d-9afde0e9db14)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/d7913131-d4d1-4bea-9818-3b7c847668ea)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/4f437221-40bb-4755-a1b3-2a41d831af6f)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/bacdade4-e7e5-485f-a96c-9b94a3890316)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/46d54c73-4044-40fe-88c8-3ce9079f6537)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/44b6b368-7f25-4694-b20c-d2e21a4f5a7f)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/935ee207-0ab2-47cd-9b67-efee142ec9b5)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/7832d164-8e37-4fa7-8493-9eb99972be12)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/cce4c475-1215-4856-895f-66ac5b3877f4)
### ![image](https://github.com/piuconal/ptit_flutter/assets/85973353/2394b1b0-e916-4052-a205-8867ee1ef715)











