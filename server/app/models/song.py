from sqlalchemy import Column, String
from sqlalchemy.dialects.postgresql import UUID
from ..database import Base

class Song(Base):
    __tablename__ = "songs"
    id = Column(String, primary_key=True, index=True)
    artist = Column(String, nullable=False)
    song_name = Column(String, nullable=False)
    hex_code = Column(String, nullable=True)
    song_url = Column(String, nullable=False)
    thumbnail_url = Column(String, nullable=False)