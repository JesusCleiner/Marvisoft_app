from .extensions import db
from datetime import datetime
from sqlalchemy import PrimaryKeyConstraint, CheckConstraint
from sqlalchemy.dialects.postgresql import JSON 


# ====================================================
# TABLAS MAESTRAS DEL CORE (Adaptadas)
# ====================================================

# TABLA BASE: ROLES (roles) - Nueva tabla maestra
class Role(db.Model):
    __tablename__ = 'roles'
    
    id_rol = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False, unique=True)
    descripcion = db.Column(db.Text)
    estado = db.Column(db.Boolean, default=True)
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    usuarios = db.relationship('Usuario', backref='rol', lazy=True)

# TABLA 1: USUARIOS (usuarios)
class Usuario(db.Model):
    __tablename__ = 'usuarios'
    
    # --- Clave Primaria (PK) ---
    id_usuario = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    rol_id = db.Column(db.Integer, db.ForeignKey('roles.id_rol'), nullable=False) # FK al nuevo rol
    
    # --- Campos de Datos ---
    nombre = db.Column(db.String(150), nullable=False) 
    usuario = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(150), unique=True)
    password = db.Column(db.String(255), nullable=False) 
    operador_turno = db.Column(db.String(50)) 
    estado = db.Column(db.Boolean, default=True) # Corregido a Boolean
    
    # --- Campos de Auditoría ---
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relaciones: roles (backref='usuarios'), pagos (pagos_factura), cuentas_cobrar/pagar

# TABLA 2: CLIENTES (clientes)
class Cliente(db.Model):
    __tablename__ = 'clientes'
    
    # --- Clave Primaria (PK) ---
    id_cliente = db.Column(db.Integer, primary_key=True)
    
    # --- Campos de Datos ---
    nombre = db.Column(db.String(150), nullable=False)
    ruc = db.Column(db.String(13), unique=True, nullable=False) # ruc
    direccion = db.Column(db.String(250))
    telefono = db.Column(db.String(50))
    correo = db.Column(db.String(100))
    condicion_comercial = db.Column(db.String(50))
    limite_credito = db.Column(db.Numeric(12, 2), default=0)
    estado = db.Column(db.Boolean, default=True) 
    
    # --- Campos de Auditoría ---
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # --- Relaciones ---
    facturas = db.relationship('FacturaVenta', backref='cliente', lazy=True)
    materia_prima_terceros = db.relationship('MateriaPrimaTerceros', backref='cliente', lazy=True)
    cuentas_cobrar = db.relationship('CuentaCobrar', backref='cliente', lazy=True) # Relación a modelo faltante
    ordenes_produccion = db.relationship('OrdenProduccion', backref='cliente_orden', lazy=True)

# TABLA 3: PROVEEDORES (proveedores)
class Proveedor(db.Model):
    __tablename__ = 'proveedores'
    
    # --- Clave Primaria (PK) ---
    id_proveedor = db.Column(db.Integer, primary_key=True)
    
    # --- Campos de Datos ---
    nombre = db.Column(db.String(150), nullable=False)
    ruc = db.Column(db.String(13), unique=True, nullable=False)
    direccion = db.Column(db.String(200))
    telefono = db.Column(db.String(50))
    contacto = db.Column(db.String(200))
    email = db.Column(db.String(100))
    estado = db.Column(db.Boolean, default=True)
    
    # --- Campos de Auditoría ---
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # --- Relaciones ---
    ordenes_compra = db.relationship('OrdenCompra', backref='proveedor', lazy=True)
    facturas_compra = db.relationship('FacturaCompra', backref='proveedor', lazy=True)
    cuentas_pagar = db.relationship('CuentaPagar', backref='proveedor', lazy=True) # Relación a modelo faltante

# TABLA BASE: TRANSPORTISTAS (transportistas) - Nueva tabla
class Transportista(db.Model):
    __tablename__ = 'transportistas'
    
    id_transportista = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), nullable=False)
    ruc = db.Column(db.String(13), unique=True)
    telefono = db.Column(db.String(50))
    direccion = db.Column(db.String(250))
    correo = db.Column(db.String(100))
    estado = db.Column(db.Boolean, default=True)
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    guias_despacho = db.relationship('GuiaDespacho', backref='transportista_guia', lazy=True) # Usando clase original GuiaDespacho
    despachos = db.relationship('Despacho', backref='transportista_despacho', lazy=True) # Usando clase nueva Despacho

