### 1. Clone project
```bash
git clone
cd server
```

### 2. Tạo môi trường ảo Python
```bash
python -m venv venv
venv\Scripts\activate  # Trên Windows
# source venv/bin/activate  # Trên macOS/Linux
```

### 3. Cài đặt các gói cần thiết
```bash
pip install -r requirements.txt
```

### 4. Chạy docker
```bash
docker compose up --build -d
```

### 5. Chạy app
```bash
uvicorn app.main:app --reload
```

### 6. Truy cập tài liệu API
```bash
Swagger UI: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
Posgres: http://localhost:5050/ 
```