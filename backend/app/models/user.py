from __future__ import annotations

from datetime import datetime
from typing import Optional

from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, String, func
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.enums import OAuthProvider
from app.database.base import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    company_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("companies.id"), nullable=False
    )
    role_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("roles.id"), nullable=False
    )
    first_name: Mapped[str] = mapped_column(String(100), nullable=False)
    last_name: Mapped[str] = mapped_column(String(100), nullable=False)
    email: Mapped[str] = mapped_column(String(150), nullable=False, unique=True)
    password_hash: Mapped[Optional[str]] = mapped_column(
        String(255), nullable=True
    )
    oauth_provider: Mapped[Optional[OAuthProvider]] = mapped_column(
        String(20), default=OAuthProvider.LOCAL
    )
    oauth_id: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    is_active: Mapped[Optional[bool]] = mapped_column(Boolean, default=True)
    last_login: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True), nullable=True
    )
    created_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True), server_default=func.now()
    )
    updated_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), onupdate=func.now()
    )

    company: Mapped["Company"] = relationship(back_populates="users")
    role: Mapped["Role"] = relationship(back_populates="users")
    assessments: Mapped[list["Assessment"]] = relationship(
        back_populates="evaluator"
    )
