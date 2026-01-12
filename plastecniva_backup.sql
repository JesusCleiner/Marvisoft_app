--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-01-12 16:11:46

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 245 (class 1259 OID 28281)
-- Name: caja_preformas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caja_preformas (
    id_caja_preforma integer NOT NULL,
    producto_id integer NOT NULL,
    lote_compra_id integer,
    materia_prima_terceros_id integer,
    numero_caja character varying(50) NOT NULL,
    cantidad integer NOT NULL,
    fecha_ingreso date DEFAULT CURRENT_DATE,
    observacion text
);


ALTER TABLE public.caja_preformas OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 28280)
-- Name: caja_preformas_id_caja_preforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.caja_preformas_id_caja_preforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.caja_preformas_id_caja_preforma_seq OWNER TO postgres;

--
-- TOC entry 5377 (class 0 OID 0)
-- Dependencies: 244
-- Name: caja_preformas_id_caja_preforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.caja_preformas_id_caja_preforma_seq OWNED BY public.caja_preformas.id_caja_preforma;


--
-- TOC entry 249 (class 1259 OID 28333)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nombre character varying(150) NOT NULL,
    ruc character varying(13),
    direccion character varying(250),
    telefono character varying(50),
    correo character varying(100),
    condicion_comercial character varying(50),
    limite_credito numeric(12,2) DEFAULT 0.00,
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 28332)
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
-- TOC entry 5378 (class 0 OID 0)
-- Dependencies: 248
-- Name: clientes_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_cliente_seq OWNED BY public.clientes.id_cliente;


--
-- TOC entry 265 (class 1259 OID 28522)
-- Name: compromisos_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compromisos_venta (
    id_compromiso integer NOT NULL,
    factura_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad_total numeric(12,2) NOT NULL,
    cantidad_entregada numeric(12,2) DEFAULT 0.00,
    saldo_pendiente numeric(12,2) NOT NULL,
    estado character varying(50) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.compromisos_venta OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 28521)
-- Name: compromisos_venta_id_compromiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compromisos_venta_id_compromiso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compromisos_venta_id_compromiso_seq OWNER TO postgres;

--
-- TOC entry 5379 (class 0 OID 0)
-- Dependencies: 264
-- Name: compromisos_venta_id_compromiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compromisos_venta_id_compromiso_seq OWNED BY public.compromisos_venta.id_compromiso;


--
-- TOC entry 253 (class 1259 OID 28384)
-- Name: consumo_materia_prima; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consumo_materia_prima (
    id_consumo integer NOT NULL,
    orden_id integer NOT NULL,
    tipo_materia_prima character varying(50) NOT NULL,
    caja_id integer,
    materia_prima_terceros_id integer,
    cantidad numeric(12,2) NOT NULL,
    fecha_consumo timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    observaciones text
);


ALTER TABLE public.consumo_materia_prima OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 28383)
-- Name: consumo_materia_prima_id_consumo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consumo_materia_prima_id_consumo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consumo_materia_prima_id_consumo_seq OWNER TO postgres;

--
-- TOC entry 5380 (class 0 OID 0)
-- Dependencies: 252
-- Name: consumo_materia_prima_id_consumo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consumo_materia_prima_id_consumo_seq OWNED BY public.consumo_materia_prima.id_consumo;


--
-- TOC entry 283 (class 1259 OID 28726)
-- Name: control_calidad_materia_prima; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.control_calidad_materia_prima (
    id_control integer NOT NULL,
    lote_mp_id integer NOT NULL,
    producto_id integer NOT NULL,
    fecha_inspeccion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cantidad_recibida numeric(12,2) NOT NULL,
    cantidad_defectuosa numeric(12,2) DEFAULT 0.00,
    estado character varying(50) NOT NULL,
    observaciones text
);


ALTER TABLE public.control_calidad_materia_prima OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 28725)
-- Name: control_calidad_materia_prima_id_control_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.control_calidad_materia_prima_id_control_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.control_calidad_materia_prima_id_control_seq OWNER TO postgres;

--
-- TOC entry 5381 (class 0 OID 0)
-- Dependencies: 282
-- Name: control_calidad_materia_prima_id_control_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.control_calidad_materia_prima_id_control_seq OWNED BY public.control_calidad_materia_prima.id_control;


--
-- TOC entry 285 (class 1259 OID 28747)
-- Name: control_calidad_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.control_calidad_produccion (
    id_control integer NOT NULL,
    lote_produccion_id integer NOT NULL,
    producto_id integer NOT NULL,
    fecha_inspeccion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cantidad_rechazada numeric(12,2) DEFAULT 0.00,
    cantidad_reprocesada numeric(12,2) DEFAULT 0.00,
    estado character varying(50) NOT NULL,
    observaciones text
);


ALTER TABLE public.control_calidad_produccion OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 28746)
-- Name: control_calidad_produccion_id_control_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.control_calidad_produccion_id_control_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.control_calidad_produccion_id_control_seq OWNER TO postgres;

--
-- TOC entry 5382 (class 0 OID 0)
-- Dependencies: 284
-- Name: control_calidad_produccion_id_control_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.control_calidad_produccion_id_control_seq OWNED BY public.control_calidad_produccion.id_control;


--
-- TOC entry 271 (class 1259 OID 28587)
-- Name: cruce_stock_emergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cruce_stock_emergencia (
    id_cruce integer NOT NULL,
    compromiso_id integer NOT NULL,
    lote_id integer NOT NULL,
    usuario_id integer NOT NULL,
    cantidad numeric(12,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cruce_stock_emergencia OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 28586)
-- Name: cruce_stock_emergencia_id_cruce_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cruce_stock_emergencia_id_cruce_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cruce_stock_emergencia_id_cruce_seq OWNER TO postgres;

--
-- TOC entry 5383 (class 0 OID 0)
-- Dependencies: 270
-- Name: cruce_stock_emergencia_id_cruce_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cruce_stock_emergencia_id_cruce_seq OWNED BY public.cruce_stock_emergencia.id_cruce;


--
-- TOC entry 279 (class 1259 OID 28687)
-- Name: cuenta_cobrar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_cobrar (
    id_cuenta_cobrar integer NOT NULL,
    factura_venta_id integer NOT NULL,
    cliente_id integer NOT NULL,
    monto_total numeric(12,2) NOT NULL,
    monto_pendiente numeric(12,2) NOT NULL,
    estado character varying(50) NOT NULL,
    fecha_vencimiento date,
    dias_credito integer
);


ALTER TABLE public.cuenta_cobrar OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 28686)
-- Name: cuenta_cobrar_id_cuenta_cobrar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_cobrar_id_cuenta_cobrar_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuenta_cobrar_id_cuenta_cobrar_seq OWNER TO postgres;

--
-- TOC entry 5384 (class 0 OID 0)
-- Dependencies: 278
-- Name: cuenta_cobrar_id_cuenta_cobrar_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_cobrar_id_cuenta_cobrar_seq OWNED BY public.cuenta_cobrar.id_cuenta_cobrar;


--
-- TOC entry 291 (class 1259 OID 28810)
-- Name: cuenta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_pagar (
    id_cuenta_pagar integer NOT NULL,
    proveedor_id integer,
    factura_compra_id integer,
    factura_transporte_id integer,
    monto_total numeric(12,2) NOT NULL,
    monto_pendiente numeric(12,2) NOT NULL,
    fecha_vencimiento date,
    estado character varying(50) NOT NULL
);


ALTER TABLE public.cuenta_pagar OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 28809)
-- Name: cuenta_pagar_id_cuenta_pagar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_pagar_id_cuenta_pagar_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuenta_pagar_id_cuenta_pagar_seq OWNER TO postgres;

--
-- TOC entry 5385 (class 0 OID 0)
-- Dependencies: 290
-- Name: cuenta_pagar_id_cuenta_pagar_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_pagar_id_cuenta_pagar_seq OWNED BY public.cuenta_pagar.id_cuenta_pagar;


--
-- TOC entry 222 (class 1259 OID 28079)
-- Name: datos_emisor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datos_emisor (
    id_emisor integer NOT NULL,
    ruc character varying(13) NOT NULL,
    razon_social character varying(255) NOT NULL,
    nombre_comercial character varying(255),
    direccion_matriz character varying(255) NOT NULL,
    direccion_establecimiento character varying(255),
    codigo_establecimiento character varying(3) NOT NULL,
    punto_emision character varying(3) NOT NULL,
    contribuyente_especial character varying(20),
    obligado_contabilidad character varying(5) DEFAULT false,
    ambiente character varying(10),
    tipo_emision character varying(10),
    email_contacto character varying(150),
    telefono character varying(20),
    logo_url character varying(255),
    sucursal character varying(100)
);


ALTER TABLE public.datos_emisor OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 28078)
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
-- TOC entry 5386 (class 0 OID 0)
-- Dependencies: 221
-- Name: datos_emisor_id_emisor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datos_emisor_id_emisor_seq OWNED BY public.datos_emisor.id_emisor;


--
-- TOC entry 273 (class 1259 OID 28610)
-- Name: despachos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.despachos (
    id_despacho integer NOT NULL,
    guia_id integer NOT NULL,
    transportista_id integer NOT NULL,
    fecha_salida timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_entrega timestamp without time zone,
    estado character varying(50) NOT NULL,
    observaciones text
);


ALTER TABLE public.despachos OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 28609)
-- Name: despachos_id_despacho_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.despachos_id_despacho_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.despachos_id_despacho_seq OWNER TO postgres;

--
-- TOC entry 5387 (class 0 OID 0)
-- Dependencies: 272
-- Name: despachos_id_despacho_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.despachos_id_despacho_seq OWNED BY public.despachos.id_despacho;


--
-- TOC entry 275 (class 1259 OID 28632)
-- Name: detalle_despacho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_despacho (
    id_detalle integer NOT NULL,
    despacho_id integer NOT NULL,
    compromiso_id integer NOT NULL,
    lote_produccion_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad_unidades numeric(12,2) NOT NULL,
    cantidad_bultos numeric(12,2)
);


ALTER TABLE public.detalle_despacho OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 28631)
-- Name: detalle_despacho_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_despacho_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_despacho_id_detalle_seq OWNER TO postgres;

--
-- TOC entry 5388 (class 0 OID 0)
-- Dependencies: 274
-- Name: detalle_despacho_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_despacho_id_detalle_seq OWNED BY public.detalle_despacho.id_detalle;


--
-- TOC entry 239 (class 1259 OID 28232)
-- Name: detalle_factura_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_factura_compra (
    id_detalle integer NOT NULL,
    factura_id integer NOT NULL,
    producto_id integer NOT NULL,
    lote_id integer,
    cantidad numeric(12,2) NOT NULL,
    precio_unitario numeric(12,2) NOT NULL,
    subtota_por_items numeric(12,2) NOT NULL
);


ALTER TABLE public.detalle_factura_compra OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 28231)
-- Name: detalle_factura_compra_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_factura_compra_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_factura_compra_id_detalle_seq OWNER TO postgres;

--
-- TOC entry 5389 (class 0 OID 0)
-- Dependencies: 238
-- Name: detalle_factura_compra_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_factura_compra_id_detalle_seq OWNED BY public.detalle_factura_compra.id_detalle;


--
-- TOC entry 261 (class 1259 OID 28472)
-- Name: detalle_factura_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_factura_venta (
    id_detalle integer NOT NULL,
    factura_id integer NOT NULL,
    producto_id integer NOT NULL,
    lote_produccion_id integer,
    cantidad_unidades numeric(12,2) NOT NULL,
    cantidad_bultos numeric(12,2),
    precio_unitario numeric(12,2) NOT NULL,
    descuento numeric(12,2) DEFAULT 0.00,
    subtotal numeric(12,2) NOT NULL
);


