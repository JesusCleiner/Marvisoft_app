--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-10-18 22:58:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 17331)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 265 (class 1255 OID 17580)
-- Name: generar_numero_guia(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generar_numero_guia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.numero_guia := 'GD' || LPAD(nextval('seq_numero_guia')::TEXT, 5, '0');
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generar_numero_guia() OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 17412)
-- Name: generar_numero_lote_compra(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generar_numero_lote_compra() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.numero_lote := 'LC' || LPAD(nextval('seq_numero_lote_compra')::TEXT, 5, '0');
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generar_numero_lote_compra() OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 17436)
-- Name: generar_numero_op(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generar_numero_op() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.numero_op := 'OP' || LPAD(nextval('seq_numero_orden_produccion')::TEXT, 5, '0');
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generar_numero_op() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 262 (class 1259 OID 26084)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17742)
-- Name: bodega_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bodega_produccion (
    id_bodega integer NOT NULL,
    producto_id integer NOT NULL,
    lote_id integer NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    fecha_ingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sesion_usuario_id integer NOT NULL,
    observaciones text
);


ALTER TABLE public.bodega_produccion OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17741)
-- Name: bodega_produccion_id_bodega_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bodega_produccion_id_bodega_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bodega_produccion_id_bodega_seq OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 251
-- Name: bodega_produccion_id_bodega_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bodega_produccion_id_bodega_seq OWNED BY public.bodega_produccion.id_bodega;


--
-- TOC entry 248 (class 1259 OID 17675)
-- Name: bodega_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bodega_productos (
    id_bodega_producto integer NOT NULL,
    producto_id integer NOT NULL,
    lote_id integer,
    cantidad numeric(10,2) NOT NULL,
    fecha_produccion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sesion_usuario_id integer
);


ALTER TABLE public.bodega_productos OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17674)
-- Name: bodega_productos_id_bodega_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bodega_productos_id_bodega_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bodega_productos_id_bodega_producto_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 247
-- Name: bodega_productos_id_bodega_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bodega_productos_id_bodega_producto_seq OWNED BY public.bodega_productos.id_bodega_producto;


--
-- TOC entry 220 (class 1259 OID 17343)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ruc_ci character varying(20) NOT NULL,
    direccion character varying(255),
    telefono character varying(20),
    correo character varying(100),
    tipo character varying(50),
    estado character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    contacto timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17342)
-- Name: clientes_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 219
-- Name: clientes_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_cliente_seq OWNED BY public.clientes.id_cliente;


--
-- TOC entry 256 (class 1259 OID 17820)
-- Name: datos_emisor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datos_emisor (
    id_emisor integer NOT NULL,
    ruc_empresa character varying(13) NOT NULL,
    razon_social character varying(255) NOT NULL,
    nombre_comercial character varying(255),
    dir_matriz character varying(255) NOT NULL,
    dir_sucursal character varying(255),
    telefono character varying(20),
    email character varying(100),
    obligado_contabilidad boolean DEFAULT false NOT NULL,
    cod_establecimiento character varying(3) NOT NULL,
    cod_punto_emision character varying(3) NOT NULL,
    tasa_iva_actual numeric(4,2) DEFAULT 12.00 NOT NULL,
    ambiente_descripcion character varying(20) DEFAULT 'PRUEBAS'::character varying NOT NULL,
    tipo_emision_descripcion character varying(20) DEFAULT 'NORMAL'::character varying NOT NULL,
    logo_path character varying(255)
);


ALTER TABLE public.datos_emisor OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17819)
-- Name: datos_emisor_id_emisor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datos_emisor_id_emisor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.datos_emisor_id_emisor_seq OWNER TO postgres;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 255
-- Name: datos_emisor_id_emisor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datos_emisor_id_emisor_seq OWNED BY public.datos_emisor.id_emisor;


--
-- TOC entry 240 (class 1259 OID 17525)
-- Name: detalle_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_compra (
    compra_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad numeric(14,2) NOT NULL,
    costo_unitario numeric(14,2) NOT NULL,
    subtotal numeric(14,2) NOT NULL
);


ALTER TABLE public.detalle_compra OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17582)
-- Name: detalle_guia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_guia (
    guia_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad numeric(14,2) NOT NULL
);


ALTER TABLE public.detalle_guia OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17771)
-- Name: detalle_orden_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_orden_compra (
    orden_compra_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad_solicitada numeric(14,2) NOT NULL,
    costo_estimado numeric(14,2) DEFAULT 0.00 NOT NULL
);


ALTER TABLE public.detalle_orden_compra OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17480)
-- Name: detalle_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_venta (
    factura_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad numeric(14,2) NOT NULL,
    precio_unitario numeric(14,2) NOT NULL,
    subtotal numeric(14,2) NOT NULL
);


ALTER TABLE public.detalle_venta OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17496)
-- Name: facturas_compras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facturas_compras (
    id_compra integer NOT NULL,
    numero_documento character varying(50) NOT NULL,
    proveedor_id integer NOT NULL,
    usuario_id integer NOT NULL,
    orden_compra_id integer,
    lote_id integer,
    fecha_compra date NOT NULL,
    subtotal numeric(14,2) NOT NULL,
    total_iva numeric(14,2) NOT NULL,
    total numeric(14,2) NOT NULL,
    estado_pago character varying(50) DEFAULT 'Pendiente'::character varying
);


ALTER TABLE public.facturas_compras OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17495)
-- Name: facturas_compras_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facturas_compras_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facturas_compras_id_compra_seq OWNER TO postgres;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 238
-- Name: facturas_compras_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facturas_compras_id_compra_seq OWNED BY public.facturas_compras.id_compra;


--
-- TOC entry 236 (class 1259 OID 17460)
-- Name: facturas_ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facturas_ventas (
    id_factura integer NOT NULL,
    numero_factura character varying(50) NOT NULL,
    cliente_id integer NOT NULL,
    usuario_id integer NOT NULL,
    fecha date NOT NULL,
    subtotal numeric(14,2) NOT NULL,
    total_iva numeric(14,2) NOT NULL,
    descuento numeric(14,2) DEFAULT 0.00 NOT NULL,
    total numeric(14,2) NOT NULL,
    estado_pago character varying(50) DEFAULT 'Pendiente'::character varying,
    xml_ruta character varying(255),
    estado_autorizacion character varying(50) DEFAULT 'PENDIENTE'::character varying,
    fecha_envio_sri timestamp without time zone,
    fecha_autorizacion_sri timestamp without time zone,
    autorizacion_numero character varying(50),
    motivo_no_autorizacion text,
    pdf_ruta character varying(255),
    tipo_emision_codigo boolean DEFAULT false,
    reintentos_sri integer DEFAULT 0,
    fecha_vencimiento date,
    codigo_acceso character varying(50) NOT NULL,
    tipo_documento_codigo character varying(5) NOT NULL,
    forma_pago_id integer,
    fecha_registro timestamp without time zone DEFAULT now(),
    fecha_actualizacion timestamp without time zone DEFAULT now()
);


