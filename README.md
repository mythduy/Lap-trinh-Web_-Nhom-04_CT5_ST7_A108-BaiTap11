# Dự án Demo Spring Security

Đây là dự án demo toàn diện về Spring Security với giao diện tiếng Việt, bao gồm 4 demo chính:

## 🚀 Demo 1: Cài đặt, Cấu hình, Phân quyền cơ bản trong Spring Security

### ✨ Tính năng:
- ✅ Cấu hình Spring Security cơ bản
- ✅ Xác thực in-memory với 3 vai trò: QUẢN TRỊ VIÊN, QUẢN LÝ, NGƯỜI DÙNG
- ✅ Bảo mật cấp phương thức với `@PreAuthorize`
- ✅ Kiểm soát truy cập dựa trên URL
- ✅ Đăng nhập và đăng xuất dựa trên form

### 📁 Files quan trọng:
- `SecurityConfig.java` - Cấu hình cơ bản (hiện đã comment out)
- `SecurityDemoController.java` - Controllers với phân quyền

### 👤 Tài khoản demo:
- **admin/admin123** (Vai trò QUẢN TRỊ VIÊN)
- **manager/manager123** (Vai trò QUẢN LÝ)  
- **user/user123** (Vai trò NGƯỜI DÙNG)

## 🗄️ Demo 2: Sử dụng cơ sở dữ liệu để lưu và lấy dữ liệu cho việc phân quyền

### ✨ Tính năng:
- ✅ JPA entities cho User và Role
- ✅ Custom UserDetailsService
- ✅ Xác thực cơ sở dữ liệu với H2
- ✅ Mã hóa mật khẩu với BCrypt
- ✅ Quan hệ many-to-many giữa User và Role
- ✅ Khởi tạo dữ liệu tự động

### 📁 Files quan trọng:
- `DatabaseSecurityConfig.java` - Cấu hình database security (đang hoạt động)
- `User.java`, `Role.java` - JPA entities
- `UserRepository.java`, `RoleRepository.java` - Data repositories
- `CustomUserDetailsService.java` - Custom user details service
- `DataInitializer.java` - Khởi tạo dữ liệu mẫu

### 🗃️ Cơ sở dữ liệu:
- **H2 In-memory database**
- **Console:** http://localhost:8080/h2-console
- **URL:** `jdbc:h2:mem:testdb`
- **Tên đăng nhập:** `sa`, **Mật khẩu:** (để trống)

## 🌿 Demo 3: Spring Security với Thymeleaf

### ✨ Tính năng:
- ✅ Thymeleaf security namespace
- ✅ Hiển thị có điều kiện dựa trên vai trò
- ✅ Hiển thị thông tin xác thực
- ✅ Xử lý form bảo mật
- ✅ Giao diện responsive đẹp mắt với Bootstrap

### 📁 Files quan trọng:
- `templates/home.html` - Trang chủ
- `templates/login.html` - Form đăng nhập
- `templates/dashboard.html` - Bảng điều khiển chính
- `templates/admin.html`, `templates/manager.html`, `templates/user.html` - Trang theo vai trò
- `templates/thymeleaf-demo.html` - Demo các tính năng Thymeleaf security

### 🔧 Tính năng Thymeleaf Security:
```html
<!-- Kiểm tra xác thực -->
<div sec:authorize="isAuthenticated()">...</div>

<!-- Nội dung dựa trên vai trò -->
<div sec:authorize="hasRole('ADMIN')">...</div>
<div sec:authorize="hasAnyRole('USER','MANAGER')">...</div>

<!-- Hiển thị thông tin người dùng -->
<span sec:authentication="name"></span>
<span sec:authentication="authorities"></span>
```

## 📄 Demo 4: Spring Security với JSP/JSTL

### ✨ Tính năng:
- ✅ JSP với Spring Security taglib
- ✅ Tích hợp JSTL
- ✅ Hiển thị nội dung dựa trên vai trò
- ✅ Bảo vệ CSRF trong forms
- ✅ Truy cập thuộc tính xác thực

### 📁 Files quan trọng:
- `webapp/WEB-INF/jsp/jsp-demo.jsp` - Trang demo JSP
- `FrontendDemoController.java` - Controller cho JSP demo

### 🏷️ JSP Security Tags:
```jsp
<!-- Kiểm tra xác thực -->
<sec:authorize access="isAuthenticated()">...</sec:authorize>

<!-- Nội dung dựa trên vai trò -->
<sec:authorize access="hasRole('ADMIN')">...</sec:authorize>
<sec:authorize access="hasAnyRole('USER','MANAGER')">...</sec:authorize>

<!-- Hiển thị thông tin người dùng -->
<sec:authentication property="name"/>
<sec:authentication property="authorities"/>

<!-- CSRF token -->
<sec:csrfInput/>
```

## 📂 Cấu trúc dự án

