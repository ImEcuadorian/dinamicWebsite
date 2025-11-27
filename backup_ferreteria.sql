--
-- PostgreSQL database dump
--

\restrict dWtwybxx7z4zuPDLS2VJTbNNvoABAhPCkYgMiDtt5dMLFjgPT6bpKpOq4aPfucb

-- Dumped from database version 13.5
-- Dumped by pg_dump version 18.1

-- Started on 2025-11-27 10:30:09

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
-- TOC entry 6 (class 2615 OID 23954)
-- Name: auditoria; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auditoria;


ALTER SCHEMA auditoria OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 23953)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 244 (class 1255 OID 23955)
-- Name: fn_log_audit(); Type: FUNCTION; Schema: auditoria; Owner: postgres
--

CREATE FUNCTION auditoria.fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO auditoria.tb_auditoria(tabla_aud, operacion_aud, valor_anterior, valor_nuevo,
                                           usuario_db, esquema_db)
        VALUES (TG_TABLE_NAME, 'DELETE', row_to_json(OLD)::text, NULL,
                SESSION_USER, TG_TABLE_SCHEMA);
        RETURN OLD;

    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO auditoria.tb_auditoria(tabla_aud, operacion_aud, valor_anterior, valor_nuevo,
                                           usuario_db, esquema_db)
        VALUES (TG_TABLE_NAME, 'UPDATE', row_to_json(OLD)::text, row_to_json(NEW)::text,
                SESSION_USER, TG_TABLE_SCHEMA);
        RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO auditoria.tb_auditoria(tabla_aud, operacion_aud, valor_anterior, valor_nuevo,
                                           usuario_db, esquema_db)
        VALUES (TG_TABLE_NAME, 'INSERT', NULL, row_to_json(NEW)::text,
                SESSION_USER, TG_TABLE_SCHEMA);
        RETURN NEW;
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION auditoria.fn_log_audit() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 23956)
-- Name: tb_auditoria; Type: TABLE; Schema: auditoria; Owner: postgres
--

CREATE TABLE auditoria.tb_auditoria (
    id_aud integer NOT NULL,
    tabla_aud text NOT NULL,
    operacion_aud text NOT NULL,
    valor_anterior text,
    valor_nuevo text,
    fecha timestamp without time zone DEFAULT now(),
    usuario_db text,
    esquema_db text
);


ALTER TABLE auditoria.tb_auditoria OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 23963)
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE; Schema: auditoria; Owner: postgres
--

CREATE SEQUENCE auditoria.tb_auditoria_id_aud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auditoria.tb_auditoria_id_aud_seq OWNER TO postgres;

--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 202
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: postgres
--

ALTER SEQUENCE auditoria.tb_auditoria_id_aud_seq OWNED BY auditoria.tb_auditoria.id_aud;


--
-- TOC entry 203 (class 1259 OID 23965)
-- Name: tb_carrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_carrito (
    id_car integer NOT NULL,
    id_us integer,
    id_pr integer,
    cantidad integer DEFAULT 1,
    fecha_agregado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    subtotal numeric(10,2) DEFAULT 0,
    id_serv integer
);


ALTER TABLE public.tb_carrito OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 23971)
-- Name: tb_carrito_id_car_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_carrito_id_car_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_carrito_id_car_seq OWNER TO postgres;

--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 204
-- Name: tb_carrito_id_car_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_carrito_id_car_seq OWNED BY public.tb_carrito.id_car;


--
-- TOC entry 205 (class 1259 OID 23973)
-- Name: tb_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_categoria (
    id_cat integer NOT NULL,
    descripcion_cat text NOT NULL
);


ALTER TABLE public.tb_categoria OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 23979)
-- Name: tb_categoria_id_cat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_categoria_id_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_categoria_id_cat_seq OWNER TO postgres;

--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 206
-- Name: tb_categoria_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_categoria_id_cat_seq OWNED BY public.tb_categoria.id_cat;


--
-- TOC entry 207 (class 1259 OID 23981)
-- Name: tb_detalle_orden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_detalle_orden (
    id_det integer NOT NULL,
    id_orden integer NOT NULL,
    id_pr integer NOT NULL,
    cantidad integer NOT NULL,
    subtotal numeric(10,2)
);


ALTER TABLE public.tb_detalle_orden OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 23984)
-- Name: tb_detalle_orden_id_det_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_detalle_orden_id_det_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_detalle_orden_id_det_seq OWNER TO postgres;

