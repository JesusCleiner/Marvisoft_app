from sqlalchemy import text
from app import create_app
from app.extensions import db

app = create_app()

with app.app_context():
    cliente_id = 1
    producto_id = 2

    resultado = db.session.execute(
        text("""
            SELECT precio_acordado
            FROM precios_clientes
            WHERE cliente_id = :cliente_id
              AND producto_id = :producto_id
              AND estado = TRUE
            LIMIT 1
        """),
        {'cliente_id': cliente_id, 'producto_id': producto_id}
    ).fetchone()

    print(resultado)  # ejemplo: (12.3400,)