# TABLA 22: DATOS EMISOR (datos_emisor) - Clases Originales Mantienen Nombre
class DatosEmisor(db.Model):
    __tablename__ = 'datos_emisor'

    # --- Clave Primaria (PK) ---
    id_emisor = db.Column(db.Integer, primary_key=True)

    # --- Campos de Datos Principales ---
    ruc = db.Column(db.String(13), unique=True, nullable=False)
    razon_social = db.Column(db.String(255), nullable=False)
    nombre_comercial = db.Column(db.String(255))
    direccion_matriz = db.Column(db.String(255), nullable=False)
    sucursal = db.Column(db.String(100))
    direccion_establecimiento = db.Column(db.String(255))
    codigo_establecimiento = db.Column(db.String(3))
    punto_emision = db.Column(db.String(3))
    contribuyente_especial = db.Column(db.String(20))
    obligado_contabilidad = db.Column(db.Boolean, default=False)
    ambiente = db.Column(db.String(10)) # Se usan las descripciones/códigos directos, no la tabla TipoEmision
    tipo_emision = db.Column(db.String(10))
    email_contacto = db.Column(db.String(150))
    telefono = db.Column(db.String(20))
    logo_url = db.Column(db.String(255))
    
    # --- Relaciones ---
    facturas_venta = db.relationship('FacturaVenta', backref='emisor', lazy=True)
    guias_despacho = db.relationship('GuiaDespacho', backref='emisor_guia', lazy=True) # Usando clase original GuiaDespacho

# TABLA 5: PRODUCTOS (producto) - Clases Originales Mantienen Nombre
class Producto(db.Model):
    __tablename__ = 'producto' # La tabla se llama 'producto' en singular
    
    # --- Clave Primaria (PK) ---
    id_producto = db.Column(db.Integer, primary_key=True)
    
    # --- Campos de Datos ---
    codigo_interno = db.Column(db.String(50), unique=True, nullable=False) 
    nombre = db.Column(db.String(150), nullable=False)
    categoria = db.Column(db.String(50), nullable=False) # Nuevo campo
    requiere_trazabilidad = db.Column(db.Boolean, default=False) # Nuevo campo
    capacidad_volumen = db.Column(db.Numeric(10, 2)) # Nuevo campo
    tipo_producto = db.Column(db.String(50)) # MP, PF, etc.
    unidad_medida = db.Column(db.String(20), nullable=False)
    gramaje = db.Column(db.Numeric(10, 2))
    cuello = db.Column(db.String(50))
    color = db.Column(db.String(50))
    stock_minimo = db.Column(db.Numeric(12, 2), default=0)
    estado = db.Column(db.Boolean, default=True) # Corregido a Boolean
    
    # --- Relaciones ---
    # Relación a PrecioVentaHistorico (modelo que faltaba)
    precios_historicos = db.relationship('PrecioVentaHistorico', backref='producto', lazy=True) 

    detalle_compra = db.relationship('DetalleFacturaCompra', backref='producto', lazy=True) # Cambio de clase DetalleCompra -> DetalleFacturaCompra
    detalle_venta = db.relationship('DetalleFacturaVenta', backref='producto', lazy=True) # Cambio de clase DetalleVenta -> DetalleFacturaVenta
    movimientos = db.relationship('MovimientoBodega', backref='producto_movimiento', lazy=True) 
    ordenes_produccion = db.relationship('OrdenProduccion', backref='producto_terminado', lazy=True)

# TABLA BASE: PRECIO VENTA HISTÓRICO (precio_venta_historico) - MODELO FALTANTE (PrecioVentaHistorico)
class PrecioVentaHistorico(db.Model):
    __tablename__ = 'precio_venta_historico'
    id_precio_historico = db.Column(db.Integer, primary_key=True)
    
    # Llave foránea al producto al que aplica este precio
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    
    # Precio unitario registrado
    precio_unitario = db.Column(db.Numeric(10, 4), nullable=False)
    
    # Rango de validez del precio
    fecha_inicio = db.Column(db.Date, default=datetime.now().date(), nullable=False)
    fecha_fin = db.Column(db.Date, nullable=True) # Si es NULL, el precio está vigente indefinidamente
    
    # Campo opcional para referencia o notas
    notas = db.Column(db.String(255), nullable=True)

    def __repr__(self):
        return f"<PrecioVentaHistorico {self.id_precio_historico} - Producto {self.producto_id} - Precio: {self.precio_unitario}>"
    
# TABLA BASE: MATERIA PRIMA TERCEROS (materia_prima_terceros) - Nueva tabla
class MateriaPrimaTerceros(db.Model):
    __tablename__ = 'materia_prima_terceros'

    # --- Clave Primaria (PK) ---
    id_materia_prima_t = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id_cliente'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    
    # --- Campos de Datos ---
    proveedor = db.Column(db.String(150))
    cantidad_entregada = db.Column(db.Numeric(12, 2), nullable=False)
    cantidad_consumida = db.Column(db.Numeric(12, 2), default=0)
    cantidad_disponible = db.Column(db.Numeric(12, 2), nullable=False)
    fecha_ingreso = db.Column(db.Date, default=datetime.utcnow)
    estado = db.Column(db.String(50), nullable=False)
    observacion = db.Column(db.Text)
    
    # --- Relaciones ---
    cajas_preformas = db.relationship('BodegaProduccion', foreign_keys='BodegaProduccion.materia_prima_terceros_id', backref='materia_prima_terceros', lazy=True)
    consumo_materia_prima = db.relationship('ConsumoMateriaPrima', backref='materia_prima_terceros', lazy=True)