--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 208
-- Name: tb_detalle_orden_id_det_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_detalle_orden_id_det_seq OWNED BY public.tb_detalle_orden.id_det;


--
-- TOC entry 209 (class 1259 OID 23986)
-- Name: tb_detalle_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_detalle_servicio (
    id_det_serv integer NOT NULL,
    id_orden integer NOT NULL,
    id_serv integer NOT NULL,
    cantidad integer NOT NULL,
    subtotal numeric(10,2)
);


ALTER TABLE public.tb_detalle_servicio OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 23989)
-- Name: tb_detalle_servicio_id_det_serv_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_detalle_servicio_id_det_serv_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_detalle_servicio_id_det_serv_seq OWNER TO postgres;

--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 210
-- Name: tb_detalle_servicio_id_det_serv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_detalle_servicio_id_det_serv_seq OWNED BY public.tb_detalle_servicio.id_det_serv;


--
-- TOC entry 211 (class 1259 OID 23991)
-- Name: tb_estadocivil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_estadocivil (
    id_est integer NOT NULL,
    descripcion_est text NOT NULL
);


ALTER TABLE public.tb_estadocivil OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 23997)
-- Name: tb_estadocivil_id_est_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_estadocivil_id_est_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_estadocivil_id_est_seq OWNER TO postgres;

--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 212
-- Name: tb_estadocivil_id_est_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_estadocivil_id_est_seq OWNED BY public.tb_estadocivil.id_est;


--
-- TOC entry 213 (class 1259 OID 23999)
-- Name: tb_historial_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_historial_servicio (
    id_hist integer NOT NULL,
    id_us integer NOT NULL,
    id_serv integer NOT NULL,
    cantidad integer NOT NULL,
    subtotal numeric(10,2),
    fecha timestamp without time zone DEFAULT now(),
    estado character varying(20) DEFAULT 'Pendiente'::character varying
);


ALTER TABLE public.tb_historial_servicio OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24004)
-- Name: tb_historial_servicio_id_hist_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_historial_servicio_id_hist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_historial_servicio_id_hist_seq OWNER TO postgres;

--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 214
-- Name: tb_historial_servicio_id_hist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_historial_servicio_id_hist_seq OWNED BY public.tb_historial_servicio.id_hist;


--
-- TOC entry 215 (class 1259 OID 24006)
-- Name: tb_orden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_orden (
    id_orden integer NOT NULL,
    id_us integer NOT NULL,
    fecha timestamp without time zone DEFAULT now(),
    total numeric(10,2),
    estado character varying(20) DEFAULT 'Pagado'::character varying
);


ALTER TABLE public.tb_orden OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24011)
-- Name: tb_orden_id_orden_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_orden_id_orden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_orden_id_orden_seq OWNER TO postgres;

--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 216
-- Name: tb_orden_id_orden_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_orden_id_orden_seq OWNED BY public.tb_orden.id_orden;


--
-- TOC entry 217 (class 1259 OID 24013)
-- Name: tb_pagina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_pagina (
    id_pag integer NOT NULL,
    descripcion_pag text,
    path_pag text
);


ALTER TABLE public.tb_pagina OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24019)
-- Name: tb_pagina_id_pag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_pagina_id_pag_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_pagina_id_pag_seq OWNER TO postgres;

--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 218
-- Name: tb_pagina_id_pag_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_pagina_id_pag_seq OWNED BY public.tb_pagina.id_pag;


--
-- TOC entry 219 (class 1259 OID 24021)
-- Name: tb_parametros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_parametros (
    id_par integer NOT NULL,
    descripcion_par text,
    valor_par text
);


ALTER TABLE public.tb_parametros OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24027)
-- Name: tb_parametros_id_par_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_parametros_id_par_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_parametros_id_par_seq OWNER TO postgres;

--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 220
-- Name: tb_parametros_id_par_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_parametros_id_par_seq OWNED BY public.tb_parametros.id_par;


--
-- TOC entry 221 (class 1259 OID 24029)
-- Name: tb_perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_perfil (
    id_per integer NOT NULL,
    descripcion_per text
);


ALTER TABLE public.tb_perfil OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24035)
-- Name: tb_perfil_id_per_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_perfil_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_perfil_id_per_seq OWNER TO postgres;

--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 222
-- Name: tb_perfil_id_per_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_perfil_id_per_seq OWNED BY public.tb_perfil.id_per;


--
-- TOC entry 223 (class 1259 OID 24037)
-- Name: tb_perfilpagina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_perfilpagina (
    id_perpag integer NOT NULL,
    id_per integer,
    id_pag integer
);


