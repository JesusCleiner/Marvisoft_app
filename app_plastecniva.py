
import os
from dotenv import load_dotenv # Importar la función para cargar .env
from app import create_app

# 1. Cargar las variables de entorno del archivo .env
# Esto debe ocurrir antes de que se llame a create_app(), ya que create_app()
# intentará leer la configuración de la base de datos (DATABASE_URL).
load_dotenv() 

# 2. Crear la instancia de la aplicación Flask
app = create_app()

# CRUCIAL: Aseguramos que la SECRET_KEY del entorno se transfiera a la configuración de Flask.
# Esto resuelve el RuntimeError de CSRF, ya que la clave está disponible en app.config.
if 'SECRET_KEY' in os.environ:
    app.config['SECRET_KEY'] = os.environ['SECRET_KEY']
    
if __name__ == '__main__':
    # 3. Inicia la aplicación
    # La variable DEBUG se carga desde config.py (que a su vez lee el entorno)
    app.run(debug=app.config['DEBUG'])