# ====================================================
# MÓDULO DE COMPRAS
# ====================================================

# TABLA 7: ORDENES DE COMPRA (ordenes_compra) - Clases Originales Mantienen Nombre
class OrdenCompra(db.Model):
    __tablename__ = 'ordenes_compra'
    
    # --- Clave Primaria (PK) ---
    id_orden_compra = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    proveedor_id = db.Column(db.Integer, db.ForeignKey('proveedores.id_proveedor'), nullable=False)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False) 
    
    # --- Campos de Datos ---
    numero_orden = db.Column(db.String(20), unique=True, nullable=False) 
    fecha_emision = db.Column(db.Date, nullable=False)
    fecha_entrega = db.Column(db.Date)
    estado = db.Column(db.String(20), nullable=False)
    total = db.Column(db.Numeric(12, 2), default=0)
    observaciones = db.Column(db.Text)
    
    # --- Relaciones ---
    facturas = db.relationship('FacturaCompra', backref='orden_compra', lazy=True)
    detalle = db.relationship('DetalleOrdenCompra', backref='orden_compra', lazy=True)

# TABLA 9: DETALLE DE ORDEN DE COMPRA (detalle_orden_compra) - Clases Originales Mantienen Nombre
class DetalleOrdenCompra(db.Model):
    __tablename__ = 'detalle_orden_compra'
    
    # --- Clave Primaria (PK) ---
    id_detalle_orden_compra = db.Column(db.Integer, primary_key=True) 
    
    # --- Claves Foráneas (FK) ---
    orden_id = db.Column(db.Integer, db.ForeignKey('ordenes_compra.id_orden_compra', ondelete='CASCADE'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto', ondelete='RESTRICT'), nullable=False)
    
    # --- Clave Primaria (Configuración Compuesta) ---
    __table_args__ = (
        db.UniqueConstraint('orden_id', 'producto_id', name='uc_orden_producto'),
    )

    # --- Campos de Datos ---
    cantidad = db.Column(db.Numeric(12, 2), nullable=False) 
    precio_unitario = db.Column(db.Numeric(12, 2), nullable=False) 
    subtotal = db.Column(db.Numeric(12, 2), nullable=False) 

# TABLA 8: FACTURAS DE COMPRA (factura_compra) - Clases Originales Mantienen Nombre
class FacturaCompra(db.Model):
    __tablename__ = 'factura_compra' # Nombre singular en la BD final
    
    # --- Clave Primaria (PK) ---
    id_factura = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    proveedor_id = db.Column(db.Integer, db.ForeignKey('proveedores.id_proveedor'), nullable=False) 
    orden_compra_id = db.Column(db.Integer, db.ForeignKey('ordenes_compra.id_orden_compra')) 
    
    # --- Campos de Datos ---
    numero_factura = db.Column(db.String(50), nullable=False)
    fecha_emision = db.Column(db.Date, nullable=False)
    fecha_vencimiento = db.Column(db.Date)
    fecha_pago = db.Column(db.Date)
    subtotal = db.Column(db.Numeric(12, 2), nullable=False)
    impuesto = db.Column(db.Numeric(12, 2), default=0) # Corregido
    total_pagar = db.Column(db.Numeric(12, 2), nullable=False) 
    estado_pago = db.Column(db.String(50), nullable=False) 
    tipo = db.Column(db.String(50)) 
    observaciones = db.Column(db.Text) 

    # --- Restricción de Unicidad (para SQLA) ---
    __table_args__ = (
        db.UniqueConstraint('proveedor_id', 'numero_factura', name='uc_factura_proveedor'),
    )
    
    # --- Relaciones ---
    lotes = db.relationship('Lote', backref='factura_compra', lazy=True) # Llama a la clase Lote
    detalle = db.relationship('DetalleFacturaCompra', backref='factura_compra', lazy=True) # Llama a la clase DetalleCompra

# TABLA 10: DETALLE DE COMPRA (detalle_factura_compra) - Mantiene el nombre de clase original
class DetalleFacturaCompra(db.Model):
    __tablename__ = 'detalle_factura_compra' # Nombre real de la tabla
    
    # --- Clave Primaria (PK) ---
    id_detalle = db.Column(db.Integer, primary_key=True)

    # --- Claves Foráneas (FK) ---
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_compra.id_factura', ondelete='CASCADE'), nullable=False) # Nombre de FK corregido
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto', ondelete='RESTRICT'), nullable=False)
    lote_id = db.Column(db.Integer, db.ForeignKey('lotes_compra.id_lote_mp')) # Agregado FK a lote
    
    # --- Campos de Datos ---
    cantidad = db.Column(db.Numeric(12, 2), nullable=False)
    precio_unitario = db.Column(db.Numeric(12, 2), nullable=False)
    subtota_por_items = db.Column(db.Numeric(12, 2), nullable=False) # Columna corregida

# TABLA 4: LOTES DE COMPRAS (lotes_compra) - Mantiene el nombre de clase original
class Lote(db.Model):
    __tablename__ = 'lotes_compra'

    # --- Clave Primaria (PK) ---
    id_lote_mp = db.Column(db.Integer, primary_key=True) # PK corregida
    
    # --- Claves Foráneas (FK) ---
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_compra.id_factura'), nullable=False) # FK a la factura
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False) 
    
    # --- Campos de Datos ---
    codigo_lote = db.Column(db.String(50), unique=True, nullable=False)
    proveedor_lote_referencia = db.Column(db.String(50))
    cantidad_ingreso = db.Column(db.Numeric(12, 2), nullable=False)
    cantidad_disponible = db.Column(db.Numeric(12, 2), nullable=False)
    fecha_ingreso = db.Column(db.Date, default=datetime.utcnow)
    estado_lote = db.Column(db.String(50), nullable=False)
    
    # --- Relaciones ---
    cajas_preformas = db.relationship('BodegaProduccion', foreign_keys='BodegaProduccion.lote_compra_id', backref='lote_compra', lazy=True) # Usa la clase BodegaProduccion

# TABLA BASE: GUÍA REMISIÓN COMPRA (guia_remision_compra) - Nueva tabla
class GuiaRemisionCompra(db.Model):
    __tablename__ = 'guia_remision_compra'

    id_guia_remision_c = db.Column(db.Integer, primary_key=True)
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_compra.id_factura', ondelete='CASCADE'), nullable=False, unique=True)
    numero_guia = db.Column(db.String(50), nullable=False, unique=True)
    fecha_emision = db.Column(db.Date, nullable=False)
    estado = db.Column(db.String(50), nullable=False)
    observaciones = db.Column(db.Text)

# ====================================================
# MÓDULO DE PRODUCCIÓN
# ====================================================

# TABLA 16: ORDENES DE PRODUCCIÓN (orden_produccion) - Clases Originales Mantienen Nombre
class OrdenProduccion(db.Model):
    __tablename__ = 'orden_produccion'
    
    # --- Clave Primaria (PK) ---
    id_orden_produccion = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    producto_terminado_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False) 
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id_cliente')) # Nuevo campo FK
    
    # --- Campos de Datos ---
    numero_op = db.Column(db.String(20), unique=True, nullable=False)
    tipo_orden = db.Column(db.String(50), nullable=False) # Nuevo campo
    fecha_inicio = db.Column(db.Date, nullable=False)
    fecha_fin = db.Column(db.Date)
    cantidad_programada = db.Column(db.Numeric(12, 2), nullable=False)
    turno = db.Column(db.String(50))
    estado = db.Column(db.String(50), nullable=False)
    observaciones = db.Column(db.Text)
    
    # --- Relaciones ---
    consumos = db.relationship('ConsumoMateriaPrima', backref='orden_produccion', lazy=True)
    lotes_produccion = db.relationship('LoteProduccion', backref='orden_produccion', lazy=True)