ALTER TABLE public.tb_perfilpagina OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24040)
-- Name: tb_perfilpagina_id_perpag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_perfilpagina_id_perpag_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_perfilpagina_id_perpag_seq OWNER TO postgres;

--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 224
-- Name: tb_perfilpagina_id_perpag_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_perfilpagina_id_perpag_seq OWNED BY public.tb_perfilpagina.id_perpag;


--
-- TOC entry 225 (class 1259 OID 24042)
-- Name: tb_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_producto (
    id_pr integer NOT NULL,
    id_cat integer,
    nombre_pr text NOT NULL,
    cantidad_pr integer DEFAULT 0,
    precio_pr double precision DEFAULT 0,
    foto_pr bytea,
    en_oferta boolean DEFAULT false,
    descuento numeric(5,2) DEFAULT 0
);


ALTER TABLE public.tb_producto OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24052)
-- Name: tb_producto_id_pr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_producto_id_pr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_producto_id_pr_seq OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 226
-- Name: tb_producto_id_pr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_producto_id_pr_seq OWNED BY public.tb_producto.id_pr;


--
-- TOC entry 227 (class 1259 OID 24054)
-- Name: tb_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_servicio (
    id_serv integer NOT NULL,
    nombre_serv text NOT NULL,
    descripcion_serv text,
    precio_serv numeric(10,2) NOT NULL,
    activo boolean DEFAULT true
);


ALTER TABLE public.tb_servicio OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24061)
-- Name: tb_servicio_estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_servicio_estado (
    id_estado integer NOT NULL,
    id_us integer,
    id_serv integer,
    estado text DEFAULT 'Pendiente'::text,
    notas text,
    fecha timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tb_servicio_estado OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24069)
-- Name: tb_servicio_estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_servicio_estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_servicio_estado_id_estado_seq OWNER TO postgres;

--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 229
-- Name: tb_servicio_estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_servicio_estado_id_estado_seq OWNED BY public.tb_servicio_estado.id_estado;


--
-- TOC entry 230 (class 1259 OID 24071)
-- Name: tb_servicio_id_serv_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_servicio_id_serv_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_servicio_id_serv_seq OWNER TO postgres;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 230
-- Name: tb_servicio_id_serv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_servicio_id_serv_seq OWNED BY public.tb_servicio.id_serv;


--
-- TOC entry 231 (class 1259 OID 24073)
-- Name: tb_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_usuario (
    id_us integer NOT NULL,
    id_per integer,
    id_est integer,
    nombre_us text NOT NULL,
    cedula_us text NOT NULL,
    correo_us text NOT NULL,
    clave_us text NOT NULL
);


ALTER TABLE public.tb_usuario OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24079)
-- Name: tb_usuario_id_us_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_usuario_id_us_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_usuario_id_us_seq OWNER TO postgres;

--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 232
-- Name: tb_usuario_id_us_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_usuario_id_us_seq OWNED BY public.tb_usuario.id_us;


--
-- TOC entry 2952 (class 2604 OID 24081)
-- Name: tb_auditoria id_aud; Type: DEFAULT; Schema: auditoria; Owner: postgres
--

ALTER TABLE ONLY auditoria.tb_auditoria ALTER COLUMN id_aud SET DEFAULT nextval('auditoria.tb_auditoria_id_aud_seq'::regclass);


--
-- TOC entry 2954 (class 2604 OID 24082)
-- Name: tb_carrito id_car; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_carrito ALTER COLUMN id_car SET DEFAULT nextval('public.tb_carrito_id_car_seq'::regclass);


--
-- TOC entry 2958 (class 2604 OID 24083)
-- Name: tb_categoria id_cat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_categoria ALTER COLUMN id_cat SET DEFAULT nextval('public.tb_categoria_id_cat_seq'::regclass);


--
-- TOC entry 2959 (class 2604 OID 24084)
-- Name: tb_detalle_orden id_det; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_detalle_orden ALTER COLUMN id_det SET DEFAULT nextval('public.tb_detalle_orden_id_det_seq'::regclass);


--
-- TOC entry 2960 (class 2604 OID 24085)
-- Name: tb_detalle_servicio id_det_serv; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_detalle_servicio ALTER COLUMN id_det_serv SET DEFAULT nextval('public.tb_detalle_servicio_id_det_serv_seq'::regclass);


--
-- TOC entry 2961 (class 2604 OID 24086)
-- Name: tb_estadocivil id_est; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_estadocivil ALTER COLUMN id_est SET DEFAULT nextval('public.tb_estadocivil_id_est_seq'::regclass);


