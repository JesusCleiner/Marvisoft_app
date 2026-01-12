# app/config.py

import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    # ... otras configuraciones

    # 1. Elimina las variables DB_USER, DB_HOST, etc.

    # 2. Asigna la URL COMPLETA directamente
    # Si la variable no existe, el segundo argumento ('') asegura que no sea None inicialmente
    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL", "")
    
    # OPCIONAL: Agrega una comprobación para un error más claro
    if not SQLALCHEMY_DATABASE_URI:
        raise ValueError("FATAL: DATABASE_URL no se ha cargado en el entorno.")

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    DEBUG = os.getenv("DEBUG", "False") == "True"