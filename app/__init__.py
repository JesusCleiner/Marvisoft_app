from flask import Flask
from .config import Config
from .extensions import db, migrate

# Importa tus blueprints actualizados

from app.blueprints.main.routes import main_bp
from app.blueprints.clientes.routes import clientes_bp
from app.blueprints.proveedores.routes import proveedores_bp
from app.blueprints.facturacion.routes import facturacion_bp
from app.blueprints.compras.routes import compras_bp
from app.blueprints.ventas.routes import ventas_bp  # CORRECTO
from app.blueprints.produccion.routes import produccion_bp
from app.blueprints.bodega.routes import bodega_bp
from app.blueprints.despachos.routes import despachos_bp
from app.blueprints.reportes.routes import reportes_bp
from app.blueprints.configuracion.routes import configuracion_bp
from app.blueprints.users.routes import users_bp


def create_app():
    """Crea y configura la instancia de la aplicación Flask."""
    app = Flask(__name__)

    # 📌 Cargar la configuración desde config.py
    app.config.from_object(Config)

    # 🧩 Inicializar extensiones
    db.init_app(app)
    migrate.init_app(app, db)

    # 🧭 Registrar blueprints con sus prefijos
    app.register_blueprint(main_bp)
    app.register_blueprint(clientes_bp, url_prefix="/clientes")
    app.register_blueprint(proveedores_bp, url_prefix="/proveedores")
    app.register_blueprint(facturacion_bp, url_prefix="/facturacion")
    app.register_blueprint(compras_bp, url_prefix="/compras")
    app.register_blueprint(ventas_bp, url_prefix="/ventas")  # CORRECTO
    app.register_blueprint(produccion_bp, url_prefix="/produccion")
    app.register_blueprint(bodega_bp, url_prefix="/bodega")
    app.register_blueprint(despachos_bp, url_prefix="/despachos")
    app.register_blueprint(reportes_bp, url_prefix="/reportes")
    app.register_blueprint(configuracion_bp, url_prefix="/configuracion")
    app.register_blueprint(users_bp, url_prefix="/users")

    return app