ALTER TABLE public.facturas_ventas OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17459)
-- Name: facturas_ventas_id_factura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facturas_ventas_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facturas_ventas_id_factura_seq OWNER TO postgres;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 235
-- Name: facturas_ventas_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facturas_ventas_id_factura_seq OWNED BY public.facturas_ventas.id_factura;


--
-- TOC entry 243 (class 1259 OID 17561)
-- Name: guias_despacho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guias_despacho (
    id_guia integer NOT NULL,
    numero_guia character varying(50) NOT NULL,
    fecha_salida date NOT NULL,
    cliente_id integer,
    usuario_id integer,
    transportista character varying(100),
    placa_vehiculo character varying(20),
    estado character varying(50) DEFAULT 'Emitida'::character varying,
    factura_id integer
);


ALTER TABLE public.guias_despacho OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17560)
-- Name: guias_despacho_id_guia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guias_despacho_id_guia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guias_despacho_id_guia_seq OWNER TO postgres;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 242
-- Name: guias_despacho_id_guia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guias_despacho_id_guia_seq OWNED BY public.guias_despacho.id_guia;


--
-- TOC entry 226 (class 1259 OID 17381)
-- Name: historial_auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_auditoria (
    id_auditoria integer NOT NULL,
    usuario_id integer NOT NULL,
    fecha_accion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    accion text NOT NULL,
    tabla_afectada character varying(50),
    registro_id integer,
    tipo_evento character varying(50),
    estado_sri character varying(20),
    modo_contingencia boolean DEFAULT false,
    observaciones text
);


ALTER TABLE public.historial_auditoria OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17380)
-- Name: historial_auditoria_id_auditoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_auditoria_id_auditoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_auditoria_id_auditoria_seq OWNER TO postgres;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 225
-- Name: historial_auditoria_id_auditoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_auditoria_id_auditoria_seq OWNED BY public.historial_auditoria.id_auditoria;


--
-- TOC entry 229 (class 1259 OID 17397)
-- Name: lotes_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lotes_compra (
    id_lote integer NOT NULL,
    numero_lote character varying(50) NOT NULL,
    proveedor_id integer,
    fecha_ingreso date NOT NULL,
    fecha_recepcion date NOT NULL,
    placa_camion character varying(20),
    observacion text
);


ALTER TABLE public.lotes_compra OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17396)
-- Name: lotes_compra_id_lote_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lotes_compra_id_lote_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lotes_compra_id_lote_seq OWNER TO postgres;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 228
-- Name: lotes_compra_id_lote_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lotes_compra_id_lote_seq OWNED BY public.lotes_compra.id_lote;


--
-- TOC entry 246 (class 1259 OID 17598)
-- Name: movimiento_bodega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimiento_bodega (
    id_movimiento integer NOT NULL,
    producto_id integer NOT NULL,
    usuario_id integer,
    factura_id integer,
    compra_id integer,
    guia_id integer,
    registro_produccion_id integer,
    tipo_movimiento character varying(50) NOT NULL,
    referencia_texto character varying(100),
    cantidad numeric(14,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.movimiento_bodega OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17597)
-- Name: movimiento_bodega_id_movimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimiento_bodega_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movimiento_bodega_id_movimiento_seq OWNER TO postgres;

--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 245
-- Name: movimiento_bodega_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimiento_bodega_id_movimiento_seq OWNED BY public.movimiento_bodega.id_movimiento;


--
-- TOC entry 234 (class 1259 OID 17439)
-- Name: ordenes_compras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordenes_compras (
    id_orden_compra integer NOT NULL,
    numero_orden character varying(50) NOT NULL,
    proveedor_id integer NOT NULL,
    usuario_id integer NOT NULL,
    fecha_emision date NOT NULL,
    fecha_requerida date,
    estado character varying(50) DEFAULT 'Pendiente'::character varying NOT NULL,
    total_estimado numeric(14,2) DEFAULT 0.00 NOT NULL
);


ALTER TABLE public.ordenes_compras OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17438)
-- Name: ordenes_compras_id_orden_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordenes_compras_id_orden_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ordenes_compras_id_orden_compra_seq OWNER TO postgres;

--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 233
-- Name: ordenes_compras_id_orden_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordenes_compras_id_orden_compra_seq OWNED BY public.ordenes_compras.id_orden_compra;


--
-- TOC entry 232 (class 1259 OID 17416)
-- Name: ordenes_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordenes_produccion (
    id_orden_produccion integer NOT NULL,
    numero_op character varying(50) NOT NULL,
    usuario_id integer NOT NULL,
    producto_terminado_id integer NOT NULL,
    fecha_emision date NOT NULL,
    cantidad_planificada numeric(14,2) NOT NULL,
    merma_tolerada numeric(5,2) DEFAULT 1.00,
    estado character varying(50) DEFAULT 'Pendiente'::character varying NOT NULL
);


ALTER TABLE public.ordenes_produccion OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17415)
-- Name: ordenes_produccion_id_orden_produccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordenes_produccion_id_orden_produccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ordenes_produccion_id_orden_produccion_seq OWNER TO postgres;

--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 231
-- Name: ordenes_produccion_id_orden_produccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordenes_produccion_id_orden_produccion_seq OWNED BY public.ordenes_produccion.id_orden_produccion;


--
-- TOC entry 250 (class 1259 OID 17710)
-- Name: parametrizacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parametrizacion (
    id_param integer NOT NULL,
    clave character varying(50) NOT NULL,
    valor_texto character varying(255),
    valor_numero numeric(12,2),
    valor_fecha date,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sesion_usuario_id integer
);


ALTER TABLE public.parametrizacion OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17709)
-- Name: parametrizacion_id_param_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parametrizacion_id_param_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parametrizacion_id_param_seq OWNER TO postgres;

