from fastapi import HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..models.user import User
from ..schemas.user import UserCreate
import bcrypt

async def create_user_controller(user_data: UserCreate, db: AsyncSession):
    # Kiểm tra xem email đã tồn tại chưa
    result = await db.execute(select(User).where(User.email == user_data.email))
    existing_user = result.scalar_one_or_none()

    if existing_user:
        raise HTTPException(status_code=400, detail="User with the same email already exists!")

    # Hash mật khẩu
    hashed_pass = bcrypt.hashpw(user_data.password.encode('utf-8'), bcrypt.gensalt())

    # Tạo user mới
    new_user = User(
        name=user_data.name,
        email=user_data.email,
        password=hashed_pass
    )

    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)

    return new_user
