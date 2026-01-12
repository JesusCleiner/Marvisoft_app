from app import create_app, db
import sys

try:
    # 1. Inicializar la aplicación Flask
    app = create_app()

    # 2. Establecer el contexto de la aplicación
    with app.app_context():
        print("Iniciando la creación del esquema de la base de datos...")
        
        # 3. Crear todas las tablas a partir de los modelos de SQLAlchemy
        db.create_all()
        
        print("✅ ¡Éxito! Todas las tablas han sido creadas según tus modelos de Python.")
        
except Exception as e:
    print(f"❌ Ocurrió un error durante la creación de la base de datos: {e}", file=sys.stderr)
    print("Asegúrate de que tus modelos no tengan errores de sintaxis y que el servicio de PostgreSQL esté activo.")
    sys.exit(1)