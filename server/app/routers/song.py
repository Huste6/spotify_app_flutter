from fastapi import APIRouter, UploadFile, File, Form, Depends
from ..database import SessionLocal
from sqlalchemy.ext.asyncio import AsyncSession
from ..middleware.auth_middleware import auth_middleware
from ..schemas.song import SongResponse
from ..schemas.favorite import FavoriteSong, FavoriteResponse,FavoriteToggleResponse
from ..controllers import song as song_controller
from typing import List

router = APIRouter()

async def get_db():
    async with SessionLocal() as session:
        yield session



@router.post('/upload', response_model=SongResponse)
async def upload_song(
    song: UploadFile = File(...), 
    thumbnail: UploadFile = File(...), 
    artist: str = Form(...), 
    song_name: str = Form(...), 
    hex_code = Form(...), 
    db: AsyncSession = Depends(get_db), 
    auth_dict = Depends(auth_middleware)
):
    return await song_controller.upload_song(
        song= song, 
        thumbnail = thumbnail, 
        artist = artist, 
        song_name = song_name, 
        hex_code = hex_code, 
        db = db
    )
    
@router.get('/list',response_model=List[SongResponse])
async def get_list_song(db: AsyncSession = Depends(get_db),auth_dict = Depends(auth_middleware)):
    return await song_controller.get_list_song(db=db)

@router.post('/favorite',response_model=FavoriteToggleResponse)
async def favorite_song(fav_song: FavoriteSong,db: AsyncSession = Depends(get_db), user_dict = Depends(auth_middleware)):
    return await song_controller.favorite_song(fav_song,db,user_dict['uid'])

@router.get('/list_favorite',response_model=List[FavoriteResponse])
async def list_favorite_song(db:AsyncSession = Depends(get_db), user_dict = Depends(auth_middleware)):
    return await song_controller.get_list_favorite_song(db,user_dict['uid'])