# TABLA BASE: CONSUMO MATERIA PRIMA (consumo_materia_prima) - Nueva tabla
class ConsumoMateriaPrima(db.Model):
    __tablename__ = 'consumo_materia_prima'

    # --- Clave Primaria (PK) ---
    id_consumo = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    orden_id = db.Column(db.Integer, db.ForeignKey('orden_produccion.id_orden_produccion'), nullable=False)
    caja_id = db.Column(db.Integer, db.ForeignKey('caja_preformas.id_caja_preforma'))
    materia_prima_terceros_id = db.Column(db.Integer, db.ForeignKey('materia_prima_terceros.id_materia_prima_t'))
    
    # --- Campos de Datos ---
    tipo_materia_prima = db.Column(db.String(50), nullable=False)
    cantidad = db.Column(db.Numeric(12, 2), nullable=False)
    fecha_consumo = db.Column(db.DateTime, default=datetime.utcnow)
    observaciones = db.Column(db.Text)
    
# TABLA BASE: LOTE PRODUCCIÓN (lote_produccion) - Nueva tabla
class LoteProduccion(db.Model):
    __tablename__ = 'lote_produccion'

    # --- Clave Primaria (PK) ---
    id_lote_pt = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    orden_id = db.Column(db.Integer, db.ForeignKey('orden_produccion.id_orden_produccion'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    
    # --- Campos de Datos ---
    cantidad = db.Column(db.Numeric(12, 2), nullable=False)
    fecha_produccion = db.Column(db.Date, default=datetime.utcnow)
    turno = db.Column(db.String(50))
    estado = db.Column(db.String(50), nullable=False)
    
    # --- Relaciones ---
    perdidas = db.relationship('PerdidasProduccion', backref='lote_produccion', lazy=True)
    detalle_factura_venta = db.relationship('DetalleFacturaVenta', backref='lote_produccion', lazy=True) # Relación con DetalleFacturaVenta
    movimientos_bodega = db.relationship('MovimientoBodega', foreign_keys='MovimientoBodega.lote_produccion_id', backref='lote_pt', lazy=True)

# TABLA BASE: PÉRDIDAS PRODUCCIÓN (perdidas_produccion) - Nueva tabla
class PerdidasProduccion(db.Model):
    __tablename__ = 'perdidas_produccion'

    # --- Clave Primaria (PK) ---
    id_perdida = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    lote_id = db.Column(db.Integer, db.ForeignKey('lote_produccion.id_lote_pt'), nullable=False)
    
    # --- Campos de Datos ---
    tolerancia_aplicada = db.Column(db.Boolean, default=False)
    cantidad = db.Column(db.Numeric(12, 2), nullable=False)
    tipo = db.Column(db.String(50))
    fecha = db.Column(db.DateTime, default=datetime.utcnow)
    observaciones = db.Column(db.Text)


# TABLA 17: BODEGA PRODUCCIÓN (caja_preformas) - Mantiene el nombre de clase original
class BodegaProduccion(db.Model):
    __tablename__ = 'caja_preformas' # Nombre real de la tabla (CajaPreforma)
    
    # --- Clave Primaria (PK) ---
    id_caja_preforma = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    lote_compra_id = db.Column(db.Integer, db.ForeignKey('lotes_compra.id_lote_mp')) # Stock Propio (FK a Lote)
    materia_prima_terceros_id = db.Column(db.Integer, db.ForeignKey('materia_prima_terceros.id_materia_prima_t')) # Stock de Terceros (Nuevo FK)
    
    # --- Campos de Datos ---
    numero_caja = db.Column(db.String(50), nullable=False, unique=True)
    cantidad = db.Column(db.Integer, nullable=False)
    fecha_ingreso = db.Column(db.Date, default=datetime.utcnow)
    observacion = db.Column(db.Text)
    
    # --- Relaciones ---
    movimientos_inventario = db.relationship('MovimientoBodega', backref='registro_bodega', lazy=True) # Usa la clase MovimientoBodega


# ====================================================
# MÓDULO DE VENTAS Y LOGÍSTICA
# ====================================================

# TABLA 11: FACTURAS DE VENTA (factura_venta) - Clases Originales Mantienen Nombre
class FacturaVenta(db.Model):
    __tablename__ = 'factura_venta' # Nombre singular en la BD final
    
    # --- Clave Primaria (PK) ---
    id_factura = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id_cliente'), nullable=False)
    emisor_id = db.Column(db.Integer, db.ForeignKey('datos_emisor.id_emisor'), nullable=False) # Nuevo FK
    
    # --- Campos de Datos de Cabecera y Montos ---
    numero_autorizacion_sri = db.Column(db.String(50), unique=True)
    serie = db.Column(db.String(20), nullable=False) # Nueva columna
    numero_factura = db.Column(db.String(20), nullable=False) # Nueva columna
    
    fecha_emision = db.Column(db.Date, nullable=False)
    fecha_pago = db.Column(db.Date)
    tipo_venta = db.Column(db.String(50)) # Nueva columna
    subtotal = db.Column(db.Numeric(12, 2), nullable=False)
    iva = db.Column(db.Numeric(12, 2), default=0) # Corregido
    ice = db.Column(db.Numeric(12, 2), default=0) # Nuevo
    otros_impuestos = db.Column(db.Numeric(12, 2), default=0) # Nuevo
    total = db.Column(db.Numeric(12, 2), nullable=False) 
    estado = db.Column(db.String(50), nullable=False)
    moneda = db.Column(db.String(10), default='USD') # Nuevo
    observaciones = db.Column(db.Text) # Nuevo
    
    # --- Restricción de Unicidad (para SQLA) ---
    __table_args__ = (
        db.UniqueConstraint('serie', 'numero_factura', name='uc_serie_numero'),
    )

    # --- Relaciones ---
    detalle_venta = db.relationship('DetalleFacturaVenta', backref='factura_venta', lazy=True) # Usa la clase DetalleFacturaVenta
    compromisos = db.relationship('CompromisoVenta', backref='factura_venta', lazy=True) # Nueva relación

# TABLA 12: DETALLE VENTA (detalle_factura_venta) - Mantiene el nombre de clase original
class DetalleFacturaVenta(db.Model):
    __tablename__ = 'detalle_factura_venta' # Nombre real de la tabla
    
    # --- Clave Primaria (PK) ---
    id_detalle = db.Column(db.Integer, primary_key=True) # Nueva PK simple
    
    # --- Claves Foráneas (FK) ---
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_venta.id_factura', ondelete='CASCADE'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto', ondelete='RESTRICT'), nullable=False)
    lote_produccion_id = db.Column(db.Integer, db.ForeignKey('lote_produccion.id_lote_pt', ondelete='RESTRICT'), nullable=False) # Nuevo FK

    # --- Campos de Datos ---
    cantidad_unidades = db.Column(db.Numeric(12, 2), nullable=False) # Corregido
    cantidad_bultos = db.Column(db.Numeric(12, 2)) # Nuevo
    precio_unitario = db.Column(db.Numeric(12, 2), nullable=False)
    descuento = db.Column(db.Numeric(12, 2), default=0) # Nuevo
    subtotal = db.Column(db.Numeric(12, 2), nullable=False)