--
-- TOC entry 2962 (class 2604 OID 24087)
-- Name: tb_historial_servicio id_hist; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_historial_servicio ALTER COLUMN id_hist SET DEFAULT nextval('public.tb_historial_servicio_id_hist_seq'::regclass);


--
-- TOC entry 2965 (class 2604 OID 24088)
-- Name: tb_orden id_orden; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_orden ALTER COLUMN id_orden SET DEFAULT nextval('public.tb_orden_id_orden_seq'::regclass);


--
-- TOC entry 2968 (class 2604 OID 24089)
-- Name: tb_pagina id_pag; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_pagina ALTER COLUMN id_pag SET DEFAULT nextval('public.tb_pagina_id_pag_seq'::regclass);


--
-- TOC entry 2969 (class 2604 OID 24090)
-- Name: tb_parametros id_par; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_parametros ALTER COLUMN id_par SET DEFAULT nextval('public.tb_parametros_id_par_seq'::regclass);


--
-- TOC entry 2970 (class 2604 OID 24091)
-- Name: tb_perfil id_per; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfil ALTER COLUMN id_per SET DEFAULT nextval('public.tb_perfil_id_per_seq'::regclass);


--
-- TOC entry 2971 (class 2604 OID 24092)
-- Name: tb_perfilpagina id_perpag; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfilpagina ALTER COLUMN id_perpag SET DEFAULT nextval('public.tb_perfilpagina_id_perpag_seq'::regclass);


--
-- TOC entry 2972 (class 2604 OID 24093)
-- Name: tb_producto id_pr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_producto ALTER COLUMN id_pr SET DEFAULT nextval('public.tb_producto_id_pr_seq'::regclass);


--
-- TOC entry 2977 (class 2604 OID 24094)
-- Name: tb_servicio id_serv; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_servicio ALTER COLUMN id_serv SET DEFAULT nextval('public.tb_servicio_id_serv_seq'::regclass);


--
-- TOC entry 2979 (class 2604 OID 24095)
-- Name: tb_servicio_estado id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_servicio_estado ALTER COLUMN id_estado SET DEFAULT nextval('public.tb_servicio_estado_id_estado_seq'::regclass);


--
-- TOC entry 2982 (class 2604 OID 24096)
-- Name: tb_usuario id_us; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario ALTER COLUMN id_us SET DEFAULT nextval('public.tb_usuario_id_us_seq'::regclass);


--
-- TOC entry 3113 (class 0 OID 23956)
-- Dependencies: 201
-- Data for Name: tb_auditoria; Type: TABLE DATA; Schema: auditoria; Owner: postgres
--

