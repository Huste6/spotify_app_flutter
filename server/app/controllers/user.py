from typing import Optional
from fastapi import HTTPException, UploadFile
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..models.user import User
from ..schemas.user import UserCreate, UserLogin, UserUpdate
import bcrypt
import jwt
from ..config import SECRET_KEY, ALGORITHM
from sqlalchemy.orm import joinedload
import cloudinary
import cloudinary.uploader

cloudinary.config( 
    cloud_name = "dwpeoekrv", 
    api_key = "521443384342867", 
    api_secret = "GaE6-lPz3lOk89x_KYo5fhTGXn0",
    secure=True
)

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

    token = jwt.encode({'id': existing_user.id}, SECRET_KEY, algorithm=ALGORITHM)
    
    return {'token': token,'user': existing_user}

async def get_current_user_data(db: AsyncSession, uid: int):
    result = await db.execute(select(User).options(joinedload(User.favorites)).where(User.id == uid))
    user = result.unique().scalar_one_or_none()
    
    if not user:
        raise HTTPException(status_code=401, detail='User not found')

    return user

async def update_profile(
    name: Optional[str],
    email: Optional[str],
    password: Optional[str],
    avatar: Optional[UploadFile],
    db:AsyncSession,
    uid:int
):
    result = await db.execute(select(User).where(User.id == uid))
    user = result.scalar_one_or_none()
    
    if not user:
        raise HTTPException(status_code=404, detail='User not found')
    
    if name is not None:
        user.name = name.strip()
    if email is not None:
        user.email = email.strip()
    if password is not None:
        user.password = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())
    if avatar is not None:
        try:
            avatar_res = cloudinary.uploader.upload(
                avatar.file,
                resource_type = 'image',
                folder = f'avatars/{uid}'
            )
            avatar_url = avatar_res.get('secure_url')
            if not avatar_url:
                raise Exception("Avatar upload failed")
            user.avatar = avatar_url
        except Exception as e:
            raise HTTPException(status_code=500, detail=f'Avatar upload error: {e}')
    await db.commit()
    await db.refresh(user)
    return user