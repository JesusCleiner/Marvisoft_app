# ===================================================
# 📄 app/blueprints/proveedores/routes.py
# Módulo Proveedores - Registro de Nuevo Proveedor
# ===================================================

from flask import Blueprint, render_template, request, redirect, url_for, flash, jsonify
from app.extensions import db
from datetime import datetime
from sqlalchemy.exc import IntegrityError
from app.models import Proveedor, HistorialAuditoria
from app.forms.proveedor_form import ProveedorForm

# Simulación de usuario autenticado
class MockUser:
    id = 1
current_user = MockUser()

proveedores_bp = Blueprint(
    'proveedores',
    __name__,
    template_folder='templates',
    url_prefix='/proveedores'
)

# ===================================================
# 📌 Registrar nuevo proveedor
# ===================================================
@proveedores_bp.route('/registrar', methods=['GET', 'POST'])
def registrar_proveedor():
    form = ProveedorForm()

    if request.method == 'POST' and form.validate_on_submit():
        try:
            nuevo = Proveedor(
                ruc=form.ruc.data,
                nombre=form.nombre.data,
                direccion=form.direccion.data,
                telefono=form.telefono.data,
                correo=form.correo.data,
                tipo_proveedor=form.tipo_proveedor.data,
                condicion_pago=form.condicion_pago.data,
                limite_credito=form.limite_credito.data,
                estado=True,
                fecha_registro=datetime.utcnow()
            )

            db.session.add(nuevo)
            db.session.flush()

            auditoria = HistorialAuditoria(
                usuario_id=current_user.id,
                nombre_reporte=f"Creación Proveedor ID:{nuevo.id_proveedor} - RUC:{nuevo.ruc}",
                tipo_reporte="EVENTO",
                fecha_generacion=datetime.utcnow()
            )
            db.session.add(auditoria)
            db.session.commit()

            flash('Proveedor registrado correctamente.', 'success')
            return redirect(url_for('main.home'))

        except IntegrityError:
            db.session.rollback()
            flash('Error: Ya existe un proveedor con ese RUC.', 'danger')
        except Exception as e:
            db.session.rollback()
            flash(f'Error al registrar proveedor: {str(e)}', 'danger')

    return render_template(
        'proveedores/registrar_proveedor.html',
        form=form,
        titulo='Registrar Nuevo Proveedor'
    )
