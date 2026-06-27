import enum


class CompanySize(str, enum.Enum):
    MICRO = "MICRO"
    SMALL = "SMALL"
    MEDIUM = "MEDIUM"
    LARGE = "LARGE"


class OAuthProvider(str, enum.Enum):
    LOCAL = "LOCAL"
    GOOGLE = "GOOGLE"
    MICROSOFT = "MICROSOFT"


class AssessmentStatus(str, enum.Enum):
    IN_PROGRESS = "IN_PROGRESS"
    COMPLETED = "COMPLETED"
    CANCELLED = "CANCELLED"


class ComplianceLevel(str, enum.Enum):
    CRITICAL = "CRITICAL"
    LOW = "LOW"
    MEDIUM = "MEDIUM"
    HIGH = "HIGH"
    EXCELLENT = "EXCELLENT"


class RiskLevel(str, enum.Enum):
    LOW = "LOW"
    MEDIUM = "MEDIUM"
    HIGH = "HIGH"
