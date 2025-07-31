# In app/main.py

from fastapi import FastAPI

app = FastAPI(title="Friends RAG PoC")

@app.get("/")
def read_root():
    return {"message": "Welcome to the Friends RAG PoC API!"}