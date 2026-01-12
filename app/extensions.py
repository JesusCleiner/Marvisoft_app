from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

# 🧩 Instancias globales de extensiones
db = SQLAlchemy()
migrate = Migrate()
