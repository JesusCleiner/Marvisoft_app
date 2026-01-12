from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, DecimalField, IntegerField, SubmitField
from wtforms.validators import DataRequired, Length, Optional, Regexp, NumberRange, Email

class ProveedorForm(FlaskForm):
    """
    Formulario para registrar o editar proveedores.
    """

    ruc = StringField(
        'RUC / Cédula',
        validators=[
            DataRequired('El RUC o Cédula es obligatorio.'),
            Length(min=10, max=13, message='Debe tener entre 10 y 13 dígitos.'),
            Regexp(r'^\d{10,13}$', message='Solo se permiten números.')
        ]
    )

    nombre = StringField(
        'Razón Social / Nombre Comercial',
        validators=[DataRequired('El nombre es obligatorio.'), Length(max=255)]
    )

    direccion = StringField(
        'Dirección Principal',
        validators=[Optional(), Length(max=255)]
    )

    telefono = StringField(
        'Teléfono',
        validators=[
            Optional(),
            Regexp(r'^\+?[\d\s-]{7,}$', message='Formato de teléfono no válido.'),
            Length(max=50)
        ]
    )

    contacto = StringField(
        'Nombre de Contacto',
        validators=[Optional(), Length(max=100)]
    )

    correo = StringField(
        'Correo Electrónico',
        validators=[
            Optional(),
            Email(message='Debe ingresar un correo electrónico válido.'),
            Length(max=120)
        ]
    )

    tipo_proveedor = SelectField(
        'Tipo de Proveedor',
        choices=[
            ('', '-- Seleccione --'),
            ('LOCAL', 'Local'),
            ('EXTRANJERO', 'Extranjero'),
        ],
        validators=[DataRequired('Debe seleccionar el tipo de proveedor.')]
    )

    tipo_pago = SelectField(
        'Tipo de Pago',
        choices=[
            ('', '-- Seleccione --'),
            ('CONTADO', 'Contado'),
            ('CREDITO', 'Crédito'),
            ('PREPAGO', 'Prepago'),
        ],
        validators=[DataRequired('Debe seleccionar el tipo de pago.')]
    )

    tiempo_credito = IntegerField(
        'Tiempo de Crédito (días)',
        validators=[Optional(), NumberRange(min=0, max=365, message='Ingrese un valor válido entre 0 y 365.')]
    )

    limite_credito = DecimalField(
        'Límite de Crédito (USD)',
        validators=[Optional(), NumberRange(min=0)],
        places=2
    )

    estado = SelectField(
        'Estado',
        choices=[
            ('ACTIVO', 'Activo'),
            ('INACTIVO', 'Inactivo'),
        ],
        default='ACTIVO',
        validators=[DataRequired()]
    )

    submit = SubmitField('Guardar Proveedor')
