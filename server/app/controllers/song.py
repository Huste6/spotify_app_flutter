import unicodedata
import cloudinary
import cloudinary.uploader
from fastapi import HTTPException
from sqlalchemy import func, or_, select
from ..models.song import Song
from ..models.favorite import Favorite
from ..schemas.song import SongResponse
from ..schemas.favorite import FavoriteResponse
import uuid
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import joinedload

cloudinary.config( 
    cloud_name = "dwpeoekrv", 
    api_key = "521443384342867", 
    api_secret = "GaE6-lPz3lOk89x_KYo5fhTGXn0",
    secure=True
)

def normalize_text(text: str) -> str:
    text = text.lower()
    text = unicodedata.normalize('NFD', text)
    text = ''.join(c for c in text if unicodedata.category(c) != 'Mn')
    return text

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

async def favorite_song(fav_song, db: AsyncSession, uid: int):
    try:
        result = await db.execute(
            select(Favorite).where(Favorite.user_id == uid, Favorite.song_id == fav_song.song_id)
        )
        existing = result.scalar_one_or_none()
        if existing:
            await db.delete(existing)
            await db.commit()
            return {'message': False}

        new_favorite = Favorite(
            id=str(uuid.uuid4()),
            user_id=uid,
            song_id=fav_song.song_id
        )
        db.add(new_favorite)
        await db.commit()

        # Load lại để eagerly load quan hệ
        result = await db.execute(
            select(Favorite)
            .options(joinedload(Favorite.song))
            .options(joinedload(Favorite.user))
            .where(Favorite.user_id == uid, Favorite.song_id == fav_song.song_id)
        )
        new_favorite_with_relations = result.scalar_one_or_none()

        return {
            "message": True,
            "new_favorite": FavoriteResponse.model_validate(new_favorite_with_relations)
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    
async def get_list_favorite_song(db: AsyncSession, uid: int):
    try:
        result = await db.execute(
            select(Favorite)
            .options(joinedload(Favorite.song)) 
            .options(joinedload(Favorite.user))
            .where(Favorite.user_id == uid)
        )
        favorites = result.scalars().all()
        return favorites
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

async def get_song_search(db:AsyncSession, query:str):
    try:
        search_pattern = f"%{query.lower()}%"
        result = await db.execute(
            select(Song).where(
                or_(
                    func.lower(Song.song_name).ilike(search_pattern),
                    func.lower(Song.artist).ilike(search_pattern)
                )
            )
        )
        songs = result.scalars().all()
        return [SongResponse.from_orm(song) for song in songs]
    except Exception as e:
        raise HTTPException(status_code=500,detail=str(e))