COPY auditoria.tb_auditoria (id_aud, tabla_aud, operacion_aud, valor_anterior, valor_nuevo, fecha, usuario_db, esquema_db) FROM stdin;
1	tb_usuario	INSERT	\N	{"id_us":10,"id_per":2,"id_est":1,"nombre_us":"UsuarioPrueba","cedula_us":"0000000000","correo_us":"test@example.com","clave_us":"1234"}	2025-11-19 17:54:01.97617	postgres	public
2	tb_carrito	INSERT	\N	{"id_car":35,"id_us":1,"id_pr":2,"cantidad":1,"fecha_agregado":"2025-11-19T18:09:51.908211","subtotal":5.25,"id_serv":null}	2025-11-19 18:09:51.908211	postgres	public
3	tb_carrito	UPDATE	{"id_car":35,"id_us":1,"id_pr":2,"cantidad":1,"fecha_agregado":"2025-11-19T18:09:51.908211","subtotal":5.25,"id_serv":null}	{"id_car":35,"id_us":1,"id_pr":2,"cantidad":2,"fecha_agregado":"2025-11-19T18:09:51.908211","subtotal":10.50,"id_serv":null}	2025-11-19 18:09:54.998622	postgres	public
4	tb_carrito	UPDATE	{"id_car":35,"id_us":1,"id_pr":2,"cantidad":2,"fecha_agregado":"2025-11-19T18:09:51.908211","subtotal":10.50,"id_serv":null}	{"id_car":35,"id_us":1,"id_pr":2,"cantidad":3,"fecha_agregado":"2025-11-19T18:09:51.908211","subtotal":15.75,"id_serv":null}	2025-11-19 18:09:55.12267	postgres	public
5	tb_orden	INSERT	\N	{"id_orden":10,"id_us":1,"fecha":"2025-11-19T18:10:00.414134","total":15.75,"estado":"Pagado"}	2025-11-19 18:10:00.414134	postgres	public
6	tb_detalle_orden	INSERT	\N	{"id_det":12,"id_orden":10,"id_pr":2,"cantidad":3,"subtotal":15.75}	2025-11-19 18:10:00.421735	postgres	public
7	tb_carrito	DELETE	{"id_car":35,"id_us":1,"id_pr":2,"cantidad":3,"fecha_agregado":"2025-11-19T18:09:51.908211","subtotal":15.75,"id_serv":null}	\N	2025-11-19 18:10:00.425472	postgres	public
8	tb_carrito	INSERT	\N	{"id_car":36,"id_us":1,"id_pr":3,"cantidad":1,"fecha_agregado":"2025-11-19T20:03:25.235199","subtotal":1.80,"id_serv":null}	2025-11-19 20:03:25.235199	postgres	public
9	tb_carrito	UPDATE	{"id_car":36,"id_us":1,"id_pr":3,"cantidad":1,"fecha_agregado":"2025-11-19T20:03:25.235199","subtotal":1.80,"id_serv":null}	{"id_car":36,"id_us":1,"id_pr":3,"cantidad":2,"fecha_agregado":"2025-11-19T20:03:25.235199","subtotal":3.60,"id_serv":null}	2025-11-19 20:03:33.128533	postgres	public
10	tb_orden	INSERT	\N	{"id_orden":11,"id_us":1,"fecha":"2025-11-19T20:03:37.084859","total":3.60,"estado":"Pagado"}	2025-11-19 20:03:37.084859	postgres	public
11	tb_detalle_orden	INSERT	\N	{"id_det":13,"id_orden":11,"id_pr":3,"cantidad":2,"subtotal":3.60}	2025-11-19 20:03:37.094421	postgres	public
12	tb_producto	UPDATE	{"id_pr":3,"id_cat":2,"nombre_pr":"Cinta aislante","cantidad_pr":50,"precio_pr":1.8,"foto_pr":null,"en_oferta":false,"descuento":0.00}	{"id_pr":3,"id_cat":2,"nombre_pr":"Cinta aislante","cantidad_pr":48,"precio_pr":1.8,"foto_pr":null,"en_oferta":false,"descuento":0.00}	2025-11-19 20:03:37.162413	postgres	public
13	tb_carrito	DELETE	{"id_car":36,"id_us":1,"id_pr":3,"cantidad":2,"fecha_agregado":"2025-11-19T20:03:25.235199","subtotal":3.60,"id_serv":null}	\N	2025-11-19 20:03:37.168359	postgres	public
14	tb_carrito	INSERT	\N	{"id_car":37,"id_us":1,"id_pr":5,"cantidad":1,"fecha_agregado":"2025-11-19T20:26:30.892193","subtotal":21.28,"id_serv":null}	2025-11-19 20:26:30.892193	postgres	public
15	tb_orden	INSERT	\N	{"id_orden":12,"id_us":1,"fecha":"2025-11-19T20:26:35.501418","total":21.28,"estado":"Pagado"}	2025-11-19 20:26:35.501418	postgres	public
16	tb_detalle_orden	INSERT	\N	{"id_det":14,"id_orden":12,"id_pr":5,"cantidad":1,"subtotal":21.28}	2025-11-19 20:26:35.513504	postgres	public
17	tb_producto	UPDATE	{"id_pr":5,"id_cat":3,"nombre_pr":"Pintura acrílica blanca","cantidad_pr":20,"precio_pr":22.4,"foto_pr":null,"en_oferta":true,"descuento":5.00}	{"id_pr":5,"id_cat":3,"nombre_pr":"Pintura acrílica blanca","cantidad_pr":19,"precio_pr":22.4,"foto_pr":null,"en_oferta":true,"descuento":5.00}	2025-11-19 20:26:35.576774	postgres	public
18	tb_carrito	DELETE	{"id_car":37,"id_us":1,"id_pr":5,"cantidad":1,"fecha_agregado":"2025-11-19T20:26:30.892193","subtotal":21.28,"id_serv":null}	\N	2025-11-19 20:26:35.583983	postgres	public
19	tb_carrito	INSERT	\N	{"id_car":38,"id_us":1,"id_pr":9,"cantidad":1,"fecha_agregado":"2025-11-19T20:33:53.812265","subtotal":0.64,"id_serv":null}	2025-11-19 20:33:53.812265	postgres	public
20	tb_carrito	INSERT	\N	{"id_car":39,"id_us":1,"id_pr":4,"cantidad":1,"fecha_agregado":"2025-11-19T20:33:56.818861","subtotal":76.49,"id_serv":null}	2025-11-19 20:33:56.818861	postgres	public
21	tb_orden	INSERT	\N	{"id_orden":13,"id_us":1,"fecha":"2025-11-19T21:43:30.541835","total":77.13,"estado":"Pagado"}	2025-11-19 21:43:30.541835	postgres	public
22	tb_detalle_orden	INSERT	\N	{"id_det":15,"id_orden":13,"id_pr":9,"cantidad":1,"subtotal":0.64}	2025-11-19 21:43:30.549949	postgres	public
23	tb_detalle_orden	INSERT	\N	{"id_det":16,"id_orden":13,"id_pr":4,"cantidad":1,"subtotal":76.49}	2025-11-19 21:43:30.553635	postgres	public
24	tb_producto	UPDATE	{"id_pr":9,"id_cat":5,"nombre_pr":"Bloque de cemento","cantidad_pr":100,"precio_pr":0.75,"foto_pr":null,"en_oferta":true,"descuento":15.00}	{"id_pr":9,"id_cat":5,"nombre_pr":"Bloque de cemento","cantidad_pr":99,"precio_pr":0.75,"foto_pr":null,"en_oferta":true,"descuento":15.00}	2025-11-19 21:43:30.610362	postgres	public
25	tb_producto	UPDATE	{"id_pr":4,"id_cat":2,"nombre_pr":"Taladro eléctrico 750W","cantidad_pr":10,"precio_pr":89.99,"foto_pr":null,"en_oferta":true,"descuento":15.00}	{"id_pr":4,"id_cat":2,"nombre_pr":"Taladro eléctrico 750W","cantidad_pr":9,"precio_pr":89.99,"foto_pr":null,"en_oferta":true,"descuento":15.00}	2025-11-19 21:43:30.617649	postgres	public
26	tb_carrito	DELETE	{"id_car":38,"id_us":1,"id_pr":9,"cantidad":1,"fecha_agregado":"2025-11-19T20:33:53.812265","subtotal":0.64,"id_serv":null}	\N	2025-11-19 21:43:30.618399	postgres	public
27	tb_carrito	DELETE	{"id_car":39,"id_us":1,"id_pr":4,"cantidad":1,"fecha_agregado":"2025-11-19T20:33:56.818861","subtotal":76.49,"id_serv":null}	\N	2025-11-19 21:43:30.618399	postgres	public
\.


