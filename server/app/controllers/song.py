import cloudinary
import cloudinary.uploader
from fastapi import HTTPException
from ..models.song import Song
from ..schemas.song import SongResponse
import uuid

cloudinary.config( 
    cloud_name = "dwpeoekrv", 
    api_key = "521443384342867", 
    api_secret = "GaE6-lPz3lOk89x_KYo5fhTGXn0",
    secure=True
)

async def upload_song(
    song,
    thumbnail,
    artist,
    song_name,
    hex_code,
    db
):
    try:
        song_id = str(uuid.uuid4())
        song_res = cloudinary.uploader.upload(
            song.file, 
            resource_type='auto', 
            folder=f'songs/{song_id}'
        )
        song_url = song_res.get("secure_url")
        if not song_url:
            raise Exception("Song upload failed")
        thumbnail_res = cloudinary.uploader.upload(
            thumbnail.file, 
            resource_type='image', 
            folder=f'songs/{song_id}'
        )
        thumbnail_url = thumbnail_res.get("secure_url")
        if not thumbnail_url:
            raise Exception("Thumbnail upload failed")
        # store data in db
        new_song = Song(
            id=song_id,
            artist=artist,
            song_name=song_name,
            hex_code=hex_code,
            song_url=song_url,
            thumbnail_url=thumbnail_url
        )
        db.add(new_song)
        await db.commit()
        await db.refresh(new_song)
        return SongResponse.from_orm(new_song)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

async def get_list_song(db):
    try:
        result = await db.execute(
            Song.__table__.select()
        )
        songs = result.fetchall()
        return [SongResponse.from_orm(song) for song in songs]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))