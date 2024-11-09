from fastapi import FastAPI, Depends
from sqlalchemy import create_engine, MetaData, text
from sqlalchemy.orm import sessionmaker, Session

# Configuración de la base de datos
DB_URL = "postgresql://postgres:postgres@db-e11evenn:5432/e11evenn"
engine = create_engine(DB_URL)
metadata = MetaData()
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

app = FastAPI()

# Dependencia para obtener la sesión de la base de datos
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/data")
def read_data(db: Session = Depends(get_db)):
    # Ejecutar la consulta para obtener datos de la tabla
    result = db.execute(text("SELECT * FROM e11evenn"))
    data = [dict(zip(result.keys(), row)) for row in result]
    return data