--
-- TOC entry 3115 (class 0 OID 23965)
-- Dependencies: 203
-- Data for Name: tb_carrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_carrito (id_car, id_us, id_pr, cantidad, fecha_agregado, subtotal, id_serv) FROM stdin;
16	5	3	4	2025-11-18 20:16:02.571975	7.20	\N
\.


--
-- TOC entry 3117 (class 0 OID 23973)
-- Dependencies: 205
-- Data for Name: tb_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_categoria (id_cat, descripcion_cat) FROM stdin;
1	Herramientas
2	Electricidad
3	Pintura
4	Fontanería
5	Construcción
\.


--
-- TOC entry 3119 (class 0 OID 23981)
-- Dependencies: 207
-- Data for Name: tb_detalle_orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_detalle_orden (id_det, id_orden, id_pr, cantidad, subtotal) FROM stdin;
1	1	4	3	229.47
2	1	2	2	10.50
3	2	5	1	21.28
4	2	3	1	1.80
5	3	3	1	1.80
6	5	7	1	0.75
7	5	13	1	9.90
8	6	5	1	21.28
9	7	10	1	25.00
10	8	4	1	76.49
11	9	4	3	229.47
12	10	2	3	15.75
13	11	3	2	3.60
14	12	5	1	21.28
15	13	9	1	0.64
16	13	4	1	76.49
17	14	6	23	344.77
\.


--
-- TOC entry 3121 (class 0 OID 23986)
-- Dependencies: 209
-- Data for Name: tb_detalle_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_detalle_servicio (id_det_serv, id_orden, id_serv, cantidad, subtotal) FROM stdin;
1	1	3	1	0.00
2	1	2	2	30.00
3	3	2	1	15.00
4	5	2	1	15.00
5	6	2	1	15.00
6	7	3	1	5.00
\.


