from ..database import Base
from sqlalchemy import Column, String, ForeignKey,Integer
from sqlalchemy.orm import relationship

class Favorite(Base):
    __tablename__ = "favorites"
    
    id = Column(String, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    song_id = Column(String, ForeignKey("songs.id"), nullable=False)
    
    song = relationship('Song')
    user = relationship('User', back_populates='favorites')