# TABLA BASE: COMPROMISOS VENTA (compromisos_venta) - Nueva tabla
class CompromisoVenta(db.Model):
    __tablename__ = 'compromisos_venta'

    # --- Clave Primaria (PK) ---
    id_compromiso = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_venta.id_factura'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    
    # --- Campos de Datos ---
    cantidad_total = db.Column(db.Numeric(12, 2), nullable=False)
    cantidad_entregada = db.Column(db.Numeric(12, 2), default=0)
    saldo_pendiente = db.Column(db.Numeric(12, 2), nullable=False)
    estado = db.Column(db.String(50), nullable=False)
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # --- Relaciones ---
    guias_despacho = db.relationship('GuiaDespacho', backref='compromiso_venta', lazy=True) # Relación con GuiaDespacho (nombre de clase original)
    cruce_stock = db.relationship('CruceStockEmergencia', backref='compromiso_venta', lazy=True) # Nueva relación

# TABLA 19: GUÍAS DE DESPACHO (guia_despacho_venta) - Mantiene el nombre de clase original
class GuiaDespacho(db.Model):
    __tablename__ = 'guia_despacho_venta' # Nombre real de la tabla (GuiaDespachoVenta)
    
    # --- Clave Primaria (PK) ---
    id_guia_despacho_v = db.Column(db.Integer, primary_key=True) 
    
    # --- Claves Foráneas (FK) ---
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_venta.id_factura'), nullable=False) 
    emisor_id = db.Column(db.Integer, db.ForeignKey('datos_emisor.id_emisor'), nullable=False) # Nuevo FK
    transportista_id = db.Column(db.Integer, db.ForeignKey('transportistas.id_transportista')) # Nuevo FK
    compromiso_id = db.Column(db.Integer, db.ForeignKey('compromisos_venta.id_compromiso')) # Nuevo FK
    
    # --- Campos de Datos ---
    fecha_emision = db.Column(db.Date, nullable=False)
    unidades_totales = db.Column(db.Numeric(12, 2), default=0) # Nuevo
    bultos_totales = db.Column(db.Numeric(12, 2), default=0) # Nuevo
    estado = db.Column(db.String(50), nullable=False)
    observaciones = db.Column(db.Text)
    
    # --- Relaciones ---
    despacho = db.relationship('Despacho', backref='guia_despacho', uselist=False, lazy=True) # Relación con la nueva tabla Despacho

