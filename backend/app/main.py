from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.routers import (
    auth,
    users,
    companies,
    assessments,
    questions,
    reports,
    dashboard,
    ai,
)

app = FastAPI(
    title=settings.APP_NAME,
    description="API de Privacidad y Cumplimiento",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:4200",
        "http://127.0.0.1:4200",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(users.router)
app.include_router(companies.router)
app.include_router(assessments.router)
app.include_router(questions.router)
app.include_router(reports.router)
app.include_router(dashboard.router)
app.include_router(ai.router)


@app.get("/")
def read_root():
    return {"message": "Backend funcionando correctamente"}


@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "app": settings.APP_NAME,
        "environment": settings.APP_ENV,
    }