--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 249
-- Name: parametrizacion_id_param_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parametrizacion_id_param_seq OWNED BY public.parametrizacion.id_param;


--
-- TOC entry 258 (class 1259 OID 17848)
-- Name: precio_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.precio_producto (
    id_precio integer NOT NULL,
    producto_id integer NOT NULL,
    usuario_id integer,
    precio_unitario numeric(12,2) NOT NULL,
    fecha_inicio date DEFAULT CURRENT_DATE NOT NULL,
    fecha_fin date,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying NOT NULL,
    cliente_id integer NOT NULL
);


ALTER TABLE public.precio_producto OWNER TO postgres;

--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 258
-- Name: TABLE precio_producto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.precio_producto IS 'Almacena el historial y precios vigentes de los productos.';


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN precio_producto.precio_unitario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.precio_producto.precio_unitario IS 'El precio de venta unitario establecido.';


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN precio_producto.fecha_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.precio_producto.fecha_inicio IS 'Fecha a partir de la cual el precio entra en vigencia.';


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN precio_producto.fecha_fin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.precio_producto.fecha_fin IS 'Fecha en la que el precio deja de estar vigente (NULL si está actualmente vigente).';


--
-- TOC entry 257 (class 1259 OID 17847)
-- Name: precio_producto_id_precio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.precio_producto_id_precio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.precio_producto_id_precio_seq OWNER TO postgres;

--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 257
-- Name: precio_producto_id_precio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.precio_producto_id_precio_seq OWNED BY public.precio_producto.id_precio;


--
-- TOC entry 224 (class 1259 OID 17367)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id_producto integer NOT NULL,
    codigo_interno character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255),
    tipo_producto character varying(50),
    unidad_medida character varying(10) NOT NULL,
    stock_actual numeric(14,2) DEFAULT 0 NOT NULL,
    stock_minimo numeric(14,2) DEFAULT 0 NOT NULL,
    estado character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    codigo_principal_sri character varying(20),
    aplica_ice boolean DEFAULT false NOT NULL,
    tarifa_iva_id integer NOT NULL
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17366)
-- Name: productos_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_producto_seq OWNER TO postgres;

--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 223
-- Name: productos_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_producto_seq OWNED BY public.productos.id_producto;


--
-- TOC entry 222 (class 1259 OID 17355)
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ruc_ci character varying(20) NOT NULL,
    direccion character varying(255),
    telefono character varying(20),
    contacto_venta character varying(100),
    correo character varying(100),
    estado character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17354)
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNER TO postgres;

--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 221
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNED BY public.proveedores.id_proveedor;


--
-- TOC entry 253 (class 1259 OID 17766)
-- Name: recetas_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recetas_productos (
    producto_terminado_id integer NOT NULL,
    material_id integer NOT NULL,
    cantidad_requerida numeric(14,2) NOT NULL
);


ALTER TABLE public.recetas_productos OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17559)
-- Name: seq_numero_guia; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_numero_guia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_numero_guia OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17395)
-- Name: seq_numero_lote_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_numero_lote_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_numero_lote_compra OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17414)
-- Name: seq_numero_orden_produccion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_numero_orden_produccion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_numero_orden_produccion OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 26066)
-- Name: tarifas_iva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarifas_iva (
    id_tarifa_iva integer NOT NULL,
    codigo_tarifa_sri character varying(5) NOT NULL,
    porcentaje numeric(5,2) NOT NULL,
    descripcion character varying(100) NOT NULL,
    fecha_vigencia date DEFAULT CURRENT_DATE
);


ALTER TABLE public.tarifas_iva OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 26065)
-- Name: tarifas_iva_id_tarifa_iva_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarifas_iva_id_tarifa_iva_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarifas_iva_id_tarifa_iva_seq OWNER TO postgres;

--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 260
-- Name: tarifas_iva_id_tarifa_iva_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarifas_iva_id_tarifa_iva_seq OWNED BY public.tarifas_iva.id_tarifa_iva;


