from fastapi import FastAPI
from . import models, database, routes
import logging
import uvicorn
import os

app = FastAPI()

# Tắt log chi tiết của SQLAlchemy
logging.getLogger("sqlalchemy.engine").propagate = False
logging.getLogger("sqlalchemy.engine").setLevel(logging.WARNING)

# Nếu muốn tắt luôn các logger khác của sqlalchemy (không chỉ engine)
logging.getLogger("sqlalchemy").setLevel(logging.WARNING)

@app.on_event("startup")
async def startup():
    async with database.engine.begin() as conn:
        await conn.run_sync(models.Base.metadata.create_all)

# Khai báo router
app.include_router(routes.router)

# Chạy trực tiếp bằng python main.py (nếu không dùng uvicorn từ command line)
if __name__ == "__main__":
    # Biến môi trường hoặc đặt giá trị mặc định
    host = os.getenv("HOST", "127.0.0.1")
    port = int(os.getenv("PORT", 8000))

    uvicorn.run("app.main:app", host=host, port=port, reload=True)