ALTER TABLE public.detalle_factura_venta OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 28471)
-- Name: detalle_factura_venta_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_factura_venta_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_factura_venta_id_detalle_seq OWNER TO postgres;

--
-- TOC entry 5390 (class 0 OID 0)
-- Dependencies: 260
-- Name: detalle_factura_venta_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_factura_venta_id_detalle_seq OWNED BY public.detalle_factura_venta.id_detalle;


--
-- TOC entry 233 (class 1259 OID 28176)
-- Name: detalle_orden_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_orden_compra (
    orden_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad numeric(12,2) NOT NULL,
    precio_unitario numeric(12,2) NOT NULL,
    subtotal numeric(12,2) NOT NULL
);


ALTER TABLE public.detalle_orden_compra OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 28659)
-- Name: devoluciones_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devoluciones_cliente (
    id_devolucion integer NOT NULL,
    despacho_id integer,
    cliente_id integer NOT NULL,
    producto_id integer NOT NULL,
    factura_id integer,
    cantidad_unidades numeric(12,2) NOT NULL,
    cantidad_bultos numeric(12,2),
    motivo character varying(150) NOT NULL,
    destino character varying(50),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_camion integer
);


ALTER TABLE public.devoluciones_cliente OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 28658)
-- Name: devoluciones_cliente_id_devolucion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.devoluciones_cliente_id_devolucion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.devoluciones_cliente_id_devolucion_seq OWNER TO postgres;

--
-- TOC entry 5391 (class 0 OID 0)
-- Dependencies: 276
-- Name: devoluciones_cliente_id_devolucion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devoluciones_cliente_id_devolucion_seq OWNED BY public.devoluciones_cliente.id_devolucion;


--
-- TOC entry 287 (class 1259 OID 28769)
-- Name: devoluciones_qc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devoluciones_qc (
    id_devolucion_qc integer NOT NULL,
    devolucion_cliente_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad_inspeccionada numeric(12,2) NOT NULL,
    cantidad_aprobada numeric(12,2) DEFAULT 0.00,
    cantidad_reclija numeric(12,2) DEFAULT 0.00,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(50) NOT NULL,
    observaciones text
);


ALTER TABLE public.devoluciones_qc OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 28768)
-- Name: devoluciones_qc_id_devolucion_qc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.devoluciones_qc_id_devolucion_qc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.devoluciones_qc_id_devolucion_qc_seq OWNER TO postgres;

--
-- TOC entry 5392 (class 0 OID 0)
-- Dependencies: 286
-- Name: devoluciones_qc_id_devolucion_qc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devoluciones_qc_id_devolucion_qc_seq OWNED BY public.devoluciones_qc.id_devolucion_qc;


--
-- TOC entry 235 (class 1259 OID 28192)
-- Name: factura_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_compra (
    id_factura integer NOT NULL,
    proveedor_id integer NOT NULL,
    orden_compra_id integer,
    numero_factura character varying(50) NOT NULL,
    fecha_emision date NOT NULL,
    fecha_vencimiento date,
    subtotal numeric(12,2) NOT NULL,
    impuesto numeric(12,2) DEFAULT 0.00,
    total_pagar numeric(12,2) NOT NULL,
    estado_pago character varying(50),
    tipo character varying(50),
    observaciones text
);


ALTER TABLE public.factura_compra OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 28191)
-- Name: factura_compra_id_factura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_compra_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factura_compra_id_factura_seq OWNER TO postgres;

--
-- TOC entry 5393 (class 0 OID 0)
-- Dependencies: 234
-- Name: factura_compra_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_compra_id_factura_seq OWNED BY public.factura_compra.id_factura;


--
-- TOC entry 281 (class 1259 OID 28706)
-- Name: factura_transporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_transporte (
    id_factura_transporte integer NOT NULL,
    transportista_id integer NOT NULL,
    despacho_id integer,
    cuenta_pagar_id integer,
    fecha_emision date NOT NULL,
    fecha_pago date,
    subtotal numeric(12,2) NOT NULL,
    iva numeric(12,2) DEFAULT 0.00,
    total numeric(12,2) NOT NULL,
    observaciones text,
    estado character varying(50) NOT NULL
);


ALTER TABLE public.factura_transporte OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 28705)
-- Name: factura_transporte_id_factura_transporte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_transporte_id_factura_transporte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factura_transporte_id_factura_transporte_seq OWNER TO postgres;

--
-- TOC entry 5394 (class 0 OID 0)
-- Dependencies: 280
-- Name: factura_transporte_id_factura_transporte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_transporte_id_factura_transporte_seq OWNED BY public.factura_transporte.id_factura_transporte;


--
-- TOC entry 259 (class 1259 OID 28448)
-- Name: factura_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_venta (
    id_factura integer NOT NULL,
    cliente_id integer NOT NULL,
    emisor_id integer NOT NULL,
    numero_autorizacion_sri character varying(50),
    serie character varying(20) NOT NULL,
    numero_factura integer NOT NULL,
    fecha_emision date NOT NULL,
    fecha_pago date,
    tipo_venta character varying(50) NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    iva numeric(12,2) NOT NULL,
    ice numeric(12,2) DEFAULT 0.00,
    otros_impuestos numeric(12,2) DEFAULT 0.00,
    total numeric(12,2) NOT NULL,
    estado character varying(50) NOT NULL,
    moneda character varying(10) DEFAULT 'USD'::character varying,
    observaciones text,
    dias_credito integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.factura_venta OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 28447)
-- Name: factura_venta_id_factura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_venta_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factura_venta_id_factura_seq OWNER TO postgres;

--
-- TOC entry 5395 (class 0 OID 0)
-- Dependencies: 258
-- Name: factura_venta_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_venta_id_factura_seq OWNED BY public.factura_venta.id_factura;


--
-- TOC entry 269 (class 1259 OID 28556)
-- Name: guia_despacho_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guia_despacho_venta (
    id_guia integer NOT NULL,
    factura_id integer NOT NULL,
    emisor_id integer NOT NULL,
    transportista_id integer,
    compromiso_id integer,
    numero_guia character varying(50) NOT NULL,
    fecha_emision date NOT NULL,
    unidades_totales numeric(12,2) NOT NULL,
    bultos_totales numeric(12,2),
    estado character varying(50) NOT NULL,
    observaciones text
);


ALTER TABLE public.guia_despacho_venta OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 28555)
-- Name: guia_despacho_venta_id_guia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guia_despacho_venta_id_guia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guia_despacho_venta_id_guia_seq OWNER TO postgres;

--
-- TOC entry 5396 (class 0 OID 0)
-- Dependencies: 268
-- Name: guia_despacho_venta_id_guia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guia_despacho_venta_id_guia_seq OWNED BY public.guia_despacho_venta.id_guia;


--
-- TOC entry 241 (class 1259 OID 28254)
-- Name: guia_remision_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guia_remision_compra (
    id_guia integer NOT NULL,
    factura_id integer NOT NULL,
    numero_guia character varying(50) NOT NULL,
    fecha_emision date NOT NULL,
    estado character varying(50),
    observaciones text
);


ALTER TABLE public.guia_remision_compra OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 28253)
-- Name: guia_remision_compra_id_guia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guia_remision_compra_id_guia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guia_remision_compra_id_guia_seq OWNER TO postgres;

--
-- TOC entry 5397 (class 0 OID 0)
-- Dependencies: 240
-- Name: guia_remision_compra_id_guia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guia_remision_compra_id_guia_seq OWNED BY public.guia_remision_compra.id_guia;


--
-- TOC entry 297 (class 1259 OID 28875)
-- Name: historial_reportes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_reportes (
    id_reporte integer NOT NULL,
    nombre_reporte character varying(100) NOT NULL,
    tipo_reporte character varying(50),
    fecha_generacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usuario_id integer NOT NULL,
    parametros jsonb,
    resultados jsonb
);


ALTER TABLE public.historial_reportes OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 28874)
-- Name: historial_reportes_id_reporte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_reportes_id_reporte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_reportes_id_reporte_seq OWNER TO postgres;

--
-- TOC entry 5398 (class 0 OID 0)
-- Dependencies: 296
-- Name: historial_reportes_id_reporte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_reportes_id_reporte_seq OWNED BY public.historial_reportes.id_reporte;


--
-- TOC entry 255 (class 1259 OID 28409)
-- Name: lote_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lote_produccion (
    id_lote integer NOT NULL,
    orden_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad numeric(12,2) NOT NULL,
    fecha_produccion date DEFAULT CURRENT_DATE,
    turno character varying(50),
    estado character varying(50) NOT NULL
);


ALTER TABLE public.lote_produccion OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 28408)
-- Name: lote_produccion_id_lote_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lote_produccion_id_lote_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lote_produccion_id_lote_seq OWNER TO postgres;

--
-- TOC entry 5399 (class 0 OID 0)
-- Dependencies: 254
-- Name: lote_produccion_id_lote_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lote_produccion_id_lote_seq OWNED BY public.lote_produccion.id_lote;


--
-- TOC entry 237 (class 1259 OID 28212)
-- Name: lotes_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lotes_compra (
    id_lote integer NOT NULL,
    codigo_lote character varying(50) NOT NULL,
    factura_id integer NOT NULL,
    producto_id integer NOT NULL,
    proveedor_lote_referencia character varying(50),
    cantidad_ingreso numeric(12,2) NOT NULL,
    cantidad_disponible numeric(12,2) NOT NULL,
    fecha_ingreso date DEFAULT CURRENT_DATE,
    estado_lote character varying(50) NOT NULL
);


ALTER TABLE public.lotes_compra OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 28211)
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
-- TOC entry 5400 (class 0 OID 0)
-- Dependencies: 236
-- Name: lotes_compra_id_lote_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lotes_compra_id_lote_seq OWNED BY public.lotes_compra.id_lote;


--
-- TOC entry 243 (class 1259 OID 28270)
-- Name: materia_prima_terceros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materia_prima_terceros (
    id_materia_prima_terceros integer NOT NULL,
    cliente_id integer NOT NULL,
    producto_id integer NOT NULL,
    proveedor character varying(150),
    cantidad_entregada numeric(12,2) NOT NULL,
    cantidad_consumida numeric(12,2) DEFAULT 0.00,
    cantidad_disponible numeric(12,2) NOT NULL,
    fecha_ingreso date DEFAULT CURRENT_DATE,
    estado character varying(50),
    observacion text
);


ALTER TABLE public.materia_prima_terceros OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 28269)
-- Name: materia_prima_terceros_id_materia_prima_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materia_prima_terceros_id_materia_prima_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materia_prima_terceros_id_materia_prima_seq OWNER TO postgres;

--
-- TOC entry 5401 (class 0 OID 0)
-- Dependencies: 242
-- Name: materia_prima_terceros_id_materia_prima_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materia_prima_terceros_id_materia_prima_seq OWNED BY public.materia_prima_terceros.id_materia_prima_terceros;


--
-- TOC entry 247 (class 1259 OID 28308)
-- Name: movimiento_bodega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimiento_bodega (
    id_movimiento integer NOT NULL,
    producto_id integer NOT NULL,
    lote_id integer,
    lote_produccion_id integer,
    usuario_id integer NOT NULL,
    referencia_documento character varying(50),
    tipo_movimiento character varying(50) NOT NULL,
    cantidad numeric(12,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    observaciones text
);


ALTER TABLE public.movimiento_bodega OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 28307)
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
-- TOC entry 5402 (class 0 OID 0)
-- Dependencies: 246
-- Name: movimiento_bodega_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimiento_bodega_id_movimiento_seq OWNED BY public.movimiento_bodega.id_movimiento;