--
-- TOC entry 259 (class 1259 OID 26060)
-- Name: tipos_emision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_emision (
    codigo character varying(2) NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.tipos_emision OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17333)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(100) NOT NULL,
    usuario character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    rol character varying(50),
    estado character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    fecha_modificacion timestamp without time zone,
    usuario_modificacion character varying(100)
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17332)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 4805 (class 2604 OID 17745)
-- Name: bodega_produccion id_bodega; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_produccion ALTER COLUMN id_bodega SET DEFAULT nextval('public.bodega_produccion_id_bodega_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 17678)
-- Name: bodega_productos id_bodega_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_productos ALTER COLUMN id_bodega_producto SET DEFAULT nextval('public.bodega_productos_id_bodega_producto_seq'::regclass);


--
-- TOC entry 4764 (class 2604 OID 17346)
-- Name: clientes id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id_cliente SET DEFAULT nextval('public.clientes_id_cliente_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 17823)
-- Name: datos_emisor id_emisor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_emisor ALTER COLUMN id_emisor SET DEFAULT nextval('public.datos_emisor_id_emisor_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 17499)
-- Name: facturas_compras id_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras ALTER COLUMN id_compra SET DEFAULT nextval('public.facturas_compras_id_compra_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 17463)
-- Name: facturas_ventas id_factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_ventas ALTER COLUMN id_factura SET DEFAULT nextval('public.facturas_ventas_id_factura_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 17564)
-- Name: guias_despacho id_guia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guias_despacho ALTER COLUMN id_guia SET DEFAULT nextval('public.guias_despacho_id_guia_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 17384)
-- Name: historial_auditoria id_auditoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_auditoria ALTER COLUMN id_auditoria SET DEFAULT nextval('public.historial_auditoria_id_auditoria_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 17400)
-- Name: lotes_compra id_lote; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra ALTER COLUMN id_lote SET DEFAULT nextval('public.lotes_compra_id_lote_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 17601)
-- Name: movimiento_bodega id_movimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega ALTER COLUMN id_movimiento SET DEFAULT nextval('public.movimiento_bodega_id_movimiento_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 17442)
-- Name: ordenes_compras id_orden_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compras ALTER COLUMN id_orden_compra SET DEFAULT nextval('public.ordenes_compras_id_orden_compra_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 17419)
-- Name: ordenes_produccion id_orden_produccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_produccion ALTER COLUMN id_orden_produccion SET DEFAULT nextval('public.ordenes_produccion_id_orden_produccion_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 17713)
-- Name: parametrizacion id_param; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parametrizacion ALTER COLUMN id_param SET DEFAULT nextval('public.parametrizacion_id_param_seq'::regclass);


--
-- TOC entry 4813 (class 2604 OID 17851)
-- Name: precio_producto id_precio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_producto ALTER COLUMN id_precio SET DEFAULT nextval('public.precio_producto_id_precio_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 17370)
-- Name: productos id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_id_producto_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 17358)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('public.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 4817 (class 2604 OID 26069)
-- Name: tarifas_iva id_tarifa_iva; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarifas_iva ALTER COLUMN id_tarifa_iva SET DEFAULT nextval('public.tarifas_iva_id_tarifa_iva_seq'::regclass);


--
-- TOC entry 4760 (class 2604 OID 17336)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 5139 (class 0 OID 26084)
-- Dependencies: 262
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
\.


--
-- TOC entry 5129 (class 0 OID 17742)
-- Dependencies: 252
-- Data for Name: bodega_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bodega_produccion (id_bodega, producto_id, lote_id, cantidad, fecha_ingreso, sesion_usuario_id, observaciones) FROM stdin;
1	2	1	1000.00	2025-10-17 10:57:39.303276	1	Producción terminada del lote 2025-001
\.


--
-- TOC entry 5125 (class 0 OID 17675)
-- Dependencies: 248
-- Data for Name: bodega_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bodega_productos (id_bodega_producto, producto_id, lote_id, cantidad, fecha_produccion, sesion_usuario_id) FROM stdin;
\.


--
-- TOC entry 5097 (class 0 OID 17343)
-- Dependencies: 220
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nombre, ruc_ci, direccion, telefono, correo, tipo, estado, fecha_registro, contacto) FROM stdin;
1	PLASTECNIVA S.A.	0999999999001	Km 5 Vía Durán - Tambo, Guayaquil	042345678	contacto@plastecniva.com	Empresa	Activo	2025-10-17 10:54:53.484582	2025-10-17 10:54:53.484582
\.


--
-- TOC entry 5133 (class 0 OID 17820)
-- Dependencies: 256
-- Data for Name: datos_emisor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datos_emisor (id_emisor, ruc_empresa, razon_social, nombre_comercial, dir_matriz, dir_sucursal, telefono, email, obligado_contabilidad, cod_establecimiento, cod_punto_emision, tasa_iva_actual, ambiente_descripcion, tipo_emision_descripcion, logo_path) FROM stdin;
1	0999999999001	PLASTECNIVA S.A.	PLASTECNIVA	Km 5 vía Durán - Tambo	Sucursal 1 - Guayaquil	042345678	info@plastecniva.com	t	001	002	12.00	PRUEBAS	NORMAL	\N
\.


--
-- TOC entry 5117 (class 0 OID 17525)
-- Dependencies: 240
-- Data for Name: detalle_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_compra (compra_id, producto_id, cantidad, costo_unitario, subtotal) FROM stdin;
1	1	5000.00	0.10	500.00
\.


--
-- TOC entry 5121 (class 0 OID 17582)
-- Dependencies: 244
-- Data for Name: detalle_guia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_guia (guia_id, producto_id, cantidad) FROM stdin;
1	2	1000.00
\.


--
-- TOC entry 5131 (class 0 OID 17771)
-- Dependencies: 254
-- Data for Name: detalle_orden_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_orden_compra (orden_compra_id, producto_id, cantidad_solicitada, costo_estimado) FROM stdin;
1	1	5000.00	0.10
\.


--
-- TOC entry 5114 (class 0 OID 17480)
-- Dependencies: 237
-- Data for Name: detalle_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_venta (factura_id, producto_id, cantidad, precio_unitario, subtotal) FROM stdin;
1	2	1000.00	0.30	300.00
\.


--
-- TOC entry 5116 (class 0 OID 17496)
-- Dependencies: 239
-- Data for Name: facturas_compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facturas_compras (id_compra, numero_documento, proveedor_id, usuario_id, orden_compra_id, lote_id, fecha_compra, subtotal, total_iva, total, estado_pago) FROM stdin;
1	FC-0001	1	1	\N	1	2025-10-17	500.00	60.00	560.00	Pendiente
\.


--
-- TOC entry 5113 (class 0 OID 17460)
-- Dependencies: 236
-- Data for Name: facturas_ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facturas_ventas (id_factura, numero_factura, cliente_id, usuario_id, fecha, subtotal, total_iva, descuento, total, estado_pago, xml_ruta, estado_autorizacion, fecha_envio_sri, fecha_autorizacion_sri, autorizacion_numero, motivo_no_autorizacion, pdf_ruta, tipo_emision_codigo, reintentos_sri, fecha_vencimiento, codigo_acceso, tipo_documento_codigo, forma_pago_id, fecha_registro, fecha_actualizacion) FROM stdin;
1	1	1	1	2025-10-17	300.00	36.00	0.00	336.00	Pendiente	\N	PENDIENTE	\N	\N	1710202501099333937700120010010000027334124057816	\N	\N	f	0	\N	PENDIENTE	01	\N	2025-10-18 18:24:47.261778	2025-10-18 18:24:47.261778
\.


--
-- TOC entry 5120 (class 0 OID 17561)
-- Dependencies: 243
-- Data for Name: guias_despacho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guias_despacho (id_guia, numero_guia, fecha_salida, cliente_id, usuario_id, transportista, placa_vehiculo, estado, factura_id) FROM stdin;
1	GD00001	2025-10-17	1	1	TRANSLOGIC S.A.	GBB-4567	Emitida	1
\.


--
-- TOC entry 5103 (class 0 OID 17381)
-- Dependencies: 226
-- Data for Name: historial_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_auditoria (id_auditoria, usuario_id, fecha_accion, accion, tabla_afectada, registro_id, tipo_evento, estado_sri, modo_contingencia, observaciones) FROM stdin;
1	1	2025-10-17 10:57:39.303276	Inserción inicial de datos	clientes	1	INSERT	PENDIENTE	f	Carga de datos inicial
\.


--
-- TOC entry 5106 (class 0 OID 17397)
-- Dependencies: 229
-- Data for Name: lotes_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lotes_compra (id_lote, numero_lote, proveedor_id, fecha_ingreso, fecha_recepcion, placa_camion, observacion) FROM stdin;
1	LC00001	1	2025-10-17	2025-10-17	GBA-1234	Primer lote del año
\.


--
-- TOC entry 5123 (class 0 OID 17598)
-- Dependencies: 246
-- Data for Name: movimiento_bodega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimiento_bodega (id_movimiento, producto_id, usuario_id, factura_id, compra_id, guia_id, registro_produccion_id, tipo_movimiento, referencia_texto, cantidad, fecha) FROM stdin;
1	2	1	1	1	1	1	SALIDA	Despacho cliente 1	1000.00	2025-10-17 10:57:39.303276
\.


--
-- TOC entry 5111 (class 0 OID 17439)
-- Dependencies: 234
-- Data for Name: ordenes_compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordenes_compras (id_orden_compra, numero_orden, proveedor_id, usuario_id, fecha_emision, fecha_requerida, estado, total_estimado) FROM stdin;
1	OC-2025-001	1	1	2025-10-17	2025-10-24	Pendiente	500.00
\.


--
-- TOC entry 5109 (class 0 OID 17416)
-- Dependencies: 232
-- Data for Name: ordenes_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordenes_produccion (id_orden_produccion, numero_op, usuario_id, producto_terminado_id, fecha_emision, cantidad_planificada, merma_tolerada, estado) FROM stdin;
1	OP00001	1	2	2025-10-17	1000.00	1.00	Pendiente
\.


--
-- TOC entry 5127 (class 0 OID 17710)
-- Dependencies: 250
-- Data for Name: parametrizacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parametrizacion (id_param, clave, valor_texto, valor_numero, valor_fecha, descripcion, fecha_creacion, sesion_usuario_id) FROM stdin;
1	IVA_ECUADOR	12	\N	\N	Tasa actual de IVA en Ecuador	2025-10-17 10:57:39.303276	1
\.


--
-- TOC entry 5135 (class 0 OID 17848)
-- Dependencies: 258
-- Data for Name: precio_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precio_producto (id_precio, producto_id, usuario_id, precio_unitario, fecha_inicio, fecha_fin, fecha_creacion, estado, cliente_id) FROM stdin;
\.


--
-- TOC entry 5101 (class 0 OID 17367)
-- Dependencies: 224
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id_producto, codigo_interno, nombre, descripcion, tipo_producto, unidad_medida, stock_actual, stock_minimo, estado, fecha_registro, codigo_principal_sri, aplica_ice, tarifa_iva_id) FROM stdin;
1	PREF12T	Preforma 12.8g Transparente	Preforma PET 12.8 gramos transparente para botella 500ml	Materia Prima	UN	5000.00	500.00	Activo	2025-10-17 10:57:39.303276	\N	f	2
2	BOT500T	Botella 500ml Transparente	Botella PET 500ml elaborada con preforma 12.8g	Producto Terminado	UN	1200.00	100.00	Activo	2025-10-17 10:57:39.303276	\N	f	2
\.


--
-- TOC entry 5099 (class 0 OID 17355)
-- Dependencies: 222
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedores (id_proveedor, nombre, ruc_ci, direccion, telefono, contacto_venta, correo, estado, fecha_registro) FROM stdin;
1	POLYMER SOLUTIONS S.A.	1790001112001	Av. Quito km 6, Guayaquil	042856941	Carlos Andrade	ventas@polymersolutions.ec	Activo	2025-10-17 10:57:39.303276
\.


--
-- TOC entry 5130 (class 0 OID 17766)
-- Dependencies: 253
-- Data for Name: recetas_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recetas_productos (producto_terminado_id, material_id, cantidad_requerida) FROM stdin;
2	1	1.05
\.


--
-- TOC entry 5138 (class 0 OID 26066)
-- Dependencies: 261
-- Data for Name: tarifas_iva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarifas_iva (id_tarifa_iva, codigo_tarifa_sri, porcentaje, descripcion, fecha_vigencia) FROM stdin;
1	0	0.00	IVA 0%	2025-10-18
2	2	12.00	IVA 12%	2025-10-18
3	3	14.00	IVA 14%	2025-10-18
4	6	0.00	No Objeto de Impuesto	2025-10-18
5	7	0.00	Exento de IVA	2025-10-18
\.


--
-- TOC entry 5136 (class 0 OID 26060)
-- Dependencies: 259
-- Data for Name: tipos_emision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipos_emision (codigo, descripcion) FROM stdin;
1	Normal
2	Indisponibilidad
\.


--
-- TOC entry 5095 (class 0 OID 17333)
-- Dependencies: 218
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre_usuario, usuario, password, rol, estado, fecha_creacion, usuario_creacion, fecha_modificacion, usuario_modificacion) FROM stdin;
1	Administrador General	admin	hashed_password_aqui	Administrador	Activo	2025-10-17 10:57:39.303276	SYSTEM	\N	\N
\.


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 251
-- Name: bodega_produccion_id_bodega_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bodega_produccion_id_bodega_seq', 1, true);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 247
-- Name: bodega_productos_id_bodega_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bodega_productos_id_bodega_producto_seq', 1, false);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 219
-- Name: clientes_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 1, true);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 255
-- Name: datos_emisor_id_emisor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datos_emisor_id_emisor_seq', 1, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 238
-- Name: facturas_compras_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facturas_compras_id_compra_seq', 1, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 235
-- Name: facturas_ventas_id_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facturas_ventas_id_factura_seq', 1, true);


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 242
-- Name: guias_despacho_id_guia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guias_despacho_id_guia_seq', 1, true);


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 225
-- Name: historial_auditoria_id_auditoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_auditoria_id_auditoria_seq', 1, true);


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 228
-- Name: lotes_compra_id_lote_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lotes_compra_id_lote_seq', 1, true);


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 245
-- Name: movimiento_bodega_id_movimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimiento_bodega_id_movimiento_seq', 1, true);


--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 233
-- Name: ordenes_compras_id_orden_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordenes_compras_id_orden_compra_seq', 1, true);


--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 231
-- Name: ordenes_produccion_id_orden_produccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordenes_produccion_id_orden_produccion_seq', 1, true);


--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 249
-- Name: parametrizacion_id_param_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parametrizacion_id_param_seq', 1, true);


--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 257
-- Name: precio_producto_id_precio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.precio_producto_id_precio_seq', 1, false);


--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 223
-- Name: productos_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_producto_seq', 2, true);


--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 221
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 1, true);


--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_numero_guia; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_numero_guia', 1, true);


--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 227
-- Name: seq_numero_lote_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_numero_lote_compra', 1, true);


--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_numero_orden_produccion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_numero_orden_produccion', 1, true);


--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 260
-- Name: tarifas_iva_id_tarifa_iva_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarifas_iva_id_tarifa_iva_seq', 5, true);


--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 1, true);


--
-- TOC entry 4903 (class 2606 OID 26088)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 4881 (class 2606 OID 17750)
-- Name: bodega_produccion bodega_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_produccion
    ADD CONSTRAINT bodega_produccion_pkey PRIMARY KEY (id_bodega);


--
-- TOC entry 4875 (class 2606 OID 17681)
-- Name: bodega_productos bodega_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_productos
    ADD CONSTRAINT bodega_productos_pkey PRIMARY KEY (id_bodega_producto);


--
-- TOC entry 4824 (class 2606 OID 17351)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4826 (class 2606 OID 17353)
-- Name: clientes clientes_ruc_ci_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_ruc_ci_key UNIQUE (ruc_ci);


--
-- TOC entry 4887 (class 2606 OID 17831)
-- Name: datos_emisor datos_emisor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_emisor
    ADD CONSTRAINT datos_emisor_pkey PRIMARY KEY (id_emisor);


--
-- TOC entry 4889 (class 2606 OID 17833)
-- Name: datos_emisor datos_emisor_ruc_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_emisor
    ADD CONSTRAINT datos_emisor_ruc_empresa_key UNIQUE (ruc_empresa);


--
-- TOC entry 4863 (class 2606 OID 17529)
-- Name: detalle_compra detalle_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_pkey PRIMARY KEY (compra_id, producto_id);


--
-- TOC entry 4870 (class 2606 OID 17586)
-- Name: detalle_guia detalle_guia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_guia
    ADD CONSTRAINT detalle_guia_pkey PRIMARY KEY (guia_id, producto_id);


--
-- TOC entry 4885 (class 2606 OID 17776)
-- Name: detalle_orden_compra detalle_orden_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_pkey PRIMARY KEY (orden_compra_id, producto_id);


--
-- TOC entry 4856 (class 2606 OID 17484)
-- Name: detalle_venta detalle_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (factura_id, producto_id);


--
-- TOC entry 4858 (class 2606 OID 17504)
-- Name: facturas_compras facturas_compras_numero_documento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras
    ADD CONSTRAINT facturas_compras_numero_documento_key UNIQUE (numero_documento);


--
-- TOC entry 4860 (class 2606 OID 17502)
-- Name: facturas_compras facturas_compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras
    ADD CONSTRAINT facturas_compras_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 4851 (class 2606 OID 17469)
-- Name: facturas_ventas facturas_ventas_numero_factura_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_ventas
    ADD CONSTRAINT facturas_ventas_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 4853 (class 2606 OID 17467)
-- Name: facturas_ventas facturas_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_ventas
    ADD CONSTRAINT facturas_ventas_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 4865 (class 2606 OID 17569)
-- Name: guias_despacho guias_despacho_numero_guia_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guias_despacho
    ADD CONSTRAINT guias_despacho_numero_guia_key UNIQUE (numero_guia);


--
-- TOC entry 4867 (class 2606 OID 17567)
-- Name: guias_despacho guias_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guias_despacho
    ADD CONSTRAINT guias_despacho_pkey PRIMARY KEY (id_guia);


--
-- TOC entry 4837 (class 2606 OID 17389)
-- Name: historial_auditoria historial_auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_auditoria
    ADD CONSTRAINT historial_auditoria_pkey PRIMARY KEY (id_auditoria);


--
-- TOC entry 4839 (class 2606 OID 17406)
-- Name: lotes_compra lotes_compra_numero_lote_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT lotes_compra_numero_lote_key UNIQUE (numero_lote);


--
-- TOC entry 4841 (class 2606 OID 17404)
-- Name: lotes_compra lotes_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT lotes_compra_pkey PRIMARY KEY (id_lote);


--
-- TOC entry 4873 (class 2606 OID 17604)
-- Name: movimiento_bodega movimiento_bodega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 4847 (class 2606 OID 17448)
-- Name: ordenes_compras ordenes_compras_numero_orden_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compras
    ADD CONSTRAINT ordenes_compras_numero_orden_key UNIQUE (numero_orden);


--
-- TOC entry 4849 (class 2606 OID 17446)
-- Name: ordenes_compras ordenes_compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compras
    ADD CONSTRAINT ordenes_compras_pkey PRIMARY KEY (id_orden_compra);


--
-- TOC entry 4843 (class 2606 OID 17425)
-- Name: ordenes_produccion ordenes_produccion_numero_op_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_produccion
    ADD CONSTRAINT ordenes_produccion_numero_op_key UNIQUE (numero_op);


--
-- TOC entry 4845 (class 2606 OID 17423)
-- Name: ordenes_produccion ordenes_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_produccion
    ADD CONSTRAINT ordenes_produccion_pkey PRIMARY KEY (id_orden_produccion);


--
-- TOC entry 4877 (class 2606 OID 17720)
-- Name: parametrizacion parametrizacion_clave_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parametrizacion
    ADD CONSTRAINT parametrizacion_clave_key UNIQUE (clave);


--
-- TOC entry 4879 (class 2606 OID 17718)
-- Name: parametrizacion parametrizacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parametrizacion
    ADD CONSTRAINT parametrizacion_pkey PRIMARY KEY (id_param);


--
-- TOC entry 4895 (class 2606 OID 17856)
-- Name: precio_producto precio_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_producto
    ADD CONSTRAINT precio_producto_pkey PRIMARY KEY (id_precio);


--
-- TOC entry 4833 (class 2606 OID 17379)
-- Name: productos productos_codigo_interno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_interno_key UNIQUE (codigo_interno);


--
-- TOC entry 4835 (class 2606 OID 17377)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 4828 (class 2606 OID 17363)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 4830 (class 2606 OID 17365)
-- Name: proveedores proveedores_ruc_ci_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_ruc_ci_key UNIQUE (ruc_ci);


--
-- TOC entry 4883 (class 2606 OID 17770)
-- Name: recetas_productos recetas_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recetas_productos
    ADD CONSTRAINT recetas_productos_pkey PRIMARY KEY (producto_terminado_id, material_id);


--
-- TOC entry 4899 (class 2606 OID 26074)
-- Name: tarifas_iva tarifas_iva_codigo_tarifa_sri_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarifas_iva
    ADD CONSTRAINT tarifas_iva_codigo_tarifa_sri_key UNIQUE (codigo_tarifa_sri);


--
-- TOC entry 4901 (class 2606 OID 26072)
-- Name: tarifas_iva tarifas_iva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarifas_iva
    ADD CONSTRAINT tarifas_iva_pkey PRIMARY KEY (id_tarifa_iva);


--
-- TOC entry 4897 (class 2606 OID 26064)
-- Name: tipos_emision tipos_emision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_emision
    ADD CONSTRAINT tipos_emision_pkey PRIMARY KEY (codigo);


--
-- TOC entry 4820 (class 2606 OID 17339)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4822 (class 2606 OID 17341)
-- Name: usuarios usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 4861 (class 1259 OID 17636)
-- Name: idx_facturas_compras_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_compras_fecha ON public.facturas_compras USING btree (fecha_compra);


--
-- TOC entry 4854 (class 1259 OID 17635)
-- Name: idx_facturas_ventas_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facturas_ventas_fecha ON public.facturas_ventas USING btree (fecha);


--
-- TOC entry 4868 (class 1259 OID 17637)
-- Name: idx_guias_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_guias_fecha ON public.guias_despacho USING btree (fecha_salida);


--
-- TOC entry 4871 (class 1259 OID 17638)
-- Name: idx_movimientos_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movimientos_fecha ON public.movimiento_bodega USING btree (fecha);


--
-- TOC entry 4890 (class 1259 OID 17875)
-- Name: idx_precio_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_precio_cliente ON public.precio_producto USING btree (cliente_id, producto_id, fecha_inicio);


--
-- TOC entry 4891 (class 1259 OID 17887)
-- Name: idx_precio_cliente_producto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_precio_cliente_producto ON public.precio_producto USING btree (cliente_id, producto_id, fecha_inicio);


--
-- TOC entry 4892 (class 1259 OID 17867)
-- Name: idx_precio_producto_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_precio_producto_id ON public.precio_producto USING btree (producto_id);


--
-- TOC entry 4893 (class 1259 OID 17868)
-- Name: idx_precio_vigencia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_precio_vigencia ON public.precio_producto USING btree (producto_id, fecha_inicio, fecha_fin);


--
-- TOC entry 4831 (class 1259 OID 17639)
-- Name: idx_producto_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_producto_tipo ON public.productos USING btree (tipo_producto);


--
-- TOC entry 4948 (class 2620 OID 17581)
-- Name: guias_despacho trg_numero_guia; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_numero_guia BEFORE INSERT ON public.guias_despacho FOR EACH ROW EXECUTE FUNCTION public.generar_numero_guia();


--
-- TOC entry 4946 (class 2620 OID 17413)
-- Name: lotes_compra trg_numero_lote_compra; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_numero_lote_compra BEFORE INSERT ON public.lotes_compra FOR EACH ROW EXECUTE FUNCTION public.generar_numero_lote_compra();


--
-- TOC entry 4947 (class 2620 OID 17437)
-- Name: ordenes_produccion trg_numero_op; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_numero_op BEFORE INSERT ON public.ordenes_produccion FOR EACH ROW EXECUTE FUNCTION public.generar_numero_op();


--
-- TOC entry 4936 (class 2606 OID 17756)
-- Name: bodega_produccion bodega_produccion_lote_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_produccion
    ADD CONSTRAINT bodega_produccion_lote_id_fkey FOREIGN KEY (lote_id) REFERENCES public.lotes_compra(id_lote);


--
-- TOC entry 4937 (class 2606 OID 17751)
-- Name: bodega_produccion bodega_produccion_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_produccion
    ADD CONSTRAINT bodega_produccion_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto);


--
-- TOC entry 4938 (class 2606 OID 17761)
-- Name: bodega_produccion bodega_produccion_sesion_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_produccion
    ADD CONSTRAINT bodega_produccion_sesion_usuario_id_fkey FOREIGN KEY (sesion_usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4932 (class 2606 OID 17687)
-- Name: bodega_productos bodega_productos_lote_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_productos
    ADD CONSTRAINT bodega_productos_lote_id_fkey FOREIGN KEY (lote_id) REFERENCES public.lotes_compra(id_lote);


--
-- TOC entry 4933 (class 2606 OID 17682)
-- Name: bodega_productos bodega_productos_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_productos
    ADD CONSTRAINT bodega_productos_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto);


--
-- TOC entry 4934 (class 2606 OID 17692)
-- Name: bodega_productos bodega_productos_sesion_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodega_productos
    ADD CONSTRAINT bodega_productos_sesion_usuario_id_fkey FOREIGN KEY (sesion_usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4919 (class 2606 OID 17530)
-- Name: detalle_compra detalle_compra_compra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_compra_id_fkey FOREIGN KEY (compra_id) REFERENCES public.facturas_compras(id_compra) ON DELETE CASCADE;


--
-- TOC entry 4920 (class 2606 OID 17535)
-- Name: detalle_compra detalle_compra_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;


--
-- TOC entry 4924 (class 2606 OID 17587)
-- Name: detalle_guia detalle_guia_guia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_guia
    ADD CONSTRAINT detalle_guia_guia_id_fkey FOREIGN KEY (guia_id) REFERENCES public.guias_despacho(id_guia) ON DELETE CASCADE;


--
-- TOC entry 4925 (class 2606 OID 17592)
-- Name: detalle_guia detalle_guia_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_guia
    ADD CONSTRAINT detalle_guia_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;


--
-- TOC entry 4941 (class 2606 OID 17787)
-- Name: detalle_orden_compra detalle_orden_compra_orden_compra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_orden_compra_id_fkey FOREIGN KEY (orden_compra_id) REFERENCES public.ordenes_compras(id_orden_compra) ON DELETE CASCADE;


--
-- TOC entry 4942 (class 2606 OID 17792)
-- Name: detalle_orden_compra detalle_orden_compra_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;


--
-- TOC entry 4913 (class 2606 OID 17485)
-- Name: detalle_venta detalle_venta_factura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_factura_id_fkey FOREIGN KEY (factura_id) REFERENCES public.facturas_ventas(id_factura) ON DELETE CASCADE;


--
-- TOC entry 4914 (class 2606 OID 17490)
-- Name: detalle_venta detalle_venta_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;


--
-- TOC entry 4915 (class 2606 OID 17520)
-- Name: facturas_compras facturas_compras_lote_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras
    ADD CONSTRAINT facturas_compras_lote_id_fkey FOREIGN KEY (lote_id) REFERENCES public.lotes_compra(id_lote) ON DELETE SET NULL;


--
-- TOC entry 4916 (class 2606 OID 17515)
-- Name: facturas_compras facturas_compras_orden_compra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras
    ADD CONSTRAINT facturas_compras_orden_compra_id_fkey FOREIGN KEY (orden_compra_id) REFERENCES public.ordenes_compras(id_orden_compra) ON DELETE SET NULL;


--
-- TOC entry 4917 (class 2606 OID 17505)
-- Name: facturas_compras facturas_compras_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras
    ADD CONSTRAINT facturas_compras_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor) ON DELETE RESTRICT;


--
-- TOC entry 4918 (class 2606 OID 17510)
-- Name: facturas_compras facturas_compras_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_compras
    ADD CONSTRAINT facturas_compras_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON DELETE RESTRICT;


--
-- TOC entry 4911 (class 2606 OID 17470)
-- Name: facturas_ventas facturas_ventas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_ventas
    ADD CONSTRAINT facturas_ventas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente) ON DELETE RESTRICT;


--
-- TOC entry 4912 (class 2606 OID 17475)
-- Name: facturas_ventas facturas_ventas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas_ventas
    ADD CONSTRAINT facturas_ventas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON DELETE RESTRICT;


--
-- TOC entry 4943 (class 2606 OID 17870)
-- Name: precio_producto fk_precio_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_producto
    ADD CONSTRAINT fk_precio_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4944 (class 2606 OID 17857)
-- Name: precio_producto fk_precio_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_producto
    ADD CONSTRAINT fk_precio_producto FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4945 (class 2606 OID 17862)
-- Name: precio_producto fk_precio_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_producto
    ADD CONSTRAINT fk_precio_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4904 (class 2606 OID 26077)
-- Name: productos fk_productos_tarifa_iva; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_productos_tarifa_iva FOREIGN KEY (tarifa_iva_id) REFERENCES public.tarifas_iva(id_tarifa_iva) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4921 (class 2606 OID 17570)
-- Name: guias_despacho guias_despacho_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guias_despacho
    ADD CONSTRAINT guias_despacho_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 4922 (class 2606 OID 17797)
-- Name: guias_despacho guias_despacho_factura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guias_despacho
    ADD CONSTRAINT guias_despacho_factura_id_fkey FOREIGN KEY (factura_id) REFERENCES public.facturas_ventas(id_factura) ON DELETE SET NULL;


--
-- TOC entry 4923 (class 2606 OID 17575)
-- Name: guias_despacho guias_despacho_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guias_despacho
    ADD CONSTRAINT guias_despacho_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4905 (class 2606 OID 17390)
-- Name: historial_auditoria historial_auditoria_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_auditoria
    ADD CONSTRAINT historial_auditoria_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON DELETE RESTRICT;


--
-- TOC entry 4906 (class 2606 OID 17407)
-- Name: lotes_compra lotes_compra_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT lotes_compra_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor);


--
-- TOC entry 4926 (class 2606 OID 17620)
-- Name: movimiento_bodega movimiento_bodega_compra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_compra_id_fkey FOREIGN KEY (compra_id) REFERENCES public.facturas_compras(id_compra) ON DELETE SET NULL;


--
-- TOC entry 4927 (class 2606 OID 17615)
-- Name: movimiento_bodega movimiento_bodega_factura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_factura_id_fkey FOREIGN KEY (factura_id) REFERENCES public.facturas_ventas(id_factura) ON DELETE SET NULL;


--
-- TOC entry 4928 (class 2606 OID 17625)
-- Name: movimiento_bodega movimiento_bodega_guia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_guia_id_fkey FOREIGN KEY (guia_id) REFERENCES public.guias_despacho(id_guia) ON DELETE SET NULL;


--
-- TOC entry 4929 (class 2606 OID 17605)
-- Name: movimiento_bodega movimiento_bodega_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;


--
-- TOC entry 4930 (class 2606 OID 17802)
-- Name: movimiento_bodega movimiento_bodega_registro_produccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_registro_produccion_id_fkey FOREIGN KEY (registro_produccion_id) REFERENCES public.ordenes_produccion(id_orden_produccion) ON DELETE SET NULL;


--
-- TOC entry 4931 (class 2606 OID 17610)
-- Name: movimiento_bodega movimiento_bodega_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON DELETE SET NULL;


--
-- TOC entry 4909 (class 2606 OID 17449)
-- Name: ordenes_compras ordenes_compras_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compras
    ADD CONSTRAINT ordenes_compras_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor) ON DELETE RESTRICT;


--
-- TOC entry 4910 (class 2606 OID 17454)
-- Name: ordenes_compras ordenes_compras_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compras
    ADD CONSTRAINT ordenes_compras_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON DELETE RESTRICT;


--
-- TOC entry 4907 (class 2606 OID 17431)
-- Name: ordenes_produccion ordenes_produccion_producto_terminado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_produccion
    ADD CONSTRAINT ordenes_produccion_producto_terminado_id_fkey FOREIGN KEY (producto_terminado_id) REFERENCES public.productos(id_producto);


--
-- TOC entry 4908 (class 2606 OID 17426)
-- Name: ordenes_produccion ordenes_produccion_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_produccion
    ADD CONSTRAINT ordenes_produccion_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4935 (class 2606 OID 17721)
-- Name: parametrizacion parametrizacion_sesion_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parametrizacion
    ADD CONSTRAINT parametrizacion_sesion_usuario_id_fkey FOREIGN KEY (sesion_usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4939 (class 2606 OID 17782)
-- Name: recetas_productos recetas_productos_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recetas_productos
    ADD CONSTRAINT recetas_productos_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;


--
-- TOC entry 4940 (class 2606 OID 17777)
-- Name: recetas_productos recetas_productos_producto_terminado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recetas_productos
    ADD CONSTRAINT recetas_productos_producto_terminado_id_fkey FOREIGN KEY (producto_terminado_id) REFERENCES public.productos(id_producto) ON DELETE CASCADE;


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-10-18 22:58:15

--
-- PostgreSQL database dump complete
--

