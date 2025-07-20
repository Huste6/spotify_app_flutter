from sqlalchemy import Column, Integer, String, LargeBinary
from ..database import Base
from sqlalchemy.orm import relationship
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, nullable=False, unique=True)
    password = Column(LargeBinary, nullable=False)
    avatar = Column(String, nullable=True)
    
    favorites = relationship('Favorite', back_populates = 'user')
    