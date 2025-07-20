from typing import Optional
from pydantic import BaseModel
from .song import SongResponse
from .user import UserResponse

class FavoriteSong(BaseModel):
    song_id: str

class FavoriteResponse(BaseModel):
    id: str
    user_id:int  
    song_id:str
    song: Optional[SongResponse]
    user: Optional[UserResponse]
    
    class Config:
        from_attributes = True
        arbitrary_types_allowed = True

class FavoriteToggleResponse(BaseModel):
    message: bool
    new_favorite: Optional[FavoriteResponse] = None