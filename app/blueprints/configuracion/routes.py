from flask import Blueprint

configuracion_bp = Blueprint('configuracion', __name__, url_prefix='/configuracion')

@configuracion_bp.route('/')
def index():
    return "¡Configuración funciona!"