--
-- TOC entry 251 (class 1259 OID 28358)
-- Name: orden_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orden_produccion (
    id_orden integer NOT NULL,
    numero_op character varying(20) NOT NULL,
    producto_terminado_id integer NOT NULL,
    usuario_id integer NOT NULL,
    tipo_orden character varying(50) NOT NULL,
    cliente_id integer,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    cantidad_programada numeric(12,2) NOT NULL,
    turno character varying(50),
    estado character varying(50) NOT NULL,
    observaciones text
);


ALTER TABLE public.orden_produccion OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 28357)
-- Name: orden_produccion_id_orden_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orden_produccion_id_orden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orden_produccion_id_orden_seq OWNER TO postgres;

--
-- TOC entry 5403 (class 0 OID 0)
-- Dependencies: 250
-- Name: orden_produccion_id_orden_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orden_produccion_id_orden_seq OWNED BY public.orden_produccion.id_orden;


--
-- TOC entry 232 (class 1259 OID 28156)
-- Name: ordenes_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordenes_compra (
    id_orden_compra integer NOT NULL,
    numero_orden character varying(20) NOT NULL,
    proveedor_id integer NOT NULL,
    usuario_id integer NOT NULL,
    fecha_emision date NOT NULL,
    fecha_entrega date,
    estado character varying(20) NOT NULL,
    total numeric(12,2),
    observaciones text
);


ALTER TABLE public.ordenes_compra OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 28155)
-- Name: ordenes_compra_id_orden_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordenes_compra_id_orden_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ordenes_compra_id_orden_compra_seq OWNER TO postgres;

--
-- TOC entry 5404 (class 0 OID 0)
-- Dependencies: 231
-- Name: ordenes_compra_id_orden_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordenes_compra_id_orden_compra_seq OWNED BY public.ordenes_compra.id_orden_compra;


--
-- TOC entry 293 (class 1259 OID 28841)
-- Name: pago_proveedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago_proveedor (
    id_pago integer NOT NULL,
    cuenta_pagar_id integer NOT NULL,
    usuario_id integer NOT NULL,
    monto_pago numeric(12,2) NOT NULL,
    metodo_pago character varying(50) NOT NULL,
    fecha_pago date NOT NULL,
    referencia character varying(100)
);


ALTER TABLE public.pago_proveedor OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 28840)
-- Name: pago_proveedor_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_proveedor_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_proveedor_id_pago_seq OWNER TO postgres;

--
-- TOC entry 5405 (class 0 OID 0)
-- Dependencies: 292
-- Name: pago_proveedor_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_proveedor_id_pago_seq OWNED BY public.pago_proveedor.id_pago;


--
-- TOC entry 295 (class 1259 OID 28858)
-- Name: pago_transporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago_transporte (
    id_pago_transporte integer NOT NULL,
    cuenta_pagar_id integer NOT NULL,
    usuario_id integer NOT NULL,
    monto_pago numeric(12,2) NOT NULL,
    fecha_pago date NOT NULL,
    referencia character varying(100),
    numero_factura_transporte character varying(50)
);


ALTER TABLE public.pago_transporte OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 28857)
-- Name: pago_transporte_id_pago_transporte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_transporte_id_pago_transporte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_transporte_id_pago_transporte_seq OWNER TO postgres;

--
-- TOC entry 5406 (class 0 OID 0)
-- Dependencies: 294
-- Name: pago_transporte_id_pago_transporte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_transporte_id_pago_transporte_seq OWNED BY public.pago_transporte.id_pago_transporte;


--
-- TOC entry 289 (class 1259 OID 28793)
-- Name: pagos_factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos_factura (
    id_pago integer NOT NULL,
    cuenta_cobrar_id integer NOT NULL,
    usuario_id integer NOT NULL,
    monto_pago numeric(12,2) NOT NULL,
    metodo_pago character varying(50) NOT NULL,
    fecha_pago date NOT NULL,
    referencia character varying(100)
);


ALTER TABLE public.pagos_factura OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 28792)
-- Name: pagos_factura_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_factura_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_factura_id_pago_seq OWNER TO postgres;

--
-- TOC entry 5407 (class 0 OID 0)
-- Dependencies: 288
-- Name: pagos_factura_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_factura_id_pago_seq OWNED BY public.pagos_factura.id_pago;


--
-- TOC entry 257 (class 1259 OID 28432)
-- Name: perdidas_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perdidas_produccion (
    id_perdida integer NOT NULL,
    lote_id integer NOT NULL,
    tolerancia_aplicada boolean DEFAULT false,
    cantidad numeric(12,2) NOT NULL,
    tipo character varying(50) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    observaciones text
);


ALTER TABLE public.perdidas_produccion OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 28431)
-- Name: perdidas_produccion_id_perdida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perdidas_produccion_id_perdida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perdidas_produccion_id_perdida_seq OWNER TO postgres;

--
-- TOC entry 5408 (class 0 OID 0)
-- Dependencies: 256
-- Name: perdidas_produccion_id_perdida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perdidas_produccion_id_perdida_seq OWNED BY public.perdidas_produccion.id_perdida;


--
-- TOC entry 228 (class 1259 OID 28117)
-- Name: precio_compra_historico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.precio_compra_historico (
    id_precio_compra integer NOT NULL,
    producto_id integer NOT NULL,
    proveedor_id integer,
    costo_unitario numeric(12,4) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    usuario_id integer NOT NULL
);


ALTER TABLE public.precio_compra_historico OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 28116)
-- Name: precio_compra_historico_id_precio_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.precio_compra_historico_id_precio_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.precio_compra_historico_id_precio_compra_seq OWNER TO postgres;

--
-- TOC entry 5409 (class 0 OID 0)
-- Dependencies: 227
-- Name: precio_compra_historico_id_precio_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.precio_compra_historico_id_precio_compra_seq OWNED BY public.precio_compra_historico.id_precio_compra;


--
-- TOC entry 230 (class 1259 OID 28139)
-- Name: precio_venta_historico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.precio_venta_historico (
    id_precio_venta integer NOT NULL,
    producto_id integer NOT NULL,
    precio_unitario numeric(12,4) NOT NULL,
    margen_ganancia numeric(5,2),
    fecha_inicio date NOT NULL,
    fecha_fin date,
    usuario_id integer NOT NULL
);


ALTER TABLE public.precio_venta_historico OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 28138)
-- Name: precio_venta_historico_id_precio_venta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.precio_venta_historico_id_precio_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.precio_venta_historico_id_precio_venta_seq OWNER TO postgres;

--
-- TOC entry 5410 (class 0 OID 0)
-- Dependencies: 229
-- Name: precio_venta_historico_id_precio_venta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.precio_venta_historico_id_precio_venta_seq OWNED BY public.precio_venta_historico.id_precio_venta;


--
-- TOC entry 263 (class 1259 OID 28495)
-- Name: precios_clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.precios_clientes (
    id_acuerdo integer NOT NULL,
    cliente_id integer NOT NULL,
    producto_id integer NOT NULL,
    precio_acordado numeric(12,4) NOT NULL,
    margen_especial numeric(5,2),
    fecha_inicio date NOT NULL,
    fecha_fin date,
    usuario_id integer NOT NULL,
    estado boolean DEFAULT true,
    observaciones text
);


ALTER TABLE public.precios_clientes OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 28494)
-- Name: precios_clientes_id_acuerdo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.precios_clientes_id_acuerdo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.precios_clientes_id_acuerdo_seq OWNER TO postgres;

--
-- TOC entry 5411 (class 0 OID 0)
-- Dependencies: 262
-- Name: precios_clientes_id_acuerdo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.precios_clientes_id_acuerdo_seq OWNED BY public.precios_clientes.id_acuerdo;


--
-- TOC entry 226 (class 1259 OID 28105)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    id_producto integer NOT NULL,
    codigo_interno character varying(50) NOT NULL,
    nombre character varying(150) NOT NULL,
    categoria character varying(50) NOT NULL,
    requiere_trazabilidad boolean DEFAULT false,
    capacidad_volumen numeric(10,2),
    tipo_producto character varying(50),
    unidad_medida character varying(20) NOT NULL,
    gramaje numeric(10,2),
    cuello character varying(50),
    color character varying(50),
    stock_minimo numeric(12,2) DEFAULT 0.00,
    estado boolean DEFAULT true
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 28104)
-- Name: producto_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_id_producto_seq OWNER TO postgres;

--
-- TOC entry 5412 (class 0 OID 0)
-- Dependencies: 225
-- Name: producto_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_id_producto_seq OWNED BY public.producto.id_producto;


--
-- TOC entry 224 (class 1259 OID 28091)
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    nombre character varying(150) NOT NULL,
    ruc character varying(13),
    direccion character varying(200),
    telefono character varying(50),
    contacto character varying(200),
    email character varying(100),
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tipo_proveedor character varying(20) DEFAULT 'LOCAL'::character varying,
    tipo_pago character varying(20) DEFAULT 'CONTADO'::character varying,
    tiempo_credito integer DEFAULT 0,
    usuario_id integer,
    CONSTRAINT proveedores_tipo_pago_check CHECK (((tipo_pago)::text = ANY ((ARRAY['CONTADO'::character varying, 'CREDITO'::character varying, 'PREPAGO'::character varying])::text[]))),
    CONSTRAINT proveedores_tipo_proveedor_check CHECK (((tipo_proveedor)::text = ANY ((ARRAY['LOCAL'::character varying, 'EXTRANJERO'::character varying])::text[])))
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 28090)
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
-- TOC entry 5413 (class 0 OID 0)
-- Dependencies: 223
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNED BY public.proveedores.id_proveedor;


--
-- TOC entry 218 (class 1259 OID 28044)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_rol integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 28043)
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_rol_seq OWNER TO postgres;

--
-- TOC entry 5414 (class 0 OID 0)
-- Dependencies: 217
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_rol_seq OWNED BY public.roles.id_rol;


--
-- TOC entry 267 (class 1259 OID 28542)
-- Name: transportistas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transportistas (
    id_transportista integer NOT NULL,
    nombre character varying(150) NOT NULL,
    ruc character varying(13),
    telefono character varying(50),
    direccion character varying(250),
    correo character varying(100),
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transportistas OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 28541)
-- Name: transportistas_id_transportista_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transportistas_id_transportista_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transportistas_id_transportista_seq OWNER TO postgres;

--
-- TOC entry 5415 (class 0 OID 0)
-- Dependencies: 266
-- Name: transportistas_id_transportista_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transportistas_id_transportista_seq OWNED BY public.transportistas.id_transportista;


