from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from ..schemas.user import UserCreate, UserResponse, UserLogin
from ..database import SessionLocal
from ..controllers import user as user_controller

router = APIRouter()

async def get_db():
    async with SessionLocal() as session:
        yield session

@router.post("/signup", response_model=UserResponse)
async def create_user(user: UserCreate, db: AsyncSession = Depends(get_db)):
    return await user_controller.create_user_controller(user, db)

@router.post("/login", response_model=UserResponse)
async def login_user(user: UserLogin, db: AsyncSession = Depends(get_db)):
    return await user_controller.login_user_controller(user, db)