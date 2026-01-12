import os
from dotenv import load_dotenv
from app import create_app

load_dotenv() 

app = create_app()

# ESTA LÍNEA ES VITAL: Asegura que Flask use la URL de Render
if 'DATABASE_URL' in os.environ:
    # Render a veces da la URL como 'postgres://', pero SQLAlchemy requiere 'postgresql://'
    uri = os.environ.get('DATABASE_URL')
    if uri and uri.startswith("postgres://"):
        uri = uri.replace("postgres://", "postgresql://", 1)
    app.config['SQLALCHEMY_DATABASE_URI'] = uri

if 'SECRET_KEY' in os.environ:
    app.config['SECRET_KEY'] = os.environ['SECRET_KEY']
    
if __name__ == '__main__':
    # En producción (Render), el puerto debe ser dinámico
    port = int(os.environ.get("PORT", 10000))
    app.run(host='0.0.0.0', port=port, debug=app.config.get('DEBUG', False))