--
-- TOC entry 220 (class 1259 OID 28058)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(150) NOT NULL,
    usuario character varying(50) NOT NULL,
    email character varying(150),
    password character varying(255) NOT NULL,
    rol_id integer NOT NULL,
    operador_turno character varying(50),
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 28057)
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
-- TOC entry 5416 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 4873 (class 2604 OID 28284)
-- Name: caja_preformas id_caja_preforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_preformas ALTER COLUMN id_caja_preforma SET DEFAULT nextval('public.caja_preformas_id_caja_preforma_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 28336)
-- Name: clientes id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id_cliente SET DEFAULT nextval('public.clientes_id_cliente_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 28525)
-- Name: compromisos_venta id_compromiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compromisos_venta ALTER COLUMN id_compromiso SET DEFAULT nextval('public.compromisos_venta_id_compromiso_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 28387)
-- Name: consumo_materia_prima id_consumo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumo_materia_prima ALTER COLUMN id_consumo SET DEFAULT nextval('public.consumo_materia_prima_id_consumo_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 28729)
-- Name: control_calidad_materia_prima id_control; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_materia_prima ALTER COLUMN id_control SET DEFAULT nextval('public.control_calidad_materia_prima_id_control_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 28750)
-- Name: control_calidad_produccion id_control; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_produccion ALTER COLUMN id_control SET DEFAULT nextval('public.control_calidad_produccion_id_control_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 28590)
-- Name: cruce_stock_emergencia id_cruce; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cruce_stock_emergencia ALTER COLUMN id_cruce SET DEFAULT nextval('public.cruce_stock_emergencia_id_cruce_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 28690)
-- Name: cuenta_cobrar id_cuenta_cobrar; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_cobrar ALTER COLUMN id_cuenta_cobrar SET DEFAULT nextval('public.cuenta_cobrar_id_cuenta_cobrar_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 28813)
-- Name: cuenta_pagar id_cuenta_pagar; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar ALTER COLUMN id_cuenta_pagar SET DEFAULT nextval('public.cuenta_pagar_id_cuenta_pagar_seq'::regclass);


--
-- TOC entry 4848 (class 2604 OID 28082)
-- Name: datos_emisor id_emisor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_emisor ALTER COLUMN id_emisor SET DEFAULT nextval('public.datos_emisor_id_emisor_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 28613)
-- Name: despachos id_despacho; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachos ALTER COLUMN id_despacho SET DEFAULT nextval('public.despachos_id_despacho_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 28635)
-- Name: detalle_despacho id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_despacho ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_despacho_id_detalle_seq'::regclass);


--
-- TOC entry 4868 (class 2604 OID 28235)
-- Name: detalle_factura_compra id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_compra ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_factura_compra_id_detalle_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 28475)
-- Name: detalle_factura_venta id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_venta ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_factura_venta_id_detalle_seq'::regclass);


--
-- TOC entry 4913 (class 2604 OID 28662)
-- Name: devoluciones_cliente id_devolucion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_cliente ALTER COLUMN id_devolucion SET DEFAULT nextval('public.devoluciones_cliente_id_devolucion_seq'::regclass);


--
-- TOC entry 4925 (class 2604 OID 28772)
-- Name: devoluciones_qc id_devolucion_qc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_qc ALTER COLUMN id_devolucion_qc SET DEFAULT nextval('public.devoluciones_qc_id_devolucion_qc_seq'::regclass);


--
-- TOC entry 4864 (class 2604 OID 28195)
-- Name: factura_compra id_factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_compra ALTER COLUMN id_factura SET DEFAULT nextval('public.factura_compra_id_factura_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 28709)
-- Name: factura_transporte id_factura_transporte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_transporte ALTER COLUMN id_factura_transporte SET DEFAULT nextval('public.factura_transporte_id_factura_transporte_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 28451)
-- Name: factura_venta id_factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta ALTER COLUMN id_factura SET DEFAULT nextval('public.factura_venta_id_factura_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 28559)
-- Name: guia_despacho_venta id_guia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta ALTER COLUMN id_guia SET DEFAULT nextval('public.guia_despacho_venta_id_guia_seq'::regclass);


--
-- TOC entry 4869 (class 2604 OID 28257)
-- Name: guia_remision_compra id_guia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_remision_compra ALTER COLUMN id_guia SET DEFAULT nextval('public.guia_remision_compra_id_guia_seq'::regclass);


--
-- TOC entry 4933 (class 2604 OID 28878)
-- Name: historial_reportes id_reporte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reportes ALTER COLUMN id_reporte SET DEFAULT nextval('public.historial_reportes_id_reporte_seq'::regclass);


--
-- TOC entry 4885 (class 2604 OID 28412)
-- Name: lote_produccion id_lote; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote_produccion ALTER COLUMN id_lote SET DEFAULT nextval('public.lote_produccion_id_lote_seq'::regclass);


--
-- TOC entry 4866 (class 2604 OID 28215)
-- Name: lotes_compra id_lote; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra ALTER COLUMN id_lote SET DEFAULT nextval('public.lotes_compra_id_lote_seq'::regclass);


--
-- TOC entry 4870 (class 2604 OID 28273)
-- Name: materia_prima_terceros id_materia_prima_terceros; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materia_prima_terceros ALTER COLUMN id_materia_prima_terceros SET DEFAULT nextval('public.materia_prima_terceros_id_materia_prima_seq'::regclass);


--
-- TOC entry 4875 (class 2604 OID 28311)
-- Name: movimiento_bodega id_movimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega ALTER COLUMN id_movimiento SET DEFAULT nextval('public.movimiento_bodega_id_movimiento_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 28361)
-- Name: orden_produccion id_orden; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_produccion ALTER COLUMN id_orden SET DEFAULT nextval('public.orden_produccion_id_orden_seq'::regclass);


--
-- TOC entry 4863 (class 2604 OID 28159)
-- Name: ordenes_compra id_orden_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compra ALTER COLUMN id_orden_compra SET DEFAULT nextval('public.ordenes_compra_id_orden_compra_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 28844)
-- Name: pago_proveedor id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_proveedor ALTER COLUMN id_pago SET DEFAULT nextval('public.pago_proveedor_id_pago_seq'::regclass);


--
-- TOC entry 4932 (class 2604 OID 28861)
-- Name: pago_transporte id_pago_transporte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_transporte ALTER COLUMN id_pago_transporte SET DEFAULT nextval('public.pago_transporte_id_pago_transporte_seq'::regclass);


--
-- TOC entry 4929 (class 2604 OID 28796)
-- Name: pagos_factura id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_factura ALTER COLUMN id_pago SET DEFAULT nextval('public.pagos_factura_id_pago_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 28435)
-- Name: perdidas_produccion id_perdida; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perdidas_produccion ALTER COLUMN id_perdida SET DEFAULT nextval('public.perdidas_produccion_id_perdida_seq'::regclass);


--
-- TOC entry 4861 (class 2604 OID 28120)
-- Name: precio_compra_historico id_precio_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_compra_historico ALTER COLUMN id_precio_compra SET DEFAULT nextval('public.precio_compra_historico_id_precio_compra_seq'::regclass);


--
-- TOC entry 4862 (class 2604 OID 28142)
-- Name: precio_venta_historico id_precio_venta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_venta_historico ALTER COLUMN id_precio_venta SET DEFAULT nextval('public.precio_venta_historico_id_precio_venta_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 28498)
-- Name: precios_clientes id_acuerdo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precios_clientes ALTER COLUMN id_acuerdo SET DEFAULT nextval('public.precios_clientes_id_acuerdo_seq'::regclass);


--
-- TOC entry 4857 (class 2604 OID 28108)
-- Name: producto id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN id_producto SET DEFAULT nextval('public.producto_id_producto_seq'::regclass);


--
-- TOC entry 4850 (class 2604 OID 28094)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('public.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 4840 (class 2604 OID 28047)
-- Name: roles id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_rol SET DEFAULT nextval('public.roles_id_rol_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 28545)
-- Name: transportistas id_transportista; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transportistas ALTER COLUMN id_transportista SET DEFAULT nextval('public.transportistas_id_transportista_seq'::regclass);


--
-- TOC entry 4844 (class 2604 OID 28061)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 5319 (class 0 OID 28281)
-- Dependencies: 245
-- Data for Name: caja_preformas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caja_preformas (id_caja_preforma, producto_id, lote_compra_id, materia_prima_terceros_id, numero_caja, cantidad, fecha_ingreso, observacion) FROM stdin;
\.


--
-- TOC entry 5323 (class 0 OID 28333)
-- Dependencies: 249
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nombre, ruc, direccion, telefono, correo, condicion_comercial, limite_credito, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
\.


--
-- TOC entry 5339 (class 0 OID 28522)
-- Dependencies: 265
-- Data for Name: compromisos_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compromisos_venta (id_compromiso, factura_id, producto_id, cantidad_total, cantidad_entregada, saldo_pendiente, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
\.


--
-- TOC entry 5327 (class 0 OID 28384)
-- Dependencies: 253
-- Data for Name: consumo_materia_prima; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consumo_materia_prima (id_consumo, orden_id, tipo_materia_prima, caja_id, materia_prima_terceros_id, cantidad, fecha_consumo, observaciones) FROM stdin;
\.


--
-- TOC entry 5357 (class 0 OID 28726)
-- Dependencies: 283
-- Data for Name: control_calidad_materia_prima; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.control_calidad_materia_prima (id_control, lote_mp_id, producto_id, fecha_inspeccion, cantidad_recibida, cantidad_defectuosa, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5359 (class 0 OID 28747)
-- Dependencies: 285
-- Data for Name: control_calidad_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.control_calidad_produccion (id_control, lote_produccion_id, producto_id, fecha_inspeccion, cantidad_rechazada, cantidad_reprocesada, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5345 (class 0 OID 28587)
-- Dependencies: 271
-- Data for Name: cruce_stock_emergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cruce_stock_emergencia (id_cruce, compromiso_id, lote_id, usuario_id, cantidad, fecha) FROM stdin;
\.


--
-- TOC entry 5353 (class 0 OID 28687)
-- Dependencies: 279
-- Data for Name: cuenta_cobrar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_cobrar (id_cuenta_cobrar, factura_venta_id, cliente_id, monto_total, monto_pendiente, estado, fecha_vencimiento, dias_credito) FROM stdin;
\.


--
-- TOC entry 5365 (class 0 OID 28810)
-- Dependencies: 291
-- Data for Name: cuenta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_pagar (id_cuenta_pagar, proveedor_id, factura_compra_id, factura_transporte_id, monto_total, monto_pendiente, fecha_vencimiento, estado) FROM stdin;
\.


--
-- TOC entry 5296 (class 0 OID 28079)
-- Dependencies: 222
-- Data for Name: datos_emisor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datos_emisor (id_emisor, ruc, razon_social, nombre_comercial, direccion_matriz, direccion_establecimiento, codigo_establecimiento, punto_emision, contribuyente_especial, obligado_contabilidad, ambiente, tipo_emision, email_contacto, telefono, logo_url, sucursal) FROM stdin;
\.


--
-- TOC entry 5347 (class 0 OID 28610)
-- Dependencies: 273
-- Data for Name: despachos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.despachos (id_despacho, guia_id, transportista_id, fecha_salida, fecha_entrega, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5349 (class 0 OID 28632)
-- Dependencies: 275
-- Data for Name: detalle_despacho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_despacho (id_detalle, despacho_id, compromiso_id, lote_produccion_id, producto_id, cantidad_unidades, cantidad_bultos) FROM stdin;
\.


--
-- TOC entry 5313 (class 0 OID 28232)
-- Dependencies: 239
-- Data for Name: detalle_factura_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_factura_compra (id_detalle, factura_id, producto_id, lote_id, cantidad, precio_unitario, subtota_por_items) FROM stdin;
\.


--
-- TOC entry 5335 (class 0 OID 28472)
-- Dependencies: 261
-- Data for Name: detalle_factura_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_factura_venta (id_detalle, factura_id, producto_id, lote_produccion_id, cantidad_unidades, cantidad_bultos, precio_unitario, descuento, subtotal) FROM stdin;
\.


--
-- TOC entry 5307 (class 0 OID 28176)
-- Dependencies: 233
-- Data for Name: detalle_orden_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_orden_compra (orden_id, producto_id, cantidad, precio_unitario, subtotal) FROM stdin;
\.


--
-- TOC entry 5351 (class 0 OID 28659)
-- Dependencies: 277
-- Data for Name: devoluciones_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devoluciones_cliente (id_devolucion, despacho_id, cliente_id, producto_id, factura_id, cantidad_unidades, cantidad_bultos, motivo, destino, fecha, id_camion) FROM stdin;
\.


--
-- TOC entry 5361 (class 0 OID 28769)
-- Dependencies: 287
-- Data for Name: devoluciones_qc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devoluciones_qc (id_devolucion_qc, devolucion_cliente_id, producto_id, cantidad_inspeccionada, cantidad_aprobada, cantidad_reclija, fecha, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5309 (class 0 OID 28192)
-- Dependencies: 235
-- Data for Name: factura_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura_compra (id_factura, proveedor_id, orden_compra_id, numero_factura, fecha_emision, fecha_vencimiento, subtotal, impuesto, total_pagar, estado_pago, tipo, observaciones) FROM stdin;
\.


--
-- TOC entry 5355 (class 0 OID 28706)
-- Dependencies: 281
-- Data for Name: factura_transporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura_transporte (id_factura_transporte, transportista_id, despacho_id, cuenta_pagar_id, fecha_emision, fecha_pago, subtotal, iva, total, observaciones, estado) FROM stdin;
\.


--
-- TOC entry 5333 (class 0 OID 28448)
-- Dependencies: 259
-- Data for Name: factura_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura_venta (id_factura, cliente_id, emisor_id, numero_autorizacion_sri, serie, numero_factura, fecha_emision, fecha_pago, tipo_venta, subtotal, iva, ice, otros_impuestos, total, estado, moneda, observaciones, dias_credito) FROM stdin;
\.


--
-- TOC entry 5343 (class 0 OID 28556)
-- Dependencies: 269
-- Data for Name: guia_despacho_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guia_despacho_venta (id_guia, factura_id, emisor_id, transportista_id, compromiso_id, numero_guia, fecha_emision, unidades_totales, bultos_totales, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5315 (class 0 OID 28254)
-- Dependencies: 241
-- Data for Name: guia_remision_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guia_remision_compra (id_guia, factura_id, numero_guia, fecha_emision, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5371 (class 0 OID 28875)
-- Dependencies: 297
-- Data for Name: historial_reportes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_reportes (id_reporte, nombre_reporte, tipo_reporte, fecha_generacion, usuario_id, parametros, resultados) FROM stdin;
\.


--
-- TOC entry 5329 (class 0 OID 28409)
-- Dependencies: 255
-- Data for Name: lote_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lote_produccion (id_lote, orden_id, producto_id, cantidad, fecha_produccion, turno, estado) FROM stdin;
\.


--
-- TOC entry 5311 (class 0 OID 28212)
-- Dependencies: 237
-- Data for Name: lotes_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lotes_compra (id_lote, codigo_lote, factura_id, producto_id, proveedor_lote_referencia, cantidad_ingreso, cantidad_disponible, fecha_ingreso, estado_lote) FROM stdin;
\.


--
-- TOC entry 5317 (class 0 OID 28270)
-- Dependencies: 243
-- Data for Name: materia_prima_terceros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materia_prima_terceros (id_materia_prima_terceros, cliente_id, producto_id, proveedor, cantidad_entregada, cantidad_consumida, cantidad_disponible, fecha_ingreso, estado, observacion) FROM stdin;
\.


--
-- TOC entry 5321 (class 0 OID 28308)
-- Dependencies: 247
-- Data for Name: movimiento_bodega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimiento_bodega (id_movimiento, producto_id, lote_id, lote_produccion_id, usuario_id, referencia_documento, tipo_movimiento, cantidad, fecha, observaciones) FROM stdin;
\.


--
-- TOC entry 5325 (class 0 OID 28358)
-- Dependencies: 251
-- Data for Name: orden_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orden_produccion (id_orden, numero_op, producto_terminado_id, usuario_id, tipo_orden, cliente_id, fecha_inicio, fecha_fin, cantidad_programada, turno, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5306 (class 0 OID 28156)
-- Dependencies: 232
-- Data for Name: ordenes_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordenes_compra (id_orden_compra, numero_orden, proveedor_id, usuario_id, fecha_emision, fecha_entrega, estado, total, observaciones) FROM stdin;
\.


--
-- TOC entry 5367 (class 0 OID 28841)
-- Dependencies: 293
-- Data for Name: pago_proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pago_proveedor (id_pago, cuenta_pagar_id, usuario_id, monto_pago, metodo_pago, fecha_pago, referencia) FROM stdin;
\.


--
-- TOC entry 5369 (class 0 OID 28858)
-- Dependencies: 295
-- Data for Name: pago_transporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pago_transporte (id_pago_transporte, cuenta_pagar_id, usuario_id, monto_pago, fecha_pago, referencia, numero_factura_transporte) FROM stdin;
\.


--
-- TOC entry 5363 (class 0 OID 28793)
-- Dependencies: 289
-- Data for Name: pagos_factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos_factura (id_pago, cuenta_cobrar_id, usuario_id, monto_pago, metodo_pago, fecha_pago, referencia) FROM stdin;
\.


--
-- TOC entry 5331 (class 0 OID 28432)
-- Dependencies: 257
-- Data for Name: perdidas_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perdidas_produccion (id_perdida, lote_id, tolerancia_aplicada, cantidad, tipo, fecha, observaciones) FROM stdin;
\.


--
-- TOC entry 5302 (class 0 OID 28117)
-- Dependencies: 228
-- Data for Name: precio_compra_historico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precio_compra_historico (id_precio_compra, producto_id, proveedor_id, costo_unitario, fecha_inicio, fecha_fin, usuario_id) FROM stdin;
\.


--
-- TOC entry 5304 (class 0 OID 28139)
-- Dependencies: 230
-- Data for Name: precio_venta_historico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precio_venta_historico (id_precio_venta, producto_id, precio_unitario, margen_ganancia, fecha_inicio, fecha_fin, usuario_id) FROM stdin;
\.


--
-- TOC entry 5337 (class 0 OID 28495)
-- Dependencies: 263
-- Data for Name: precios_clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precios_clientes (id_acuerdo, cliente_id, producto_id, precio_acordado, margen_especial, fecha_inicio, fecha_fin, usuario_id, estado, observaciones) FROM stdin;
\.


--
-- TOC entry 5300 (class 0 OID 28105)
-- Dependencies: 226
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (id_producto, codigo_interno, nombre, categoria, requiere_trazabilidad, capacidad_volumen, tipo_producto, unidad_medida, gramaje, cuello, color, stock_minimo, estado) FROM stdin;
\.


--
-- TOC entry 5298 (class 0 OID 28091)
-- Dependencies: 224
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedores (id_proveedor, nombre, ruc, direccion, telefono, contacto, email, estado, fecha_creacion, fecha_actualizacion, tipo_proveedor, tipo_pago, tiempo_credito, usuario_id) FROM stdin;
\.


--
-- TOC entry 5292 (class 0 OID 28044)
-- Dependencies: 218
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id_rol, nombre, descripcion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Administrador	Rol con acceso total al sistema, incluyendo configuración, usuarios y módulos principales.	t	2025-11-09 20:45:35.734539	2025-11-09 20:45:35.734539
2	Operativo	Rol destinado al personal operativo con acceso limitado a funciones básicas y registro de datos.	t	2025-11-09 20:45:35.734539	2025-11-09 20:45:35.734539
\.


--
-- TOC entry 5341 (class 0 OID 28542)
-- Dependencies: 267
-- Data for Name: transportistas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transportistas (id_transportista, nombre, ruc, telefono, direccion, correo, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
\.


--
-- TOC entry 5294 (class 0 OID 28058)
-- Dependencies: 220
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre, usuario, email, password, rol_id, operador_turno, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Juan Gutierrez	jgutierrez	jgutierrez@plastecniva.com	6a3904d3808c250d33105a2269f69b5b	1	N/A	t	2025-11-09 20:46:23.472513	2025-11-09 20:46:23.472513
2	María Gómez	mgomez	mgomez@plastecniva.com	447325672f51ed08e85a1f75126b2c27	2	Turno A	t	2025-11-09 20:46:23.472513	2025-11-09 20:46:23.472513
\.


--
-- TOC entry 5417 (class 0 OID 0)
-- Dependencies: 244
-- Name: caja_preformas_id_caja_preforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.caja_preformas_id_caja_preforma_seq', 1, false);


--
-- TOC entry 5418 (class 0 OID 0)
-- Dependencies: 248
-- Name: clientes_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 1, false);


--
-- TOC entry 5419 (class 0 OID 0)
-- Dependencies: 264
-- Name: compromisos_venta_id_compromiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compromisos_venta_id_compromiso_seq', 1, false);


--
-- TOC entry 5420 (class 0 OID 0)
-- Dependencies: 252
-- Name: consumo_materia_prima_id_consumo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consumo_materia_prima_id_consumo_seq', 1, false);


--
-- TOC entry 5421 (class 0 OID 0)
-- Dependencies: 282
-- Name: control_calidad_materia_prima_id_control_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.control_calidad_materia_prima_id_control_seq', 1, false);


--
-- TOC entry 5422 (class 0 OID 0)
-- Dependencies: 284
-- Name: control_calidad_produccion_id_control_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.control_calidad_produccion_id_control_seq', 1, false);


--
-- TOC entry 5423 (class 0 OID 0)
-- Dependencies: 270
-- Name: cruce_stock_emergencia_id_cruce_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cruce_stock_emergencia_id_cruce_seq', 1, false);


--
-- TOC entry 5424 (class 0 OID 0)
-- Dependencies: 278
-- Name: cuenta_cobrar_id_cuenta_cobrar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_cobrar_id_cuenta_cobrar_seq', 1, false);


--
-- TOC entry 5425 (class 0 OID 0)
-- Dependencies: 290
-- Name: cuenta_pagar_id_cuenta_pagar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_pagar_id_cuenta_pagar_seq', 1, false);


--
-- TOC entry 5426 (class 0 OID 0)
-- Dependencies: 221
-- Name: datos_emisor_id_emisor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datos_emisor_id_emisor_seq', 1, false);


--
-- TOC entry 5427 (class 0 OID 0)
-- Dependencies: 272
-- Name: despachos_id_despacho_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.despachos_id_despacho_seq', 1, false);


--
-- TOC entry 5428 (class 0 OID 0)
-- Dependencies: 274
-- Name: detalle_despacho_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_despacho_id_detalle_seq', 1, false);


--
-- TOC entry 5429 (class 0 OID 0)
-- Dependencies: 238
-- Name: detalle_factura_compra_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_factura_compra_id_detalle_seq', 1, false);


--
-- TOC entry 5430 (class 0 OID 0)
-- Dependencies: 260
-- Name: detalle_factura_venta_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_factura_venta_id_detalle_seq', 1, false);


--
-- TOC entry 5431 (class 0 OID 0)
-- Dependencies: 276
-- Name: devoluciones_cliente_id_devolucion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.devoluciones_cliente_id_devolucion_seq', 1, false);


--
-- TOC entry 5432 (class 0 OID 0)
-- Dependencies: 286
-- Name: devoluciones_qc_id_devolucion_qc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.devoluciones_qc_id_devolucion_qc_seq', 1, false);


--
-- TOC entry 5433 (class 0 OID 0)
-- Dependencies: 234
-- Name: factura_compra_id_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_compra_id_factura_seq', 1, false);


--
-- TOC entry 5434 (class 0 OID 0)
-- Dependencies: 280
-- Name: factura_transporte_id_factura_transporte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_transporte_id_factura_transporte_seq', 1, false);


--
-- TOC entry 5435 (class 0 OID 0)
-- Dependencies: 258
-- Name: factura_venta_id_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_venta_id_factura_seq', 1, false);


--
-- TOC entry 5436 (class 0 OID 0)
-- Dependencies: 268
-- Name: guia_despacho_venta_id_guia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guia_despacho_venta_id_guia_seq', 1, false);


--
-- TOC entry 5437 (class 0 OID 0)
-- Dependencies: 240
-- Name: guia_remision_compra_id_guia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guia_remision_compra_id_guia_seq', 1, false);


--
-- TOC entry 5438 (class 0 OID 0)
-- Dependencies: 296
-- Name: historial_reportes_id_reporte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_reportes_id_reporte_seq', 1, false);


--
-- TOC entry 5439 (class 0 OID 0)
-- Dependencies: 254
-- Name: lote_produccion_id_lote_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lote_produccion_id_lote_seq', 1, false);


--
-- TOC entry 5440 (class 0 OID 0)
-- Dependencies: 236
-- Name: lotes_compra_id_lote_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lotes_compra_id_lote_seq', 1, false);


--
-- TOC entry 5441 (class 0 OID 0)
-- Dependencies: 242
-- Name: materia_prima_terceros_id_materia_prima_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.materia_prima_terceros_id_materia_prima_seq', 1, false);


--
-- TOC entry 5442 (class 0 OID 0)
-- Dependencies: 246
-- Name: movimiento_bodega_id_movimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimiento_bodega_id_movimiento_seq', 1, false);


--
-- TOC entry 5443 (class 0 OID 0)
-- Dependencies: 250
-- Name: orden_produccion_id_orden_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orden_produccion_id_orden_seq', 1, false);


--
-- TOC entry 5444 (class 0 OID 0)
-- Dependencies: 231
-- Name: ordenes_compra_id_orden_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordenes_compra_id_orden_compra_seq', 1, false);


--
-- TOC entry 5445 (class 0 OID 0)
-- Dependencies: 292
-- Name: pago_proveedor_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pago_proveedor_id_pago_seq', 1, false);


--
-- TOC entry 5446 (class 0 OID 0)
-- Dependencies: 294
-- Name: pago_transporte_id_pago_transporte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pago_transporte_id_pago_transporte_seq', 1, false);


--
-- TOC entry 5447 (class 0 OID 0)
-- Dependencies: 288
-- Name: pagos_factura_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_factura_id_pago_seq', 1, false);


--
-- TOC entry 5448 (class 0 OID 0)
-- Dependencies: 256
-- Name: perdidas_produccion_id_perdida_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perdidas_produccion_id_perdida_seq', 1, false);


--
-- TOC entry 5449 (class 0 OID 0)
-- Dependencies: 227
-- Name: precio_compra_historico_id_precio_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.precio_compra_historico_id_precio_compra_seq', 1, false);


--
-- TOC entry 5450 (class 0 OID 0)
-- Dependencies: 229
-- Name: precio_venta_historico_id_precio_venta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.precio_venta_historico_id_precio_venta_seq', 1, false);


--
-- TOC entry 5451 (class 0 OID 0)
-- Dependencies: 262
-- Name: precios_clientes_id_acuerdo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.precios_clientes_id_acuerdo_seq', 1, false);


--
-- TOC entry 5452 (class 0 OID 0)
-- Dependencies: 225
-- Name: producto_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_id_producto_seq', 1, false);


--
-- TOC entry 5453 (class 0 OID 0)
-- Dependencies: 223
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 1, false);


--
-- TOC entry 5454 (class 0 OID 0)
-- Dependencies: 217
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_rol_seq', 2, true);


--
-- TOC entry 5455 (class 0 OID 0)
-- Dependencies: 266
-- Name: transportistas_id_transportista_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transportistas_id_transportista_seq', 1, false);


--
-- TOC entry 5456 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 2, true);


--
-- TOC entry 4984 (class 2606 OID 28291)
-- Name: caja_preformas caja_preformas_numero_caja_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_preformas
    ADD CONSTRAINT caja_preformas_numero_caja_key UNIQUE (numero_caja);


--
-- TOC entry 4986 (class 2606 OID 28289)
-- Name: caja_preformas caja_preformas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_preformas
    ADD CONSTRAINT caja_preformas_pkey PRIMARY KEY (id_caja_preforma);


--
-- TOC entry 4990 (class 2606 OID 28344)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4992 (class 2606 OID 28346)
-- Name: clientes clientes_ruc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_ruc_key UNIQUE (ruc);


--
-- TOC entry 5014 (class 2606 OID 28530)
-- Name: compromisos_venta compromisos_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compromisos_venta
    ADD CONSTRAINT compromisos_venta_pkey PRIMARY KEY (id_compromiso);


--
-- TOC entry 4998 (class 2606 OID 28392)
-- Name: consumo_materia_prima consumo_materia_prima_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumo_materia_prima
    ADD CONSTRAINT consumo_materia_prima_pkey PRIMARY KEY (id_consumo);


--
-- TOC entry 5040 (class 2606 OID 28735)
-- Name: control_calidad_materia_prima control_calidad_materia_prima_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_materia_prima
    ADD CONSTRAINT control_calidad_materia_prima_pkey PRIMARY KEY (id_control);


--
-- TOC entry 5042 (class 2606 OID 28757)
-- Name: control_calidad_produccion control_calidad_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_produccion
    ADD CONSTRAINT control_calidad_produccion_pkey PRIMARY KEY (id_control);


--
-- TOC entry 5024 (class 2606 OID 28593)
-- Name: cruce_stock_emergencia cruce_stock_emergencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cruce_stock_emergencia
    ADD CONSTRAINT cruce_stock_emergencia_pkey PRIMARY KEY (id_cruce);


--
-- TOC entry 5034 (class 2606 OID 28694)
-- Name: cuenta_cobrar cuenta_cobrar_factura_venta_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_cobrar
    ADD CONSTRAINT cuenta_cobrar_factura_venta_id_key UNIQUE (factura_venta_id);


--
-- TOC entry 5036 (class 2606 OID 28692)
-- Name: cuenta_cobrar cuenta_cobrar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_cobrar
    ADD CONSTRAINT cuenta_cobrar_pkey PRIMARY KEY (id_cuenta_cobrar);


--
-- TOC entry 5050 (class 2606 OID 28817)
-- Name: cuenta_pagar cuenta_pagar_factura_compra_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT cuenta_pagar_factura_compra_id_key UNIQUE (factura_compra_id);


--
-- TOC entry 5052 (class 2606 OID 28819)
-- Name: cuenta_pagar cuenta_pagar_factura_transporte_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT cuenta_pagar_factura_transporte_id_key UNIQUE (factura_transporte_id);


--
-- TOC entry 5054 (class 2606 OID 28815)
-- Name: cuenta_pagar cuenta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT cuenta_pagar_pkey PRIMARY KEY (id_cuenta_pagar);


--
-- TOC entry 4948 (class 2606 OID 28087)
-- Name: datos_emisor datos_emisor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_emisor
    ADD CONSTRAINT datos_emisor_pkey PRIMARY KEY (id_emisor);


--
-- TOC entry 4950 (class 2606 OID 28089)
-- Name: datos_emisor datos_emisor_ruc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_emisor
    ADD CONSTRAINT datos_emisor_ruc_key UNIQUE (ruc);


--
-- TOC entry 5026 (class 2606 OID 28620)
-- Name: despachos despachos_guia_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachos
    ADD CONSTRAINT despachos_guia_id_key UNIQUE (guia_id);


--
-- TOC entry 5028 (class 2606 OID 28618)
-- Name: despachos despachos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachos
    ADD CONSTRAINT despachos_pkey PRIMARY KEY (id_despacho);


--
-- TOC entry 5030 (class 2606 OID 28637)
-- Name: detalle_despacho detalle_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_despacho
    ADD CONSTRAINT detalle_despacho_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 4976 (class 2606 OID 28237)
-- Name: detalle_factura_compra detalle_factura_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_compra
    ADD CONSTRAINT detalle_factura_compra_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 5008 (class 2606 OID 28478)
-- Name: detalle_factura_venta detalle_factura_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_venta
    ADD CONSTRAINT detalle_factura_venta_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 4968 (class 2606 OID 28180)
-- Name: detalle_orden_compra detalle_orden_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_pkey PRIMARY KEY (orden_id, producto_id);


--
-- TOC entry 5032 (class 2606 OID 28665)
-- Name: devoluciones_cliente devoluciones_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_cliente
    ADD CONSTRAINT devoluciones_cliente_pkey PRIMARY KEY (id_devolucion);


--
-- TOC entry 5044 (class 2606 OID 28781)
-- Name: devoluciones_qc devoluciones_qc_devolucion_cliente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_qc
    ADD CONSTRAINT devoluciones_qc_devolucion_cliente_id_key UNIQUE (devolucion_cliente_id);


--
-- TOC entry 5046 (class 2606 OID 28779)
-- Name: devoluciones_qc devoluciones_qc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_qc
    ADD CONSTRAINT devoluciones_qc_pkey PRIMARY KEY (id_devolucion_qc);


--
-- TOC entry 4970 (class 2606 OID 28200)
-- Name: factura_compra factura_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_compra
    ADD CONSTRAINT factura_compra_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 5038 (class 2606 OID 28714)
-- Name: factura_transporte factura_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_transporte
    ADD CONSTRAINT factura_transporte_pkey PRIMARY KEY (id_factura_transporte);


--
-- TOC entry 5004 (class 2606 OID 50621)
-- Name: factura_venta factura_venta_numero_factura_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta
    ADD CONSTRAINT factura_venta_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 5006 (class 2606 OID 28458)
-- Name: factura_venta factura_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta
    ADD CONSTRAINT factura_venta_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 5020 (class 2606 OID 28565)
-- Name: guia_despacho_venta guia_despacho_venta_numero_guia_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta
    ADD CONSTRAINT guia_despacho_venta_numero_guia_key UNIQUE (numero_guia);


--
-- TOC entry 5022 (class 2606 OID 28563)
-- Name: guia_despacho_venta guia_despacho_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta
    ADD CONSTRAINT guia_despacho_venta_pkey PRIMARY KEY (id_guia);


--
-- TOC entry 4978 (class 2606 OID 28263)
-- Name: guia_remision_compra guia_remision_compra_factura_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_remision_compra
    ADD CONSTRAINT guia_remision_compra_factura_id_key UNIQUE (factura_id);


--
-- TOC entry 4980 (class 2606 OID 28261)
-- Name: guia_remision_compra guia_remision_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_remision_compra
    ADD CONSTRAINT guia_remision_compra_pkey PRIMARY KEY (id_guia);


--
-- TOC entry 5060 (class 2606 OID 28883)
-- Name: historial_reportes historial_reportes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reportes
    ADD CONSTRAINT historial_reportes_pkey PRIMARY KEY (id_reporte);


--
-- TOC entry 5000 (class 2606 OID 28415)
-- Name: lote_produccion lote_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote_produccion
    ADD CONSTRAINT lote_produccion_pkey PRIMARY KEY (id_lote);


--
-- TOC entry 4972 (class 2606 OID 28220)
-- Name: lotes_compra lotes_compra_codigo_lote_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT lotes_compra_codigo_lote_key UNIQUE (codigo_lote);


--
-- TOC entry 4974 (class 2606 OID 28218)
-- Name: lotes_compra lotes_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT lotes_compra_pkey PRIMARY KEY (id_lote);


--
-- TOC entry 4982 (class 2606 OID 28279)
-- Name: materia_prima_terceros materia_prima_terceros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materia_prima_terceros
    ADD CONSTRAINT materia_prima_terceros_pkey PRIMARY KEY (id_materia_prima_terceros);


--
-- TOC entry 4988 (class 2606 OID 28316)
-- Name: movimiento_bodega movimiento_bodega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT movimiento_bodega_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 4994 (class 2606 OID 28367)
-- Name: orden_produccion orden_produccion_numero_op_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_produccion
    ADD CONSTRAINT orden_produccion_numero_op_key UNIQUE (numero_op);


--
-- TOC entry 4996 (class 2606 OID 28365)
-- Name: orden_produccion orden_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_produccion
    ADD CONSTRAINT orden_produccion_pkey PRIMARY KEY (id_orden);


--
-- TOC entry 4964 (class 2606 OID 28165)
-- Name: ordenes_compra ordenes_compra_numero_orden_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compra
    ADD CONSTRAINT ordenes_compra_numero_orden_key UNIQUE (numero_orden);


--
-- TOC entry 4966 (class 2606 OID 28163)
-- Name: ordenes_compra ordenes_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compra
    ADD CONSTRAINT ordenes_compra_pkey PRIMARY KEY (id_orden_compra);


--
-- TOC entry 5056 (class 2606 OID 28846)
-- Name: pago_proveedor pago_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_proveedor
    ADD CONSTRAINT pago_proveedor_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 5058 (class 2606 OID 28863)
-- Name: pago_transporte pago_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_transporte
    ADD CONSTRAINT pago_transporte_pkey PRIMARY KEY (id_pago_transporte);


--
-- TOC entry 5048 (class 2606 OID 28798)
-- Name: pagos_factura pagos_factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_factura
    ADD CONSTRAINT pagos_factura_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 5002 (class 2606 OID 28441)
-- Name: perdidas_produccion perdidas_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perdidas_produccion
    ADD CONSTRAINT perdidas_produccion_pkey PRIMARY KEY (id_perdida);


--
-- TOC entry 4960 (class 2606 OID 28122)
-- Name: precio_compra_historico precio_compra_historico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_compra_historico
    ADD CONSTRAINT precio_compra_historico_pkey PRIMARY KEY (id_precio_compra);


--
-- TOC entry 4962 (class 2606 OID 28144)
-- Name: precio_venta_historico precio_venta_historico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_venta_historico
    ADD CONSTRAINT precio_venta_historico_pkey PRIMARY KEY (id_precio_venta);


--
-- TOC entry 5010 (class 2606 OID 28503)
-- Name: precios_clientes precios_clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precios_clientes
    ADD CONSTRAINT precios_clientes_pkey PRIMARY KEY (id_acuerdo);


--
-- TOC entry 4956 (class 2606 OID 28115)
-- Name: producto producto_codigo_interno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_codigo_interno_key UNIQUE (codigo_interno);


--
-- TOC entry 4958 (class 2606 OID 28113)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 4952 (class 2606 OID 28101)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 4954 (class 2606 OID 28103)
-- Name: proveedores proveedores_ruc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_ruc_key UNIQUE (ruc);


--
-- TOC entry 4938 (class 2606 OID 28056)
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- TOC entry 4940 (class 2606 OID 28054)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 5016 (class 2606 OID 28552)
-- Name: transportistas transportistas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transportistas
    ADD CONSTRAINT transportistas_pkey PRIMARY KEY (id_transportista);


--
-- TOC entry 5018 (class 2606 OID 28554)
-- Name: transportistas transportistas_ruc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transportistas
    ADD CONSTRAINT transportistas_ruc_key UNIQUE (ruc);


--
-- TOC entry 5012 (class 2606 OID 28505)
-- Name: precios_clientes uq_cliente_producto_fecha; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precios_clientes
    ADD CONSTRAINT uq_cliente_producto_fecha UNIQUE (cliente_id, producto_id, fecha_inicio);


--
-- TOC entry 4942 (class 2606 OID 28072)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4944 (class 2606 OID 28068)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4946 (class 2606 OID 28070)
-- Name: usuarios usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 5082 (class 2606 OID 28297)
-- Name: caja_preformas fk_cajap_lotecompra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_preformas
    ADD CONSTRAINT fk_cajap_lotecompra FOREIGN KEY (lote_compra_id) REFERENCES public.lotes_compra(id_lote);


--
-- TOC entry 5083 (class 2606 OID 28302)
-- Name: caja_preformas fk_cajap_mpterceros; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_preformas
    ADD CONSTRAINT fk_cajap_mpterceros FOREIGN KEY (materia_prima_terceros_id) REFERENCES public.materia_prima_terceros(id_materia_prima_terceros);


--
-- TOC entry 5084 (class 2606 OID 28292)
-- Name: caja_preformas fk_cajap_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_preformas
    ADD CONSTRAINT fk_cajap_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5130 (class 2606 OID 28736)
-- Name: control_calidad_materia_prima fk_ccmp_lote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_materia_prima
    ADD CONSTRAINT fk_ccmp_lote FOREIGN KEY (lote_mp_id) REFERENCES public.lotes_compra(id_lote);


--
-- TOC entry 5131 (class 2606 OID 28741)
-- Name: control_calidad_materia_prima fk_ccmp_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_materia_prima
    ADD CONSTRAINT fk_ccmp_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5132 (class 2606 OID 28758)
-- Name: control_calidad_produccion fk_ccp_lote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_produccion
    ADD CONSTRAINT fk_ccp_lote FOREIGN KEY (lote_produccion_id) REFERENCES public.lote_produccion(id_lote);


--
-- TOC entry 5133 (class 2606 OID 28763)
-- Name: control_calidad_produccion fk_ccp_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad_produccion
    ADD CONSTRAINT fk_ccp_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5106 (class 2606 OID 28531)
-- Name: compromisos_venta fk_compromisosventa_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compromisos_venta
    ADD CONSTRAINT fk_compromisosventa_factura FOREIGN KEY (factura_id) REFERENCES public.factura_venta(id_factura);


--
-- TOC entry 5107 (class 2606 OID 28536)
-- Name: compromisos_venta fk_compromisosventa_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compromisos_venta
    ADD CONSTRAINT fk_compromisosventa_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5092 (class 2606 OID 28398)
-- Name: consumo_materia_prima fk_consumomp_caja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumo_materia_prima
    ADD CONSTRAINT fk_consumomp_caja FOREIGN KEY (caja_id) REFERENCES public.caja_preformas(id_caja_preforma);


--
-- TOC entry 5093 (class 2606 OID 28403)
-- Name: consumo_materia_prima fk_consumomp_mpterceros; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumo_materia_prima
    ADD CONSTRAINT fk_consumomp_mpterceros FOREIGN KEY (materia_prima_terceros_id) REFERENCES public.materia_prima_terceros(id_materia_prima_terceros);


--
-- TOC entry 5094 (class 2606 OID 28393)
-- Name: consumo_materia_prima fk_consumomp_orden; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumo_materia_prima
    ADD CONSTRAINT fk_consumomp_orden FOREIGN KEY (orden_id) REFERENCES public.orden_produccion(id_orden);


--
-- TOC entry 5112 (class 2606 OID 28594)
-- Name: cruce_stock_emergencia fk_cse_compromiso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cruce_stock_emergencia
    ADD CONSTRAINT fk_cse_compromiso FOREIGN KEY (compromiso_id) REFERENCES public.compromisos_venta(id_compromiso);


--
-- TOC entry 5113 (class 2606 OID 28599)
-- Name: cruce_stock_emergencia fk_cse_lote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cruce_stock_emergencia
    ADD CONSTRAINT fk_cse_lote FOREIGN KEY (lote_id) REFERENCES public.lote_produccion(id_lote);


--
-- TOC entry 5114 (class 2606 OID 28604)
-- Name: cruce_stock_emergencia fk_cse_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cruce_stock_emergencia
    ADD CONSTRAINT fk_cse_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5125 (class 2606 OID 28700)
-- Name: cuenta_cobrar fk_cxc_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_cobrar
    ADD CONSTRAINT fk_cxc_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 5126 (class 2606 OID 28695)
-- Name: cuenta_cobrar fk_cxc_facturaventa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_cobrar
    ADD CONSTRAINT fk_cxc_facturaventa FOREIGN KEY (factura_venta_id) REFERENCES public.factura_venta(id_factura);


--
-- TOC entry 5138 (class 2606 OID 28825)
-- Name: cuenta_pagar fk_cxp_fc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT fk_cxp_fc FOREIGN KEY (factura_compra_id) REFERENCES public.factura_compra(id_factura);


--
-- TOC entry 5139 (class 2606 OID 28830)
-- Name: cuenta_pagar fk_cxp_ft; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT fk_cxp_ft FOREIGN KEY (factura_transporte_id) REFERENCES public.factura_transporte(id_factura_transporte);


--
-- TOC entry 5140 (class 2606 OID 28820)
-- Name: cuenta_pagar fk_cxp_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT fk_cxp_proveedor FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor);


--
-- TOC entry 5115 (class 2606 OID 28621)
-- Name: despachos fk_despachos_guia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachos
    ADD CONSTRAINT fk_despachos_guia FOREIGN KEY (guia_id) REFERENCES public.guia_despacho_venta(id_guia);


--
-- TOC entry 5116 (class 2606 OID 28626)
-- Name: despachos fk_despachos_transportista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachos
    ADD CONSTRAINT fk_despachos_transportista FOREIGN KEY (transportista_id) REFERENCES public.transportistas(id_transportista);


--
-- TOC entry 5100 (class 2606 OID 28479)
-- Name: detalle_factura_venta fk_detallefv_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_venta
    ADD CONSTRAINT fk_detallefv_factura FOREIGN KEY (factura_id) REFERENCES public.factura_venta(id_factura);


--
-- TOC entry 5101 (class 2606 OID 28489)
-- Name: detalle_factura_venta fk_detallefv_lote_produccion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_venta
    ADD CONSTRAINT fk_detallefv_lote_produccion FOREIGN KEY (lote_produccion_id) REFERENCES public.lote_produccion(id_lote);


--
-- TOC entry 5102 (class 2606 OID 28484)
-- Name: detalle_factura_venta fk_detallefv_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_venta
    ADD CONSTRAINT fk_detallefv_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5117 (class 2606 OID 28643)
-- Name: detalle_despacho fk_detdes_compromiso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_despacho
    ADD CONSTRAINT fk_detdes_compromiso FOREIGN KEY (compromiso_id) REFERENCES public.compromisos_venta(id_compromiso);


--
-- TOC entry 5118 (class 2606 OID 28638)
-- Name: detalle_despacho fk_detdes_despacho; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_despacho
    ADD CONSTRAINT fk_detdes_despacho FOREIGN KEY (despacho_id) REFERENCES public.despachos(id_despacho);


--
-- TOC entry 5119 (class 2606 OID 28648)
-- Name: detalle_despacho fk_detdes_lote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_despacho
    ADD CONSTRAINT fk_detdes_lote FOREIGN KEY (lote_produccion_id) REFERENCES public.lote_produccion(id_lote);


--
-- TOC entry 5120 (class 2606 OID 28653)
-- Name: detalle_despacho fk_detdes_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_despacho
    ADD CONSTRAINT fk_detdes_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5076 (class 2606 OID 28238)
-- Name: detalle_factura_compra fk_detfc_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_compra
    ADD CONSTRAINT fk_detfc_factura FOREIGN KEY (factura_id) REFERENCES public.factura_compra(id_factura);


--
-- TOC entry 5077 (class 2606 OID 28248)
-- Name: detalle_factura_compra fk_detfc_lote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_compra
    ADD CONSTRAINT fk_detfc_lote FOREIGN KEY (lote_id) REFERENCES public.lotes_compra(id_lote);


--
-- TOC entry 5078 (class 2606 OID 28243)
-- Name: detalle_factura_compra fk_detfc_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura_compra
    ADD CONSTRAINT fk_detfc_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5070 (class 2606 OID 28181)
-- Name: detalle_orden_compra fk_detoc_orden; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden_compra
    ADD CONSTRAINT fk_detoc_orden FOREIGN KEY (orden_id) REFERENCES public.ordenes_compra(id_orden_compra);


--
-- TOC entry 5071 (class 2606 OID 28186)
-- Name: detalle_orden_compra fk_detoc_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden_compra
    ADD CONSTRAINT fk_detoc_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5121 (class 2606 OID 28671)
-- Name: devoluciones_cliente fk_devc_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_cliente
    ADD CONSTRAINT fk_devc_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 5122 (class 2606 OID 28666)
-- Name: devoluciones_cliente fk_devc_despacho; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_cliente
    ADD CONSTRAINT fk_devc_despacho FOREIGN KEY (despacho_id) REFERENCES public.despachos(id_despacho);


--
-- TOC entry 5123 (class 2606 OID 28681)
-- Name: devoluciones_cliente fk_devc_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_cliente
    ADD CONSTRAINT fk_devc_factura FOREIGN KEY (factura_id) REFERENCES public.factura_venta(id_factura);


--
-- TOC entry 5124 (class 2606 OID 28676)
-- Name: devoluciones_cliente fk_devc_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_cliente
    ADD CONSTRAINT fk_devc_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5134 (class 2606 OID 28782)
-- Name: devoluciones_qc fk_devqc_devolucion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_qc
    ADD CONSTRAINT fk_devqc_devolucion FOREIGN KEY (devolucion_cliente_id) REFERENCES public.devoluciones_cliente(id_devolucion);


--
-- TOC entry 5135 (class 2606 OID 28787)
-- Name: devoluciones_qc fk_devqc_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devoluciones_qc
    ADD CONSTRAINT fk_devqc_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5098 (class 2606 OID 28461)
-- Name: factura_venta fk_facturaventa_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta
    ADD CONSTRAINT fk_facturaventa_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 5099 (class 2606 OID 28466)
-- Name: factura_venta fk_facturaventa_emisor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta
    ADD CONSTRAINT fk_facturaventa_emisor FOREIGN KEY (emisor_id) REFERENCES public.datos_emisor(id_emisor);


--
-- TOC entry 5072 (class 2606 OID 28206)
-- Name: factura_compra fk_fc_ordencompra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_compra
    ADD CONSTRAINT fk_fc_ordencompra FOREIGN KEY (orden_compra_id) REFERENCES public.ordenes_compra(id_orden_compra);


--
-- TOC entry 5073 (class 2606 OID 28201)
-- Name: factura_compra fk_fc_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_compra
    ADD CONSTRAINT fk_fc_proveedor FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor);


--
-- TOC entry 5127 (class 2606 OID 28835)
-- Name: factura_transporte fk_ftrans_cxp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_transporte
    ADD CONSTRAINT fk_ftrans_cxp FOREIGN KEY (cuenta_pagar_id) REFERENCES public.cuenta_pagar(id_cuenta_pagar);


--
-- TOC entry 5128 (class 2606 OID 28720)
-- Name: factura_transporte fk_ftrans_despacho; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_transporte
    ADD CONSTRAINT fk_ftrans_despacho FOREIGN KEY (despacho_id) REFERENCES public.despachos(id_despacho);


--
-- TOC entry 5129 (class 2606 OID 28715)
-- Name: factura_transporte fk_ftrans_transportista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_transporte
    ADD CONSTRAINT fk_ftrans_transportista FOREIGN KEY (transportista_id) REFERENCES public.transportistas(id_transportista);


--
-- TOC entry 5108 (class 2606 OID 28581)
-- Name: guia_despacho_venta fk_gdv_compromiso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta
    ADD CONSTRAINT fk_gdv_compromiso FOREIGN KEY (compromiso_id) REFERENCES public.compromisos_venta(id_compromiso);


--
-- TOC entry 5109 (class 2606 OID 28571)
-- Name: guia_despacho_venta fk_gdv_emisor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta
    ADD CONSTRAINT fk_gdv_emisor FOREIGN KEY (emisor_id) REFERENCES public.datos_emisor(id_emisor);


--
-- TOC entry 5110 (class 2606 OID 28566)
-- Name: guia_despacho_venta fk_gdv_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta
    ADD CONSTRAINT fk_gdv_factura FOREIGN KEY (factura_id) REFERENCES public.factura_venta(id_factura);


--
-- TOC entry 5111 (class 2606 OID 28576)
-- Name: guia_despacho_venta fk_gdv_transportista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_despacho_venta
    ADD CONSTRAINT fk_gdv_transportista FOREIGN KEY (transportista_id) REFERENCES public.transportistas(id_transportista);


--
-- TOC entry 5079 (class 2606 OID 28264)
-- Name: guia_remision_compra fk_grc_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guia_remision_compra
    ADD CONSTRAINT fk_grc_factura FOREIGN KEY (factura_id) REFERENCES public.factura_compra(id_factura);


--
-- TOC entry 5145 (class 2606 OID 28884)
-- Name: historial_reportes fk_historialr_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reportes
    ADD CONSTRAINT fk_historialr_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5095 (class 2606 OID 28416)
-- Name: lote_produccion fk_loteprod_orden; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote_produccion
    ADD CONSTRAINT fk_loteprod_orden FOREIGN KEY (orden_id) REFERENCES public.orden_produccion(id_orden);


--
-- TOC entry 5096 (class 2606 OID 28421)
-- Name: lote_produccion fk_loteprod_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote_produccion
    ADD CONSTRAINT fk_loteprod_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5074 (class 2606 OID 28221)
-- Name: lotes_compra fk_lotesc_factura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT fk_lotesc_factura FOREIGN KEY (factura_id) REFERENCES public.factura_compra(id_factura);


--
-- TOC entry 5075 (class 2606 OID 28226)
-- Name: lotes_compra fk_lotesc_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotes_compra
    ADD CONSTRAINT fk_lotesc_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5085 (class 2606 OID 28322)
-- Name: movimiento_bodega fk_movb_lotecompra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT fk_movb_lotecompra FOREIGN KEY (lote_id) REFERENCES public.lotes_compra(id_lote);


--
-- TOC entry 5086 (class 2606 OID 28426)
-- Name: movimiento_bodega fk_movb_loteproduccion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT fk_movb_loteproduccion FOREIGN KEY (lote_produccion_id) REFERENCES public.lote_produccion(id_lote);


--
-- TOC entry 5087 (class 2606 OID 28317)
-- Name: movimiento_bodega fk_movb_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT fk_movb_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5088 (class 2606 OID 28327)
-- Name: movimiento_bodega fk_movb_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento_bodega
    ADD CONSTRAINT fk_movb_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5080 (class 2606 OID 28347)
-- Name: materia_prima_terceros fk_mpterceros_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materia_prima_terceros
    ADD CONSTRAINT fk_mpterceros_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 5081 (class 2606 OID 28352)
-- Name: materia_prima_terceros fk_mpterceros_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materia_prima_terceros
    ADD CONSTRAINT fk_mpterceros_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5068 (class 2606 OID 28166)
-- Name: ordenes_compra fk_oc_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compra
    ADD CONSTRAINT fk_oc_proveedor FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor);


--
-- TOC entry 5069 (class 2606 OID 28171)
-- Name: ordenes_compra fk_oc_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes_compra
    ADD CONSTRAINT fk_oc_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5089 (class 2606 OID 28378)
-- Name: orden_produccion fk_op_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_produccion
    ADD CONSTRAINT fk_op_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 5090 (class 2606 OID 28368)
-- Name: orden_produccion fk_op_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_produccion
    ADD CONSTRAINT fk_op_producto FOREIGN KEY (producto_terminado_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5091 (class 2606 OID 28373)
-- Name: orden_produccion fk_op_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_produccion
    ADD CONSTRAINT fk_op_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5141 (class 2606 OID 28847)
-- Name: pago_proveedor fk_pagop_cxp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_proveedor
    ADD CONSTRAINT fk_pagop_cxp FOREIGN KEY (cuenta_pagar_id) REFERENCES public.cuenta_pagar(id_cuenta_pagar);


--
-- TOC entry 5142 (class 2606 OID 28852)
-- Name: pago_proveedor fk_pagop_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_proveedor
    ADD CONSTRAINT fk_pagop_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5136 (class 2606 OID 28799)
-- Name: pagos_factura fk_pagosf_cxc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_factura
    ADD CONSTRAINT fk_pagosf_cxc FOREIGN KEY (cuenta_cobrar_id) REFERENCES public.cuenta_cobrar(id_cuenta_cobrar);


--
-- TOC entry 5137 (class 2606 OID 28804)
-- Name: pagos_factura fk_pagosf_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_factura
    ADD CONSTRAINT fk_pagosf_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5143 (class 2606 OID 28864)
-- Name: pago_transporte fk_pagot_cxp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_transporte
    ADD CONSTRAINT fk_pagot_cxp FOREIGN KEY (cuenta_pagar_id) REFERENCES public.cuenta_pagar(id_cuenta_pagar);


--
-- TOC entry 5144 (class 2606 OID 28869)
-- Name: pago_transporte fk_pagot_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago_transporte
    ADD CONSTRAINT fk_pagot_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5097 (class 2606 OID 28442)
-- Name: perdidas_produccion fk_perdidasp_lote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perdidas_produccion
    ADD CONSTRAINT fk_perdidasp_lote FOREIGN KEY (lote_id) REFERENCES public.lote_produccion(id_lote);


--
-- TOC entry 5063 (class 2606 OID 28123)
-- Name: precio_compra_historico fk_precioch_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_compra_historico
    ADD CONSTRAINT fk_precioch_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5064 (class 2606 OID 28128)
-- Name: precio_compra_historico fk_precioch_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_compra_historico
    ADD CONSTRAINT fk_precioch_proveedor FOREIGN KEY (proveedor_id) REFERENCES public.proveedores(id_proveedor);


--
-- TOC entry 5065 (class 2606 OID 28133)
-- Name: precio_compra_historico fk_precioch_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_compra_historico
    ADD CONSTRAINT fk_precioch_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5066 (class 2606 OID 28145)
-- Name: precio_venta_historico fk_precionvh_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_venta_historico
    ADD CONSTRAINT fk_precionvh_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5067 (class 2606 OID 28150)
-- Name: precio_venta_historico fk_precionvh_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_venta_historico
    ADD CONSTRAINT fk_precionvh_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5103 (class 2606 OID 28506)
-- Name: precios_clientes fk_preciosclientes_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precios_clientes
    ADD CONSTRAINT fk_preciosclientes_cliente FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 5104 (class 2606 OID 28511)
-- Name: precios_clientes fk_preciosclientes_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precios_clientes
    ADD CONSTRAINT fk_preciosclientes_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id_producto);


--
-- TOC entry 5105 (class 2606 OID 28516)
-- Name: precios_clientes fk_preciosclientes_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precios_clientes
    ADD CONSTRAINT fk_preciosclientes_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 5062 (class 2606 OID 67003)
-- Name: proveedores fk_proveedores_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT fk_proveedores_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5061 (class 2606 OID 28073)
-- Name: usuarios fk_usuarios_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_rol FOREIGN KEY (rol_id) REFERENCES public.roles(id_rol);


-- Completed on 2026-01-12 16:11:47

--
-- PostgreSQL database dump complete
--

