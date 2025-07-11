from fastapi import HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..models.user import User
from ..schemas.user import UserCreate, UserLogin
import bcrypt
import jwt

async def create_user_controller(user_data: UserCreate, db: AsyncSession):
    # Kiểm tra có data truyền vào không nếu không in ra lỗi
    if not user_data.name.strip() or not user_data.email.strip() or not user_data.password.strip():
        raise HTTPException(status_code=422, detail="All fields (name, email, password) must be non-empty.")

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

async def login_user_controller(user_data: UserLogin, db: AsyncSession):
    # Kiểm tra có data truyền vào không nếu không in ra lỗi 
    if not user_data.email.strip() or not user_data.password.strip():
        raise HTTPException(status_code=422, detail="All fields (email, password) must be non-empty.")

    # Tìm người dùng theo email
    result = await db.execute(select(User).where(User.email == user_data.email))
    existing_user = result.scalar_one_or_none()

    if not existing_user:
        raise HTTPException(status_code=400, detail="User with this email does not exist!")

    # Kiểm tra mật khẩu
    is_match = bcrypt.checkpw(user_data.password.encode('utf-8'), existing_user.password)

    if not is_match:
        raise HTTPException(status_code=400, detail="Incorrect password!")

    token = jwt.encode({'id': existing_user.id}, 'password_key')
    
    return {'token': token,'user': existing_user}