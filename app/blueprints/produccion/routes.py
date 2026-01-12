from flask import Blueprint

produccion_bp = Blueprint('produccion', __name__, url_prefix='/produccion')

@produccion_bp.route('/')
def index():
    return "¡Producción funciona!"
