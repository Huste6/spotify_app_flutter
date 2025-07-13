import uuid
from fastapi import APIRouter, HTTPException, UploadFile, File, Form, Depends
from ..database import SessionLocal
from sqlalchemy.ext.asyncio import AsyncSession
import cloudinary
import cloudinary.uploader
from ..middleware.auth_middleware import auth_middleware
from ..schemas.song import SongResponse
from ..models.song import Song

router = APIRouter()

async def get_db():
    async with SessionLocal() as session:
        yield session

cloudinary.config( 
    cloud_name = "dwpeoekrv", 
    api_key = "521443384342867", 
    api_secret = "GaE6-lPz3lOk89x_KYo5fhTGXn0",
    secure=True
)

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
    try:
        song_id = str(uuid.uuid4())
        song_res = cloudinary.uploader.upload(
            song.file, 
            resource_type = 'auto', 
            folder=f'songs/{song_id}'
        )
        song_url = song_res.get("secure_url")
        if not song_url:
            raise Exception("Song upload failed")
        thumbnail_res = cloudinary.uploader.upload(
            thumbnail.file, 
            resource_type = 'image', 
            folder=f'songs/{song_id}'
        )
        thumbnail_url = thumbnail_res.get("secure_url")
        if not thumbnail_url:
            raise Exception("Thumbnail upload failed")
        #store data in db
        new_song = Song(
            id = song_id,
            artist = artist,
            song_name = song_name,
            hex_code = hex_code,
            song_url = song_url,
            thumbnail_url = thumbnail_url
        )
        db.add(new_song)
        await db.commit()
        await db.refresh(new_song)
        return SongResponse.from_orm(new_song)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
