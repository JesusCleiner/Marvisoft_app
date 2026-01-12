from flask_wtf import FlaskForm
from wtforms import SelectField, StringField, TextAreaField, SubmitField, DateField, DecimalField, IntegerField
from wtforms.validators import DataRequired, NumberRange
from datetime import date

class FacturaForm(FlaskForm):
    """
    Formulario para crear una nueva factura externa.
    """
    
    # Número de factura
    numero_factura = StringField(
        'Número de Factura',
        validators=[DataRequired(message="Debe ingresar el número de factura")]
    )
    
    # Fecha de la factura
    fecha = DateField(
        'Fecha de Factura',
        default=date.today,
        format='%Y-%m-%d',
        validators=[DataRequired(message="Debe ingresar una fecha válida")]
    )
    
    # Cliente (SelectField con choices cargados dinámicamente desde routes.py)
    cliente = SelectField(
        'Cliente',
        coerce=int,
        validators=[DataRequired(message="Debe seleccionar un cliente")]
    )
    
    # === CAMPOS DEL CLIENTE PARA FACTURACIÓN (AGREGADOS) ===
    # Estos campos se llenarán mediante JavaScript y serán de solo lectura
    # El ID es crucial para que el JS sepa dónde escribir la información
    ruc_ci = StringField(
        'RUC/CI',
        render_kw={'readonly': True, 'id': 'cliente-ruc-ci'}
    )
    direccion = StringField(
        'Dirección',
        render_kw={'readonly': True, 'id': 'cliente-direccion'}
    )
    telefono = StringField(
        'Teléfono',
        render_kw={'readonly': True, 'id': 'cliente-telefono'}
    )

    correo = StringField(
        'Correo',
        render_kw={'readonly': True, 'id': 'cliente-correo'}
    )
    # =======================================================
    
    # Observaciones opcionales
    observaciones = TextAreaField(
        'Observaciones',
        render_kw={"placeholder": "Ingrese detalles adicionales si los hay"}
    )
    
    # Campos para productos (solo para validación si quieres enviar al servidor)
    # Estos no se usan directamente, la tabla de JS se encarga de manejar los productos dinámicamente
    producto_id = IntegerField('Producto ID', validators=[NumberRange(min=1)])
    cantidad = DecimalField('Cantidad', places=2, validators=[NumberRange(min=0)])
    precio_unitario = DecimalField('Precio unitario', places=2, validators=[NumberRange(min=0)])
    
    # Botón de envío
    submit = SubmitField('Guardar Factura')