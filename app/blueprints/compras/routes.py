from flask import Blueprint

compras_bp = Blueprint('compras', __name__, url_prefix='/compras')

@compras_bp.route('/')
def index():
    return "¡Compras funciona!"
