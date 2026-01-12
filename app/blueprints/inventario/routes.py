from flask import Blueprint

inventario_bp = Blueprint('inventario', __name__, url_prefix='/inventario')

@inventario_bp.route('/')
def index():
    return "¡Inventario funciona!"