# TABLA BASE: CRUCE STOCK EMERGENCIA (cruce_stock_emergencia) - Nueva tabla
class CruceStockEmergencia(db.Model):
    __tablename__ = 'cruce_stock_emergencia'

    # --- Clave Primaria (PK) ---
    id_cruce_stock = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    compromiso_id = db.Column(db.Integer, db.ForeignKey('compromisos_venta.id_compromiso'), nullable=False)
    lote_id = db.Column(db.Integer, db.ForeignKey('lote_produccion.id_lote_pt'), nullable=False)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)
    
    # --- Campos de Datos ---
    cantidad = db.Column(db.Numeric(12, 2), nullable=False)
    fecha = db.Column(db.DateTime, default=datetime.utcnow)

# TABLA BASE: DESPACHOS (despachos) - Nueva tabla
class Despacho(db.Model):
    __tablename__ = 'despachos'

    # --- Clave Primaria (PK) ---
    id_despacho = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    guia_id = db.Column(db.Integer, db.ForeignKey('guia_despacho_venta.id_guia_despacho_v'), nullable=False)
    transportista_id = db.Column(db.Integer, db.ForeignKey('transportistas.id_transportista'))
    
    # --- Campos de Datos ---
    fecha_salida = db.Column(db.DateTime, nullable=False)
    fecha_entrega = db.Column(db.DateTime)
    estado = db.Column(db.String(50), nullable=False)
    observaciones = db.Column(db.Text)
    
    # --- Relaciones ---
    detalle = db.relationship('DetalleGuia', backref='despacho', lazy=True) # Relación con DetalleGuia (nombre de clase original)

