from pydantic import BaseModel

class SongBase(BaseModel):
    artist: str
    song_name: str
    hex_code: str

class SongCreate(BaseModel):
    artist: str
    song_name: str
    hex_code: str
    song_url: str
    thumbnail_url: str

class SongResponse(SongBase):
    id: str
    artist: str
    song_name: str
    hex_code: str
    song_url: str
    thumbnail_url: str

    class Config:
        from_attributes = True