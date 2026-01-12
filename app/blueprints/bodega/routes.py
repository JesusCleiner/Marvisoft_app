from flask import Blueprint

bodega_bp = Blueprint('bodega', __name__, url_prefix='/bodega')

@bodega_bp.route('/')
def index():
    return "¡Bodega funciona!"