# TABLA 20: DETALLE GUÍA (detalle_despacho) - Mantiene el nombre de clase original
class DetalleGuia(db.Model):
    __tablename__ = 'detalle_despacho' # Nombre real de la tabla
    
    # --- Clave Primaria (PK) ---
    id_detalle_despacho = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    despacho_id = db.Column(db.Integer, db.ForeignKey('despachos.id_despacho', ondelete='CASCADE'), nullable=False)
    compromiso_id = db.Column(db.Integer, db.ForeignKey('compromisos_venta.id_compromiso', ondelete='RESTRICT'), nullable=False) # Nuevo FK
    lote_produccion_id = db.Column(db.Integer, db.ForeignKey('lote_produccion.id_lote_pt', ondelete='RESTRICT'), nullable=False) # Nuevo FK
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto', ondelete='RESTRICT'), nullable=False)
    
    # --- Campos de Datos ---
    cantidad_unidades = db.Column(db.Numeric(12, 2), nullable=False)
    cantidad_bultos = db.Column(db.Numeric(12, 2), nullable=False) # Nuevo

# TABLA BASE: DEVOLUCIONES CLIENTE (devoluciones_cliente) - Nueva tabla
class DevolucionCliente(db.Model):
    __tablename__ = 'devoluciones_cliente'

    # --- Clave Primaria (PK) ---
    id_devolucion_c = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    despacho_id = db.Column(db.Integer, db.ForeignKey('despachos.id_despacho'), nullable=False)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id_cliente'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_venta.id_factura'))
    
    # --- Campos de Datos ---
    cantidad_unidades = db.Column(db.Numeric(12, 2), nullable=False)
    cantidad_bultos = db.Column(db.Numeric(12, 2), nullable=False)
    motivo = db.Column(db.String(150))
    destino = db.Column(db.String(50), nullable=False)
    fecha = db.Column(db.DateTime, default=datetime.utcnow)
    id_camion = db.Column(db.String(50))
    
    # --- Relaciones --- 
    devoluciones_qc = db.relationship('DevolucionQC', backref='devolucion_cliente', lazy=True) # Relación con la nueva tabla

# TABLA BASE: DEVOLUCIÓN CONTROL CALIDAD (devolucion_qc) - MODELO FALTANTE (DevolucionQC)
class DevolucionQC(db.Model):
    __tablename__ = 'devolucion_qc'
    
    # --- Clave Primaria (PK) ---
    id_devolucion_qc = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    devolucion_cliente_id = db.Column(db.Integer, db.ForeignKey('devoluciones_cliente.id_devolucion_c'), nullable=False)
    usuario_qc_id = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)
    
    # --- Campos de Datos ---
    cantidad_aprobada = db.Column(db.Numeric(12, 2), default=0)
    cantidad_rechazada = db.Column(db.Numeric(12, 2), default=0)
    motivo_rechazo = db.Column(db.Text)
    fecha_inspeccion = db.Column(db.DateTime, default=datetime.utcnow)
    destino_final = db.Column(db.String(50)) # Bodega, Scrap, etc.


# TABLA BASE: FACTURA TRANSPORTE (factura_transporte) - Nueva tabla
class FacturaTransporte(db.Model):
    __tablename__ = 'factura_transporte'

    # --- Clave Primaria (PK) ---
    id_factura_transporte = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    transportista_id = db.Column(db.Integer, db.ForeignKey('transportistas.id_transportista'), nullable=False)
    despacho_id = db.Column(db.Integer, db.ForeignKey('despachos.id_despacho'))
    
    # --- Campos de Datos ---
    fecha_emision = db.Column(db.Date, nullable=False)
    fecha_pago = db.Column(db.Date)
    subtotal = db.Column(db.Numeric(12, 2), nullable=False)
    iva = db.Column(db.Numeric(12, 2), default=0)
    total = db.Column(db.Numeric(12, 2), nullable=False)
    observaciones = db.Column(db.Text)
    estado = db.Column(db.String(50), nullable=False)
    
    # --- Relaciones ---
    cuenta_pagar = db.relationship('CuentaPagar', backref='factura_transporte', uselist=False, lazy=True) # Nueva relación

# TABLA 18: MOVIMIENTOS DE BODEGA (movimiento_bodega) - Clases Originales Mantienen Nombre
class MovimientoBodega(db.Model):
    __tablename__ = 'movimiento_bodega'
    
    # --- Clave Primaria (PK) ---
    id_movimiento = db.Column(db.Integer, primary_key=True) 
    
    # --- Claves Foráneas (FK) ---
    producto_id = db.Column(db.Integer, db.ForeignKey('producto.id_producto'), nullable=False)
    lote_id = db.Column(db.Integer, db.ForeignKey('lotes_compra.id_lote_mp')) # FK para Lote MP
    lote_produccion_id = db.Column(db.Integer, db.ForeignKey('lote_produccion.id_lote_pt')) # Nuevo FK para Lote PT
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)
    
    # Nuevos FK para Caja de Preformas
    caja_preforma_id = db.Column(db.Integer, db.ForeignKey('caja_preformas.id_caja_preforma')) 

    # --- Campos de Datos ---
    tipo_movimiento = db.Column(db.String(50), nullable=False) # INGRESO, EGRESO, TRANSFERENCIA
    cantidad = db.Column(db.Numeric(12, 2), nullable=False)
    bodega_origen = db.Column(db.String(50))
    bodega_destino = db.Column(db.String(50))
    fecha_movimiento = db.Column(db.DateTime, default=datetime.utcnow)
    referencia_documento = db.Column(db.String(100)) # Factura, Guía, OP, etc.


