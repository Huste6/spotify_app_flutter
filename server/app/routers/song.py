from fastapi import APIRouter
from ..database import SessionLocal

router = APIRouter()

async def get_db():
    async with SessionLocal() as session:
        yield session
        
@router.post('/upload')
def upload_song(song, thumbnail, artist, song_name, color):
    pass