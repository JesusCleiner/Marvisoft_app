# ===================================================
# 📄 app/blueprints/facturacion/routes.py
# Módulo Facturación (Venta) - Lógica de Numeración, API y POST
# ===================================================

from flask import Blueprint, render_template, request, redirect, url_for, flash, jsonify, g
from app.extensions import db
from datetime import datetime
from sqlalchemy.orm.exc import NoResultFound
from sqlalchemy import func
# Asegúrate de que esta importación sea correcta
from app.forms.factura_form import FacturaForm 

from app.models import (
    Cliente,
    Producto,
    FacturaVenta,
    DetalleFacturaVenta,
    MovimientoBodega,
    Usuario,
    HistorialAuditoria,
    DatosEmisor,
    PrecioVentaHistorico,
    PreciosClientes
)

# Simulacro de current_user si no se usa flask_login
try:
    from flask_login import current_user
except ImportError:
    class MockUser:
        @property
        def is_authenticated(self): return False
        @property
        def id(self): return 1
    current_user = MockUser()

facturacion_bp = Blueprint(
    'facturacion',
    __name__,
    template_folder='templates',
    url_prefix='/facturacion'
)

# ===================================================
# 💡 INYECCIÓN DE CONTEXTO (Datos Emisor)
# ===================================================
@facturacion_bp.context_processor
def inject_datos_emisor():
    """Inyecta los datos del emisor en todas las plantillas del Blueprint."""
    datos_emisor = DatosEmisor.query.first()
    
    if not datos_emisor:
        # Mock de datos si no existe configuración
        class MockEmisor:
            razon_social = "DATOS DE EMPRESA NO CONFIGURADOS"
            ruc = "0000000000000"
            direccion_matriz = "Dirección no disponible"
            codigo_establecimiento = "001"
            punto_emision = "001"
            ambiente = '1' # PRUEBA
            tipo_emision = '1' # NORMAL
            obligado_contabilidad = 'SI'
            telefono = 'N/A'
            sucursal = 'N/A'
            
        datos_emisor = MockEmisor()
    
    # Preparamos las variables con los datos, asegurando el acceso con getattr
    cod_establecimiento = getattr(datos_emisor, 'codigo_establecimiento', '001')
    cod_punto_emision = getattr(datos_emisor, 'punto_emision', '001')
    
    return {
        'datos_emisor': datos_emisor,
        'cod_establecimiento': str(cod_establecimiento).zfill(3),
        'cod_punto_emision': str(cod_punto_emision).zfill(3)
    }

# ===================================================
# 📌 RUTA API PARA PRECIO ACORDADO CLIENTE-PRODUCTO (AJAX)
# ===================================================
@facturacion_bp.route('/api/precio_acordado/<int:cliente_id>/<int:producto_id>', methods=['GET'])
def get_precio_acordado(cliente_id, producto_id):
    """Busca el precio acordado entre un cliente y un producto."""
    try:
        # Usamos el ORM en lugar del SQL crudo (aunque tu SQL era válido, el ORM es más seguro)
        # Buscamos el precio activo en la tabla PreciosClientes
        precio_obj = PreciosClientes.query.filter_by(
            cliente_id=cliente_id, 
            producto_id=producto_id, 
            estado=True
        ).first()

        precio = float(precio_obj.precio_acordado) if precio_obj and precio_obj.precio_acordado is not None else 0.0
        
        # Coherencia con el JS: Usamos 'precio_acordado' si ese es el nombre que tu JS espera
        # Si tu JS espera 'precio_unitario', ajústalo aquí o en el JS. Asumo que el JS usa 'precio_acordado'
        return jsonify({'precio_acordado': precio})
        
    except Exception as e:
        print(f"Error al obtener precio acordado: {e}")
        return jsonify({'precio_acordado': 0.0}), 500