# ====================================================
# MÓDULO DE CONTABILIDAD Y FINANZAS
# ====================================================

# TABLA BASE: CUENTAS POR COBRAR (cuentas_cobrar) - MODELO FALTANTE (CuentaCobrar)
class CuentaCobrar(db.Model):
    __tablename__ = 'cuentas_cobrar'

    # --- Clave Primaria (PK) ---
    id_cuenta_cobrar = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id_cliente'), nullable=False)
    factura_id = db.Column(db.Integer, db.ForeignKey('factura_venta.id_factura'), nullable=False, unique=True) # Una CC por Factura
    
    # --- Campos de Datos ---
    monto_original = db.Column(db.Numeric(12, 2), nullable=False)
    saldo_pendiente = db.Column(db.Numeric(12, 2), nullable=False)
    fecha_vencimiento = db.Column(db.Date, nullable=False)
    estado = db.Column(db.String(50), nullable=False) # Pendiente, Parcialmente Pagada, Pagada, Vencida
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)

    # --- Relaciones ---
    # pagos = db.relationship('PagoVenta', backref='cuenta_cobrar', lazy=True) # Si existe un modelo de pagos

# TABLA BASE: CUENTAS POR PAGAR (cuentas_pagar) - MODELO FALTANTE (CuentaPagar)
class CuentaPagar(db.Model):
    __tablename__ = 'cuentas_pagar'

    # --- Clave Primaria (PK) ---
    id_cuenta_pagar = db.Column(db.Integer, primary_key=True)
    
    # --- Claves Foráneas (FK) ---
    proveedor_id = db.Column(db.Integer, db.ForeignKey('proveedores.id_proveedor')) # Para Facturas de Compra
    factura_compra_id = db.Column(db.Integer, db.ForeignKey('factura_compra.id_factura'), unique=True) # FK opcional
    
    # Nuevo FK para facturas de transporte
    factura_transporte_id = db.Column(db.Integer, db.ForeignKey('factura_transporte.id_factura_transporte'), unique=True)
    
    # --- Campos de Datos ---
    tipo_documento = db.Column(db.String(50), nullable=False) # Factura Compra, Factura Transporte, etc.
    monto_original = db.Column(db.Numeric(12, 2), nullable=False)
    saldo_pendiente = db.Column(db.Numeric(12, 2), nullable=False)
    fecha_vencimiento = db.Column(db.Date, nullable=False)
    estado = db.Column(db.String(50), nullable=False) # Pendiente, Parcialmente Pagada, Pagada, Vencida
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    
    # --- Restricción: Debe tener FK a Factura Compra o Factura Transporte
    __table_args__ = (
        CheckConstraint(
            '(factura_compra_id IS NOT NULL AND factura_transporte_id IS NULL) OR (factura_compra_id IS NULL AND factura_transporte_id IS NOT NULL)',
            name='ck_one_factura_type'
        ),
    )
    
    # --- Relaciones ---
    # pagos = db.relationship('PagoCompra', backref='cuenta_pagar', lazy=True) # Si existe un modelo de pagos

# TABLA BASE: HISTORIAL DE AUDITORÍA (historial_auditoria) - MODELO FALTANTE (HistorialAuditoria)
class HistorialAuditoria(db.Model):
    __tablename__ = 'historial_auditoria'

    # --- Clave Primaria (PK) ---
    id_auditoria = db.Column(db.Integer, primary_key=True)

    # --- Claves Foráneas (FK) ---
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)

    # --- Campos de Datos ---
    fecha_registro = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    accion = db.Column(db.String(50), nullable=False) # CREAR, ACTUALIZAR, ELIMINAR, INICIO_SESION
    tabla_afectada = db.Column(db.String(100), nullable=False)
    registro_id_afectado = db.Column(db.String(50)) # ID del registro modificado
    datos_anteriores = db.Column(JSON) # Datos del registro antes de la acción (JSON)
    datos_nuevos = db.Column(JSON) # Datos del registro después de la acción (JSON)
    ip_origen = db.Column(db.String(45)) # Opcional: IP desde donde se realizó la acción
    
    # Relación para que se pueda acceder al usuario que hizo la acción
    usuario_auditor = db.relationship('Usuario', backref='historial_auditoria', lazy=True)

class PreciosClientes(db.Model):
    __tablename__ = 'precios_clientes'
    id_acuerdo = db.Column(db.Integer, primary_key=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id_cliente'))
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'))
    precio_acordado = db.Column(db.Numeric(10, 4))
    

