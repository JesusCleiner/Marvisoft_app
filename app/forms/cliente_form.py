from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, SubmitField, DecimalField, DateTimeField
from wtforms.validators import DataRequired, Length, Optional, Regexp, NumberRange
from datetime import datetime

class ClienteForm(FlaskForm):
    """
    Formulario para la creación y edición de Clientes.
    """

    # 1. Información de Identificación y Contacto
    ruc = StringField(
        'RUC / Cédula',
        validators=[
            DataRequired('El RUC o Cédula es obligatorio.'),
            Length(min=10, max=13, message='El RUC debe tener 10 o 13 dígitos.'),
            Regexp(r'^\d{10,13}$', message='El RUC/Cédula solo debe contener números.')
        ],
        description='Ingrese el RUC (13 dígitos) o la Cédula (10 dígitos).'
    )

    nombre = StringField(
        'Razón Social / Nombre Completo',
        validators=[
            DataRequired('El nombre o razón social es obligatorio.'),
            Length(max=255)
        ]
    )

    direccion = StringField(
        'Dirección Principal',
        validators=[
            DataRequired('La dirección es obligatoria.'),
            Length(max=255)
        ]
    )

    telefono = StringField(
        'Teléfono',
        validators=[
            Optional(),
            Regexp(r'^\+?[\d\s-]{7,}$', message='Formato de teléfono no válido.'),
            Length(max=50)
        ],
        description='Ej: 0987654321'
    )

    correo = StringField(
        'Correo Electrónico',
        validators=[
            Optional(),
            Length(max=120)
        ],
        description='Opcional. Para envío de documentos electrónicos.'
    )

    tipo_contribuyente = SelectField(
        'Tipo de Contribuyente',
        choices=[
            ('', '-- Seleccione --'),
            ('NATURAL', 'Persona Natural'),
            ('JURIDICA', 'Persona Jurídica (Empresa)'),
            ('CONSUMIDOR_FINAL', 'Consumidor Final (Si aplica)'),
        ],
        validators=[
            DataRequired('Debe seleccionar el tipo de contribuyente.')
        ]
    )

    # 2. Condición Comercial
    condicion_comercial = SelectField(
        'Condición Comercial',
        choices=[
            ('', '-- Seleccione --'),
            ('CONTADO', 'Contado'),
            ('CREDITO', 'Crédito'),
            ('PREPAGO', 'Prepago')
        ],
        validators=[
            DataRequired('Debe seleccionar la condición comercial.')
        ]
    )

    # 3. Límite de Crédito
    limite_credito = DecimalField(
        'Límite de Crédito (USD)',
        validators=[
            Optional(),
            NumberRange(min=0, message='El monto debe ser positivo.')
        ],
        places=2,
        description='Ingrese el monto máximo de crédito en dólares.'
    )

    # 4. Fecha y Hora de Creación (solo lectura)
    fecha_creacion = DateTimeField(
        'Fecha y Hora de Creación',
        default=datetime.now,
        format='%Y-%m-%d %H:%M:%S',
        render_kw={'readonly': True}
    )

    # Botón de envío
    submit = SubmitField('Guardar Cliente')
