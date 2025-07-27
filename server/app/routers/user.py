from typing import Optional
from fastapi import APIRouter, Depends, File, Form, UploadFile
from ..middleware.auth_middleware import auth_middleware
from sqlalchemy.ext.asyncio import AsyncSession
from ..schemas.user import UserCreate, UserResponse, UserLogin, LoginResponse, UserUpdate
from ..database import SessionLocal
from ..controllers import user as user_controller

router = APIRouter()

async def get_db():
    async with SessionLocal() as session:
        yield session

@router.post("/signup", response_model=UserResponse)
async def create_user(user: UserCreate, db: AsyncSession = Depends(get_db)):
    return await user_controller.create_user_controller(user, db)

@router.post("/login", response_model=LoginResponse)
async def login_user(user: UserLogin, db: AsyncSession = Depends(get_db)):
    return await user_controller.login_user_controller(user, db)

@router.get('/')
async def current_user_data(db: AsyncSession = Depends(get_db), user_dict = Depends(auth_middleware)):
    return await user_controller.get_current_user_data(db,user_dict['uid'])

@router.put("/update_profile", response_model=UserResponse)
async def update_profile(
    name: Optional[str] = Form(None),
    email: Optional[str] = Form(None),
    password: Optional[str] = Form(None),
    avatar: UploadFile = File(None),
    db: AsyncSession = Depends(get_db),
    user_dict=Depends(auth_middleware),
):
    return await user_controller.update_profile(
        name=name,
        email=email,
        password=password,
        avatar=avatar,
        db=db,
        uid=user_dict["uid"]
    )