# ===================================================
# 📌 RUTA PRINCIPAL PARA GENERAR FACTURA
# ===================================================
@facturacion_bp.route('/generar_factura', methods=['GET', 'POST'])
def generar_factura():
    """Muestra el formulario y procesa la creación de una FacturaVenta."""
    form = FacturaForm()
    
    # ----------------------------------------------------
    # 1. CONSULTA DE DATOS MAESTROS
    # ----------------------------------------------------
    clientes = Cliente.query.filter_by(estado=True).order_by(Cliente.nombre).all() or []
    productos = Producto.query.filter_by(estado=True).order_by(Producto.nombre).all() or []
    # Consultamos datos del emisor, necesarios para la numeración y POST
    datos_emisor = DatosEmisor.query.first() 
    
    # Llenar el SelectField del formulario
    form.cliente.choices = [(0, '-- Seleccione un cliente --')]
    form.cliente.choices.extend([(c.id_cliente, f'{c.nombre} ({c.ruc})') for c in clientes])

    # ----------------------------------------------------
    # 2. LÓGICA DE NUMERACIÓN SEGURA (CORRECCIÓN IMPLEMENTADA)
    # ----------------------------------------------------
    
    # 🛑 SOLUCIÓN AL ASSERTION ERROR: 
    # Usar el objeto 'datos_emisor' consultado, NO llamar al context_processor
    # Aseguramos un fallback en caso de que 'datos_emisor' sea None
    
    establecimiento = str(getattr(datos_emisor, 'codigo_establecimiento', '001')).zfill(3)
    punto_emision = str(getattr(datos_emisor, 'punto_emision', '001')).zfill(3)
    serie_factura = f"{establecimiento}-{punto_emision}"

    try:
        # Obtener el máximo número de factura para la SERIE ACTUAL
        # Esto previene duplicados y saltos al cambiar de serie/establecimiento
        max_secuencial = db.session.query(func.max(FacturaVenta.numero_factura)).filter(
            FacturaVenta.serie == serie_factura
        ).scalar()
        
        nuevo_secuencial = (max_secuencial or 0) + 1
        
    except Exception as e:
        print(f"Error al obtener max secuencial: {e}")
        nuevo_secuencial = 1 
        
    numero_factura_completo = f"{serie_factura}-{nuevo_secuencial:09d}"
    fecha_emision = datetime.now().date()
    
    # Objeto para inyectar datos iniciales en HTML (lo que llamas 'facturas_ventas')
    class FacturaDataInicial:
        numero_factura = numero_factura_completo
        # Datos extra para el encabezado (simplificados)
        emision = 'NORMAL' if getattr(datos_emisor, 'tipo_emision', '1') == '1' else 'CONTINGENCIA'
        
    facturas_ventas_inicial = FacturaDataInicial()

    # ----------------------------------------------------
    # 3. BLOQUE POST: PROCESAR FORMULARIO
    # ----------------------------------------------------
    if request.method == 'POST' and form.validate_on_submit():
        try:
            id_cliente = int(form.cliente.data)
            
            # Validación de Cliente (0 es el valor por defecto en choices)
            if id_cliente == 0:
                flash('Debe seleccionar un cliente válido para facturar.', 'warning')
                return redirect(url_for('facturacion.generar_factura'))

            # Obtener ID de usuario autenticado
            usuario_id = current_user.id if current_user.is_authenticated else 1
            emisor_id = getattr(datos_emisor, 'id_emisor', 1)

            # Recopilación de datos del detalle (desde el JS/POST)
            productos_ids = request.form.getlist('producto_id[]')
            cantidades = request.form.getlist('cantidad[]')
            precios_unitarios = request.form.getlist('precio_unitario[]')
            descuentos_linea = request.form.getlist('descuento_linea[]')

            # Totales calculados por el JS
            subtotal_neto = float(request.form.get('subtotal_neto_final') or 0.0)
            iva_final = float(request.form.get('iva_final') or 0.0)
            total_final = float(request.form.get('total_final') or 0.0)
            
            # Validación simple de detalles
            if not (len(productos_ids) > 0 and len(productos_ids) == len(cantidades)):
                flash('El detalle de la factura está incompleto o vacío.', 'warning')
                return redirect(url_for('facturacion.generar_factura'))

            detalles_factura = []
            for i in range(len(productos_ids)):
                # Asegurar que el ID del producto no sea vacío (en caso de que el select no haya sido usado)
                if not productos_ids[i] or int(productos_ids[i]) == 0: continue
                
                pid = int(productos_ids[i])
                cant = float(cantidades[i])
                precio = float(precios_unitarios[i])
                descuento_linea = float(descuentos_linea[i])
                subtotal_linea = max(0, (cant * precio) - descuento_linea)

                detalles_factura.append({
                    'producto_id': pid,
                    'cantidad': cant,
                    'precio_unitario': precio,
                    'subtotal': subtotal_linea,
                    'descuento_linea': descuento_linea,
                    'cantidad_bultos': 0, # Asumimos 0 por ahora
                    'lote_produccion_id': None # Asumimos None por ahora
                })
            
            if not detalles_factura:
                flash('Debe ingresar al menos un producto válido con cantidad > 0.', 'warning')
                return redirect(url_for('facturacion.generar_factura'))

            # ----------------------------------------------------
            # CREAR FACTURA Y GUARDAR (Transacción)
            # ----------------------------------------------------
            factura = FacturaVenta(
                cliente_id=id_cliente,
                emisor_id=emisor_id,
                numero_factura=nuevo_secuencial, 
                serie=serie_factura,
                fecha_emision=fecha_emision,
                subtotal=subtotal_neto,
                iva=iva_final,
                total=total_final,
                estado='PENDIENTE', # Puede cambiar a 'EMITIDA' o 'PAGADA' después
                tipo_venta='VENTA',
                numero_autorizacion_sri='',
                observaciones=form.observaciones.data,
                ambiente=getattr(datos_emisor, 'ambiente', '1'),
                tipo_emision=getattr(datos_emisor, 'tipo_emision', '1'),
            )
            db.session.add(factura)
            db.session.flush() # Obtener factura.id_factura_v

            # Detalles de factura y movimientos de bodega
            for d in detalles_factura:
                detalle = DetalleFacturaVenta(
                    factura_id=factura.id_factura_v,
                    producto_id=d['producto_id'],
                    cantidad_unidades=d['cantidad'],
                    cantidad_bultos=d['cantidad_bultos'],
                    precio_unitario=d['precio_unitario'],
                    descuento=d['descuento_linea'],
                    subtotal=d['subtotal'],
                    lote_produccion_id=d['lote_produccion_id']
                )
                db.session.add(detalle)

                movimiento = MovimientoBodega(
                    producto_id=d['producto_id'],
                    usuario_id=usuario_id,
                    referencia_documento=f'FV-{serie_factura}-{nuevo_secuencial:09d}',
                    tipo_movimiento='SALIDA VENTA',
                    cantidad=d['cantidad'] * (-1), # La venta es una SALIDA, debe ser negativa
                    lote_produccion_id=d['lote_produccion_id']
                )
                db.session.add(movimiento)

            # Auditoría
            auditoria = HistorialAuditoria(
                usuario_id=usuario_id,
                nombre_reporte=f"Creación Factura FV-{numero_factura_completo}",
                tipo_reporte="EVENTO",
                fecha_generacion=datetime.utcnow()
            )
            db.session.add(auditoria)

            db.session.commit()
            flash(f'Factura FV-{numero_factura_completo} generada correctamente.', 'success')
            return redirect(url_for('facturacion.generar_factura'))

        except Exception as e:
            db.session.rollback()
            flash(f'Error al generar factura: {str(e)}', 'danger')

    # ----------------------------------------------------
    # 4. BLOQUE GET (o POST con errores)
    # ----------------------------------------------------
    # Preparar listas JSON para la plantilla
    clientes_js = [
        {
            'id_cliente': c.id_cliente,
            'nombre': c.nombre,
            'ruc_ci': c.ruc,
            'direccion': c.direccion,
            'telefono': c.telefono,
            'correo': c.correo
        } for c in clientes
    ]

    productos_js = [
        {
            'id': p.id_producto,
            'nombre': p.nombre,
            'codigo': p.codigo_interno
        } for p in productos
    ]

    return render_template(
        'facturacion/generar_factura.html',
        form=form,
        clientes_datos_js_temp=clientes_js,
        product_list_js_temp=productos_js,
        facturas_ventas=facturas_ventas_inicial
    )