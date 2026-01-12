# ===================================================
# 📄 app/blueprints/clientes/routes.py
# Módulo Clientes - Solo Registro de Nuevo Cliente
# ===================================================

from flask import Blueprint, render_template, request, redirect, url_for, flash, jsonify
from app.extensions import db
from datetime import datetime
from sqlalchemy.exc import IntegrityError
from app.models import Cliente, HistorialAuditoria
from app.forms.cliente_form import ClienteForm

# Simulación temporal de current_user y login_required
class MockUser:
    id = 1
    is_authenticated = True

current_user = MockUser()

def login_required(f):
    return f

# -------------------------------------------------------------------------
clientes_bp = Blueprint(
    'clientes',
    __name__,
    template_folder='templates',
    url_prefix='/clientes'
)

# ===================================================
# 📌 RUTA: REGISTRO DE NUEVO CLIENTE
# ===================================================
@clientes_bp.route('/registrar', methods=['GET', 'POST'])
def registrar_cliente():
    """
    Muestra el formulario y procesa la creación de un nuevo Cliente.
    Compatible con envío AJAX (JSON) o envío tradicional (HTML).
    """
    form = ClienteForm()

    # Si se envía el formulario (POST)
    if request.method == 'POST':
        if form.validate_on_submit():
            try:
                nuevo = Cliente(
                    tipo_identificacion=form.tipo_identificacion.data,
                    ruc_ci=form.ruc_ci.data,
                    nombre_razon_social=form.nombre_razon_social.data,
                    correo=form.correo.data,
                    telefono=form.telefono.data,
                    direccion=form.direccion.data,
                    condicion_comercial=form.condicion_comercial.data,
                    limite_credito=form.limite_credito.data,
                    estado=True,
                    fecha_registro=datetime.utcnow()
                )

                db.session.add(nuevo)
                db.session.flush()

                # Registrar en auditoría
                auditoria = HistorialAuditoria(
                    usuario_id=current_user.id,
                    nombre_reporte=f"Creación Cliente ID:{nuevo.id_cliente} - RUC:{nuevo.ruc_ci}",
                    tipo_reporte="EVENTO",
                    fecha_generacion=datetime.utcnow()
                )
                db.session.add(auditoria)
                db.session.commit()

                # Si es una petición AJAX → responder con JSON
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return jsonify({
                        'success': True,
                        'message': 'Cliente registrado correctamente.'
                    }), 200

                # Si es una petición normal → redirigir
                return redirect(url_for('main.home'))

            except IntegrityError:
                db.session.rollback()
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return jsonify({
                        'success': False,
                        'message': 'Ya existe un cliente con ese RUC/Identificación.'
                    }), 400
                else:
                    flash('Error: Ya existe un cliente con ese RUC/Identificación.', 'danger')

            except Exception as e:
                db.session.rollback()
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return jsonify({
                        'success': False,
                        'message': f'Error inesperado: {str(e)}'
                    }), 500
                else:
                    flash(f'Error al registrar cliente: {str(e)}', 'danger')

        else:
            # Errores de validación
            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                return jsonify({
                    'success': False,
                    'errors': form.errors
                }), 400

    # Si es GET → mostrar el formulario normal
    return render_template(
        'clientes/registrar_cliente.html',
        form=form,
        titulo='Registrar Nuevo Cliente'
    )