```
src/
├── main/
│   ├── java/com/example/demo/
│   │   ├── config/
│   │   │   ├── SecurityConfig.java (Demo 1 - đã comment)
│   │   │   └── DatabaseSecurityConfig.java (Demo 2 - đang hoạt động)
│   │   ├── controller/
│   │   │   ├── SecurityDemoController.java
│   │   │   └── FrontendDemoController.java
│   │   ├── entity/
│   │   │   ├── User.java
│   │   │   └── Role.java
│   │   ├── repository/
│   │   │   ├── UserRepository.java
│   │   │   └── RoleRepository.java
│   │   ├── service/
│   │   │   ├── CustomUserDetailsService.java
│   │   │   └── UserService.java
│   │   ├── init/
│   │   │   └── DataInitializer.java
│   │   └── DemoApplication.java
│   ├── resources/
│   │   ├── templates/ (Thymeleaf)
│   │   │   ├── home.html
│   │   │   ├── login.html
│   │   │   ├── dashboard.html
│   │   │   ├── admin.html
│   │   │   ├── manager.html
│   │   │   ├── user.html
│   │   │   ├── thymeleaf-demo.html
│   │   │   └── access-denied.html
│   │   └── application.properties
│   └── webapp/WEB-INF/jsp/ (JSP)
│       └── jsp-demo.jsp
```

## 🛠️ Cách chạy dự án

1. **Clone dự án:**
   ```bash
   git clone <repository-url>
   cd demo
   ```

2. **Build dự án:**
   ```bash
   mvn clean compile
   ```

3. **Chạy ứng dụng:**
   ```bash
   mvn spring-boot:run
   ```

4. **Truy cập ứng dụng:**
   - **Trang chủ:** http://localhost:8080
   - **Đăng nhập:** http://localhost:8080/login
   - **Bảng điều khiển:** http://localhost:8080/dashboard
   - **Console H2:** http://localhost:8080/h2-console (Chỉ Admin)

## 🔗 URL Demo

### 📱 Trang chính:
- **/** - Trang chủ
- **/login** - Form đăng nhập
- **/dashboard** - Bảng điều khiển chính

### 🎯 Trang demo:
- **/thymeleaf-demo** - Demo bảo mật Thymeleaf
- **/jsp-demo** - Demo bảo mật JSP/JSTL

### 🔐 Trang phân quyền:
- **/user** - Truy cập: NGƯỜI DÙNG, QUẢN LÝ, QUẢN TRỊ VIÊN
- **/manager** - Truy cập: QUẢN LÝ, QUẢN TRỊ VIÊN  
- **/admin** - Truy cập: Chỉ QUẢN TRỊ VIÊN

## ⚙️ Chuyển đổi giữa các Demo

### Để sử dụng Demo 1 (In-memory):
1. Comment `@Configuration` trong `DatabaseSecurityConfig.java`
2. Uncomment `@Configuration` trong `SecurityConfig.java`
3. Khởi động lại ứng dụng

### Để sử dụng Demo 2 (Database):
1. Uncomment `@Configuration` trong `DatabaseSecurityConfig.java` (mặc định)
2. Comment `@Configuration` trong `SecurityConfig.java` (mặc định)
3. Khởi động lại ứng dụng

## 📦 Dependencies chính

```xml
<!-- Spring Security -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>

<!-- Thymeleaf + Security -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
<dependency>
    <groupId>org.thymeleaf.extras</groupId>
    <artifactId>thymeleaf-extras-springsecurity6</artifactId>
</dependency>

<!-- JSP/JSTL -->
<dependency>
    <groupId>org.apache.tomcat.embed</groupId>
    <artifactId>tomcat-embed-jasper</artifactId>
</dependency>
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
</dependency>

<!-- Database -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
</dependency>
```

## 🔒 Tính năng Security được demo

1. **Xác thực (Authentication):**
   - Đăng nhập dựa trên form
   - Xác thực In-memory và Database
   - Mã hóa mật khẩu
   - Chức năng ghi nhớ đăng nhập

2. **Phân quyền (Authorization):**
   - Kiểm soát truy cập dựa trên vai trò
   - Bảo mật cấp phương thức (`@PreAuthorize`)
   - Kiểm soát truy cập dựa trên URL
   - Vai trò phân cấp

3. **Quản lý Session:**
   - Xử lý session
   - Kiểm soát session đồng thời
   - Chức năng đăng xuất

4. **Tích hợp Frontend:**
   - Thymeleaf security namespace
   - JSP security taglib
   - Hiển thị nội dung có điều kiện
   - Hiển thị thông tin xác thực

5. **Tính năng bảo mật:**
   - Bảo vệ CSRF
   - Xử lý từ chối truy cập
   - Security headers
   - Chính sách mật khẩu

## 🐛 Xử lý sự cố

### Lỗi thường gặp:

1. **404 khi truy cập JSP:**
   - Kiểm tra JSP dependencies trong pom.xml
   - Xác minh JSP files trong đúng thư mục `webapp/WEB-INF/jsp/`

2. **Từ chối truy cập:**
   - Kiểm tra vai trò người dùng trong database
   - Xác minh method-level security annotations

3. **Kết nối database:**
   - Kiểm tra H2 console: http://localhost:8080/h2-console
   - URL: `jdbc:h2:mem:testdb`, username: `sa`, password: để trống

4. **Không tìm thấy templates:**
   - Kiểm tra Thymeleaf templates trong `resources/templates/`
   - Xác minh giá trị trả về của controller

## 📋 Ghi chú

- Dự án sử dụng Spring Boot 3.5.6 và Spring Security 6
- Database sử dụng H2 in-memory (dữ liệu sẽ mất khi restart)
- Bootstrap 5.1.3 cho styling UI
- FontAwesome cho icons
- CSRF protection được disable cho demo (không nên trong production)
- Giao diện đã được Việt hóa hoàn toàn

**🎯 Chúc bạn học tập hiệu quả với Spring Security!** 🚀