from fastapi import FastAPI
from .database import engine
from .models import user
from .routers import user as user_router
import logging
import uvicorn
import os

app = FastAPI()

# Tắt log chi tiết của SQLAlchemy
logging.getLogger("sqlalchemy.engine").propagate = False
logging.getLogger("sqlalchemy.engine").setLevel(logging.WARNING)
logging.getLogger("sqlalchemy").setLevel(logging.WARNING)

@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(user.Base.metadata.create_all)

# Khai báo router
app.include_router(user_router.router, prefix='/auth')

# Chạy nếu file được gọi trực tiếp
if __name__ == "__main__":
    host = os.getenv("HOST", "127.0.0.1")
    port = int(os.getenv("PORT", 8000))
    uvicorn.run("app.main:app", host=host, port=port, reload=True)