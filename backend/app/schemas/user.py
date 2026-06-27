from datetime import datetime
from typing import Optional

from pydantic import BaseModel, ConfigDict, EmailStr

from app.core.enums import OAuthProvider


class UserBase(BaseModel):
    company_id: int
    role_id: int
    first_name: str
    last_name: str
    email: EmailStr
    oauth_provider: OAuthProvider = OAuthProvider.LOCAL
    oauth_id: Optional[str] = None
    is_active: Optional[bool] = True


class UserCreate(UserBase):
    password_hash: Optional[str] = None


class UserUpdate(UserBase):
    company_id: Optional[int] = None
    role_id: Optional[int] = None
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    email: Optional[EmailStr] = None
    oauth_provider: Optional[OAuthProvider] = None


class UserResponse(UserBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    last_login: Optional[datetime] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