--
-- TOC entry 3123 (class 0 OID 23991)
-- Dependencies: 211
-- Data for Name: tb_estadocivil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_estadocivil (id_est, descripcion_est) FROM stdin;
3	divorciado
2	soltero
1	casado
4	amigos
5	viudo
\.


--
-- TOC entry 3125 (class 0 OID 23999)
-- Dependencies: 213
-- Data for Name: tb_historial_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_historial_servicio (id_hist, id_us, id_serv, cantidad, subtotal, fecha, estado) FROM stdin;
1	1	3	1	0.00	2025-11-18 22:08:33.942043	Pendiente
2	1	2	2	30.00	2025-11-18 22:08:33.944524	Pendiente
3	1	2	1	15.00	2025-11-18 22:11:44.162696	Pendiente
4	1	2	1	15.00	2025-11-18 22:25:33.498649	Pendiente
5	1	2	1	15.00	2025-11-18 22:49:09.024773	Pendiente
6	1	3	1	5.00	2025-11-19 07:49:48.440898	Pendiente
\.


--
-- TOC entry 3127 (class 0 OID 24006)
-- Dependencies: 215
-- Data for Name: tb_orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_orden (id_orden, id_us, fecha, total, estado) FROM stdin;
1	1	2025-11-18 22:08:33.913255	269.97	Pagado
2	1	2025-11-18 22:09:40.674438	23.08	Pagado
3	1	2025-11-18 22:11:44.15355	16.80	Pagado
5	1	2025-11-18 22:25:33.489795	25.65	Pagado
6	1	2025-11-18 22:49:09.016326	36.28	Pagado
7	1	2025-11-19 07:49:48.42806	30.00	Pagado
8	1	2025-11-19 09:49:25.27371	76.49	Pagado
9	1	2025-11-19 17:50:19.994137	229.47	Pagado
10	1	2025-11-19 18:10:00.414134	15.75	Pagado
11	1	2025-11-19 20:03:37.084859	3.60	Pagado
12	1	2025-11-19 20:26:35.501418	21.28	Pagado
13	1	2025-11-19 21:43:30.541835	77.13	Pagado
14	11	2025-11-20 10:48:47.416399	344.77	Pagado
\.


--
-- TOC entry 3129 (class 0 OID 24013)
-- Dependencies: 217
-- Data for Name: tb_pagina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_pagina (id_pag, descripcion_pag, path_pag) FROM stdin;
1	Carrito de Compras	http://172.17.44.121:8080/ferreteria/carrito.jsp
2	Administrar Usuarios	http://172.17.44.121:8080/ferreteria/usuarios.jsp
3	Administrar Productos	http://172.17.44.121:8080/ferreteria/listProducts.jsp
4	Bitácora	http://172.17.44.121:8080/ferreteria/bitacora.jsp
5	Cerrar Sesión	http://172.17.44.121:8080/ferreteria/cerrarSesion.jsp
6	Ofertas	http://172.17.44.121:8080/ferreteria/ofertas.jsp
7	Catalogo	http://172.17.44.121:8080/ferreteria/catalogo.jsp
8	Servicios	http://172.17.44.121:8080/ferreteria/listServicios.jsp
9	Servicios por Atender	http://172.17.44.121:8080/ferreteria/vendedorServicios.jsp
10	Gestionar Servicios	http://172.17.44.121:8080/ferreteria/adminServicios.jsp
\.


--
-- TOC entry 3131 (class 0 OID 24021)
-- Dependencies: 219
-- Data for Name: tb_parametros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_parametros (id_par, descripcion_par, valor_par) FROM stdin;
\.


--
-- TOC entry 3133 (class 0 OID 24029)
-- Dependencies: 221
-- Data for Name: tb_perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_perfil (id_per, descripcion_per) FROM stdin;
3	vendedor
2	cliente
1	administador
\.


--
-- TOC entry 3135 (class 0 OID 24037)
-- Dependencies: 223
-- Data for Name: tb_perfilpagina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_perfilpagina (id_perpag, id_per, id_pag) FROM stdin;
1	1	2
2	1	3
3	1	4
4	1	5
5	3	3
6	3	5
7	2	1
9	2	6
8	2	7
10	2	8
11	3	9
12	1	10
\.


