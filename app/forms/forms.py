from flask_wtf import FlaskForm
from wtforms import SelectField, DecimalField, TextAreaField, SubmitField
from wtforms.validators import DataRequired, NumberRange

class FacturaForm(FlaskForm):
    cliente = SelectField('Cliente', coerce=int, validators=[DataRequired()])
    iva = DecimalField('IVA (%)', default=12.0, validators=[DataRequired(), NumberRange(min=0, max=100)])
    observaciones = TextAreaField('Observaciones')
    submit = SubmitField('Guardar Factura')
