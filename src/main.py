from fastapi import FastAPI

app = FastAPI(title="billing-api")


@app.get("/health")
def health() -> dict[str, str | bool]:
    return {
        "status": "healthy",
        "ready": True,
        "service": "billing-api",
    }


@app.get("/ready")
def ready() -> dict[str, bool]:
    return {"ready": True}