--
-- TOC entry 3137 (class 0 OID 24042)
-- Dependencies: 225
-- Data for Name: tb_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_producto (id_pr, id_cat, nombre_pr, cantidad_pr, precio_pr, foto_pr, en_oferta, descuento) FROM stdin;
2	1	Destornillador estrella	30	5.25	\N	f	0.00
7	5	Bloque de cemento	100	0.75	\N	f	0.00
10	1	Martillo de agua	15	25	\N	f	0.00
11	1	Martillo fuego	10	11.2	\N	t	16.00
12	1	Martillo metal	13	14.2	\N	t	12.00
13	2	Cinta no aislante	11	13.2	\N	t	25.00
14	1	Martillo de agua	15	25	\N	t	14.00
3	2	Cinta aislante	48	1.8	\N	f	0.00
5	3	Pintura acrílica blanca	19	22.4	\N	t	5.00
9	5	Bloque de cemento	99	0.75	\N	t	15.00
4	2	Taladro eléctrico 750W	9	89.99	\N	t	15.00
6	4	Llave inglesa	2	14.99	\N	f	0.00
17	2	Taladro eléctrico 750W	90	89.99	\N	t	50.00
\.


--
-- TOC entry 3139 (class 0 OID 24054)
-- Dependencies: 227
-- Data for Name: tb_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_servicio (id_serv, nombre_serv, descripcion_serv, precio_serv, activo) FROM stdin;
1	Instalación	Servicio profesional de instalación de productos adquiridos	25.00	t
2	Mantenimiento	Revisión y mantenimiento general de herramientas y equipos	15.00	t
3	Corte de Materiales	Corte preciso de madera, metal o plástico en taller	5.00	t
\.


--
-- TOC entry 3140 (class 0 OID 24061)
-- Dependencies: 228
-- Data for Name: tb_servicio_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_servicio_estado (id_estado, id_us, id_serv, estado, notas, fecha) FROM stdin;
\.


--
-- TOC entry 3143 (class 0 OID 24073)
-- Dependencies: 231
-- Data for Name: tb_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_usuario (id_us, id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) FROM stdin;
3	3	3	Bruno Diaz	1784032712	batman@gmail.com	batman
2	1	2	Diana Prince	1714032718	maravilla@gmail.com	maravilla
1	2	1	Peter Parker	17140302712	spiderman@gmail.com	spiderman
5	2	1	jossue	1750764165	jossuep@hotmail.com	123
7	2	3	Sebastian	1234567890	sebas@gmail.com	sebas
8	2	1	Alan	1729333276	aespanah@st.ups.edu.ec	alan123
9	2	2	Antony	1789576545	antony@gmail.com	1234
10	2	1	UsuarioPrueba	0000000000	test@example.com	1234
11	2	2	David Reyes	1714032719	dreyes@gmail.com	1234
12	2	2	antony	1765457856	cajay@gmail.com	1234
\.


--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 202
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: postgres
--

SELECT pg_catalog.setval('auditoria.tb_auditoria_id_aud_seq', 27, true);


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 204
-- Name: tb_carrito_id_car_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_carrito_id_car_seq', 40, true);


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 206
-- Name: tb_categoria_id_cat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_categoria_id_cat_seq', 5, true);


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 208
-- Name: tb_detalle_orden_id_det_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_detalle_orden_id_det_seq', 17, true);


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 210
-- Name: tb_detalle_servicio_id_det_serv_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_detalle_servicio_id_det_serv_seq', 6, true);


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 212
-- Name: tb_estadocivil_id_est_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_estadocivil_id_est_seq', 1, false);


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 214
-- Name: tb_historial_servicio_id_hist_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_historial_servicio_id_hist_seq', 6, true);


--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 216
-- Name: tb_orden_id_orden_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_orden_id_orden_seq', 14, true);


--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 218
-- Name: tb_pagina_id_pag_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_pagina_id_pag_seq', 5, true);


--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 220
-- Name: tb_parametros_id_par_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_parametros_id_par_seq', 1, false);


--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 222
-- Name: tb_perfil_id_per_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_perfil_id_per_seq', 1, false);


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 224
-- Name: tb_perfilpagina_id_perpag_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_perfilpagina_id_perpag_seq', 8, true);


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 226
-- Name: tb_producto_id_pr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_producto_id_pr_seq', 17, true);


--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 229
-- Name: tb_servicio_estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_servicio_estado_id_estado_seq', 1, false);


--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 230
-- Name: tb_servicio_id_serv_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_servicio_id_serv_seq', 3, true);


--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 232
-- Name: tb_usuario_id_us_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_usuario_id_us_seq', 12, true);


--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-11-27 10:30:10

--
-- PostgreSQL database dump complete
--

\unrestrict dWtwybxx7z4zuPDLS2VJTbNNvoABAhPCkYgMiDtt5dMLFjgPT6bpKpOq4aPfucb

