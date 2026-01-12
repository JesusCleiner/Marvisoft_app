from flask import Blueprint

despachos_bp = Blueprint('despachos', __name__, url_prefix='/despachos')

@despachos_bp.route('/')
def index():
    return "¡Despachos funciona!"
