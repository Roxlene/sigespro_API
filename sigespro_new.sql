--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: administrativo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA administrativo;


ALTER SCHEMA administrativo OWNER TO postgres;

--
-- Name: entidades; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA entidades;


ALTER SCHEMA entidades OWNER TO postgres;

--
-- Name: proyectos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA proyectos;


ALTER SCHEMA proyectos OWNER TO postgres;

--
-- Name: seguridad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA seguridad;


ALTER SCHEMA seguridad OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clasificacion_componentes; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.clasificacion_componentes (
    id bigint NOT NULL,
    id_clasificacion bigint NOT NULL,
    id_componente_proyecto bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE administrativo.clasificacion_componentes OWNER TO postgres;

--
-- Name: clasificacion_componentes_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.clasificacion_componentes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.clasificacion_componentes_id_seq OWNER TO postgres;

--
-- Name: clasificacion_componentes_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.clasificacion_componentes_id_seq OWNED BY administrativo.clasificacion_componentes.id;


--
-- Name: clasificacion_proyectos; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.clasificacion_proyectos (
    id bigint NOT NULL,
    trayecto character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    carrera character varying(255) NOT NULL,
    id_estatus bigint DEFAULT '1'::bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE administrativo.clasificacion_proyectos OWNER TO postgres;

--
-- Name: clasificacion_proyectos_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.clasificacion_proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.clasificacion_proyectos_id_seq OWNER TO postgres;

--
-- Name: clasificacion_proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.clasificacion_proyectos_id_seq OWNED BY administrativo.clasificacion_proyectos.id;


--
-- Name: componentes_proyectos; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.componentes_proyectos (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    id_estatus bigint DEFAULT '1'::bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE administrativo.componentes_proyectos OWNER TO postgres;

--
-- Name: componentes_proyectos_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.componentes_proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.componentes_proyectos_id_seq OWNER TO postgres;

--
-- Name: componentes_proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.componentes_proyectos_id_seq OWNED BY administrativo.componentes_proyectos.id;


--
-- Name: direccion; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.direccion (
    id bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    id_parroquia bigint NOT NULL,
    detalles character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE administrativo.direccion OWNER TO postgres;

--
-- Name: direccion_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.direccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.direccion_id_seq OWNER TO postgres;

--
-- Name: direccion_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.direccion_id_seq OWNED BY administrativo.direccion.id;


--
-- Name: estado; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.estado (
    id bigint NOT NULL,
    nombre_estado character varying(255) NOT NULL,
    codigo_estado character varying(255) NOT NULL
);


ALTER TABLE administrativo.estado OWNER TO postgres;

--
-- Name: estado_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.estado_id_seq OWNER TO postgres;

--
-- Name: estado_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.estado_id_seq OWNED BY administrativo.estado.id;


--
-- Name: estatus; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.estatus (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    categoria character varying(255) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now(),
    updated_at timestamp(0) without time zone DEFAULT now()
);


ALTER TABLE administrativo.estatus OWNER TO postgres;

--
-- Name: estatus_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.estatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.estatus_id_seq OWNER TO postgres;

--
-- Name: estatus_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.estatus_id_seq OWNED BY administrativo.estatus.id;


--
-- Name: items; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.items (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    id_estatus bigint DEFAULT 1 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint
);


ALTER TABLE administrativo.items OWNER TO postgres;

--
-- Name: items_evaluados; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.items_evaluados (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    porcentaje character varying(255) NOT NULL,
    clasificacion_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    id_estatus integer DEFAULT 1 NOT NULL,
    user_id bigint
);


ALTER TABLE administrativo.items_evaluados OWNER TO postgres;

--
-- Name: items_evaluados_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.items_evaluados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.items_evaluados_id_seq OWNER TO postgres;

--
-- Name: items_evaluados_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.items_evaluados_id_seq OWNED BY administrativo.items_evaluados.id;


--
-- Name: items_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.items_id_seq OWNER TO postgres;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.items_id_seq OWNED BY administrativo.items.id;


--
-- Name: motivo_denegacion; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.motivo_denegacion (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    id_estatus bigint DEFAULT '1'::bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE administrativo.motivo_denegacion OWNER TO postgres;

--
-- Name: motivo_denegacion_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.motivo_denegacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.motivo_denegacion_id_seq OWNER TO postgres;

--
-- Name: motivo_denegacion_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.motivo_denegacion_id_seq OWNED BY administrativo.motivo_denegacion.id;


--
-- Name: municipio; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.municipio (
    id bigint NOT NULL,
    codigo_municipio character varying(255) NOT NULL,
    nombre_municipio character varying(255) NOT NULL,
    id_estado bigint NOT NULL
);


ALTER TABLE administrativo.municipio OWNER TO postgres;

--
-- Name: municipio_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.municipio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.municipio_id_seq OWNER TO postgres;

--
-- Name: municipio_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.municipio_id_seq OWNED BY administrativo.municipio.id;


--
-- Name: parroquia; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.parroquia (
    id bigint NOT NULL,
    codigo_parroquia character varying(255) NOT NULL,
    nombre_parroquia character varying(255) NOT NULL,
    id_municipio bigint NOT NULL
);


ALTER TABLE administrativo.parroquia OWNER TO postgres;

--
-- Name: parroquia_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.parroquia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.parroquia_id_seq OWNER TO postgres;

--
-- Name: parroquia_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.parroquia_id_seq OWNED BY administrativo.parroquia.id;


--
-- Name: tipo_usuario; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.tipo_usuario (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE administrativo.tipo_usuario OWNER TO postgres;

--
-- Name: tipo_usuario_id_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.tipo_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrativo.tipo_usuario_id_seq OWNER TO postgres;

--
-- Name: tipo_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.tipo_usuario_id_seq OWNED BY administrativo.tipo_usuario.id;


--
-- Name: aperturas; Type: TABLE; Schema: entidades; Owner: postgres
--

CREATE TABLE entidades.aperturas (
    id bigint NOT NULL,
    carrera character varying(255) NOT NULL,
    trayecto integer NOT NULL,
    seccion character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE entidades.aperturas OWNER TO postgres;

--
-- Name: aperturas_id_seq; Type: SEQUENCE; Schema: entidades; Owner: postgres
--

CREATE SEQUENCE entidades.aperturas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidades.aperturas_id_seq OWNER TO postgres;

--
-- Name: aperturas_id_seq; Type: SEQUENCE OWNED BY; Schema: entidades; Owner: postgres
--

ALTER SEQUENCE entidades.aperturas_id_seq OWNED BY entidades.aperturas.id;


--
-- Name: comunidad; Type: TABLE; Schema: entidades; Owner: postgres
--

CREATE TABLE entidades.comunidad (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    rif character varying(255),
    telefono character varying(255),
    email character varying(255),
    id_direccion bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    descripcion character varying,
    instagram character varying,
    facebook character varying,
    fecha_actualizacion_datos timestamp without time zone
);


ALTER TABLE entidades.comunidad OWNER TO postgres;

--
-- Name: COLUMN comunidad.descripcion; Type: COMMENT; Schema: entidades; Owner: postgres
--

COMMENT ON COLUMN entidades.comunidad.descripcion IS 'especificar de que trata la comunidad';


--
-- Name: COLUMN comunidad.instagram; Type: COMMENT; Schema: entidades; Owner: postgres
--

COMMENT ON COLUMN entidades.comunidad.instagram IS 'perfil';


--
-- Name: COLUMN comunidad.facebook; Type: COMMENT; Schema: entidades; Owner: postgres
--

COMMENT ON COLUMN entidades.comunidad.facebook IS 'perfil';


--
-- Name: comunidad_id_seq; Type: SEQUENCE; Schema: entidades; Owner: postgres
--

CREATE SEQUENCE entidades.comunidad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidades.comunidad_id_seq OWNER TO postgres;

--
-- Name: comunidad_id_seq; Type: SEQUENCE OWNED BY; Schema: entidades; Owner: postgres
--

ALTER SEQUENCE entidades.comunidad_id_seq OWNED BY entidades.comunidad.id;


--
-- Name: persona; Type: TABLE; Schema: entidades; Owner: postgres
--

CREATE TABLE entidades.persona (
    id bigint NOT NULL,
    nombres character varying(255) NOT NULL,
    apellidos character varying(255) NOT NULL,
    cedula character varying(255) NOT NULL,
    fullname character varying(255) NOT NULL,
    telefono character varying(255),
    id_direccion bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE entidades.persona OWNER TO postgres;

--
-- Name: persona_id_seq; Type: SEQUENCE; Schema: entidades; Owner: postgres
--

CREATE SEQUENCE entidades.persona_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidades.persona_id_seq OWNER TO postgres;

--
-- Name: persona_id_seq; Type: SEQUENCE OWNED BY; Schema: entidades; Owner: postgres
--

ALTER SEQUENCE entidades.persona_id_seq OWNED BY entidades.persona.id;


--
-- Name: profesores_clases_aperturadas; Type: TABLE; Schema: entidades; Owner: postgres
--

CREATE TABLE entidades.profesores_clases_aperturadas (
    id bigint NOT NULL,
    user_id bigint,
    clase_aperturada_id bigint,
    tipo_asesor character varying(255) NOT NULL,
    id_estatus bigint DEFAULT '1'::bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE entidades.profesores_clases_aperturadas OWNER TO postgres;

--
-- Name: profesores_clases_aperturadas_id_seq; Type: SEQUENCE; Schema: entidades; Owner: postgres
--

CREATE SEQUENCE entidades.profesores_clases_aperturadas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidades.profesores_clases_aperturadas_id_seq OWNER TO postgres;

--
-- Name: profesores_clases_aperturadas_id_seq; Type: SEQUENCE OWNED BY; Schema: entidades; Owner: postgres
--

ALTER SEQUENCE entidades.profesores_clases_aperturadas_id_seq OWNED BY entidades.profesores_clases_aperturadas.id;


--
-- Name: usuario_datos; Type: TABLE; Schema: entidades; Owner: postgres
--

CREATE TABLE entidades.usuario_datos (
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    cod_carrera character varying(255) NOT NULL,
    seccion character varying(255) NOT NULL,
    trayecto integer NOT NULL,
    estatus_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE entidades.usuario_datos OWNER TO postgres;

--
-- Name: usuario_datos_id_seq; Type: SEQUENCE; Schema: entidades; Owner: postgres
--

CREATE SEQUENCE entidades.usuario_datos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidades.usuario_datos_id_seq OWNER TO postgres;

--
-- Name: usuario_datos_id_seq; Type: SEQUENCE OWNED BY; Schema: entidades; Owner: postgres
--

ALTER SEQUENCE entidades.usuario_datos_id_seq OWNED BY entidades.usuario_datos.id;


--
-- Name: actividades_equipos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.actividades_equipos (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    equipo_id bigint NOT NULL,
    user_id bigint NOT NULL,
    producto character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    cod_actividad bigint NOT NULL,
    actividad_padre bigint,
    proyecto_id bigint,
    estatus_id bigint DEFAULT '1'::bigint NOT NULL
);


ALTER TABLE proyectos.actividades_equipos OWNER TO postgres;

--
-- Name: actividades_equipos_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.actividades_equipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.actividades_equipos_id_seq OWNER TO postgres;

--
-- Name: actividades_equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.actividades_equipos_id_seq OWNED BY proyectos.actividades_equipos.id;


--
-- Name: avances_equipos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.avances_equipos (
    id bigint NOT NULL,
    equipo_id bigint NOT NULL,
    item_evaluado_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.avances_equipos OWNER TO postgres;

--
-- Name: avances_equipos_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.avances_equipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.avances_equipos_id_seq OWNER TO postgres;

--
-- Name: avances_equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.avances_equipos_id_seq OWNED BY proyectos.avances_equipos.id;


--
-- Name: correcciones; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.correcciones (
    id bigint NOT NULL,
    actividad_id bigint NOT NULL,
    user_id bigint NOT NULL,
    comentario character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.correcciones OWNER TO postgres;

--
-- Name: correcciones_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.correcciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.correcciones_id_seq OWNER TO postgres;

--
-- Name: correcciones_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.correcciones_id_seq OWNED BY proyectos.correcciones.id;


--
-- Name: equipos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.equipos (
    id bigint NOT NULL,
    trayecto integer NOT NULL,
    carrera character varying(255) NOT NULL,
    seccion character varying(255) NOT NULL,
    proyecto_id bigint,
    id_estatus bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.equipos OWNER TO postgres;

--
-- Name: equipos_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.equipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.equipos_id_seq OWNER TO postgres;

--
-- Name: equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.equipos_id_seq OWNED BY proyectos.equipos.id;


--
-- Name: integrantes; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.integrantes (
    id bigint NOT NULL,
    equipo_id bigint NOT NULL,
    user_id bigint NOT NULL,
    scrum_master boolean DEFAULT false NOT NULL,
    id_estatus bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.integrantes OWNER TO postgres;

--
-- Name: integrantes_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.integrantes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.integrantes_id_seq OWNER TO postgres;

--
-- Name: integrantes_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.integrantes_id_seq OWNED BY proyectos.integrantes.id;


--
-- Name: necesidades; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.necesidades (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    necesidad character varying(255) NOT NULL,
    cod_necesidad character varying(255) NOT NULL,
    id_estatus bigint DEFAULT 4 NOT NULL,
    direccion_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    id_motivo bigint,
    evaluado_por bigint,
    fecha_verificacion timestamp without time zone
);


ALTER TABLE proyectos.necesidades OWNER TO postgres;

--
-- Name: COLUMN necesidades.id_motivo; Type: COMMENT; Schema: proyectos; Owner: postgres
--

COMMENT ON COLUMN proyectos.necesidades.id_motivo IS 'En caso de que se denegue .. no cuando se inactive';


--
-- Name: necesidades_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.necesidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.necesidades_id_seq OWNER TO postgres;

--
-- Name: necesidades_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.necesidades_id_seq OWNED BY proyectos.necesidades.id;


--
-- Name: notificaciones; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.notificaciones (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    equipo_id bigint,
    leido boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.notificaciones OWNER TO postgres;

--
-- Name: notificaciones_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.notificaciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.notificaciones_id_seq OWNER TO postgres;

--
-- Name: notificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.notificaciones_id_seq OWNED BY proyectos.notificaciones.id;


--
-- Name: postulaciones; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.postulaciones (
    id bigint NOT NULL,
    proyecto_id bigint NOT NULL,
    equipo_id bigint NOT NULL,
    id_estatus bigint DEFAULT '1'::bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.postulaciones OWNER TO postgres;

--
-- Name: postulaciones_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.postulaciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.postulaciones_id_seq OWNER TO postgres;

--
-- Name: postulaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.postulaciones_id_seq OWNED BY proyectos.postulaciones.id;


--
-- Name: proyecto_clasificado; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.proyecto_clasificado (
    id bigint NOT NULL,
    proyectos_id bigint NOT NULL,
    clasificacion_id bigint NOT NULL
);


ALTER TABLE proyectos.proyecto_clasificado OWNER TO postgres;

--
-- Name: proyecto_clasificado_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.proyecto_clasificado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.proyecto_clasificado_id_seq OWNER TO postgres;

--
-- Name: proyecto_clasificado_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proyecto_clasificado_id_seq OWNED BY proyectos.proyecto_clasificado.id;


--
-- Name: proyectos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.proyectos (
    id bigint NOT NULL,
    necesidad_id bigint NOT NULL,
    especificacion character varying(255),
    id_estatus bigint DEFAULT 8 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint
);


ALTER TABLE proyectos.proyectos OWNER TO postgres;

--
-- Name: proyectos_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.proyectos_id_seq OWNER TO postgres;

--
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proyectos_id_seq OWNED BY proyectos.proyectos.id;


--
-- Name: solicitudes; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.solicitudes (
    id bigint NOT NULL,
    solicitante_id bigint NOT NULL,
    equipo_id bigint NOT NULL,
    user_id bigint,
    id_estatus bigint DEFAULT '11'::bigint NOT NULL,
    integracion boolean DEFAULT true NOT NULL,
    integrante_id_desincorporar bigint,
    motivo_desincorporacion character varying(255),
    motivo_denegacion character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE proyectos.solicitudes OWNER TO postgres;

--
-- Name: solicitudes_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.solicitudes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.solicitudes_id_seq OWNER TO postgres;

--
-- Name: solicitudes_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.solicitudes_id_seq OWNED BY proyectos.solicitudes.id;


--
-- Name: subida_archivos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.subida_archivos (
    id bigint NOT NULL,
    proyecto_id bigint,
    equipo_id bigint NOT NULL,
    actividad_id bigint NOT NULL,
    investigacion character varying(255),
    presentacion character varying(255),
    producto character varying(255),
    portafolio character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    titulo character varying NOT NULL,
    edicion_trabajo bigint DEFAULT '0'::bigint NOT NULL,
    edicion_laminas bigint DEFAULT '0'::bigint NOT NULL,
    edicion_producto bigint DEFAULT '0'::bigint NOT NULL,
    edicion_portafolio bigint DEFAULT '0'::bigint NOT NULL,
    correccion_trabajo bigint DEFAULT '0'::bigint NOT NULL,
    correccion_laminas bigint DEFAULT '0'::bigint NOT NULL,
    correccion_producto bigint DEFAULT '0'::bigint NOT NULL,
    correccion_portafolio bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE proyectos.subida_archivos OWNER TO postgres;

--
-- Name: subida_archivos_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.subida_archivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyectos.subida_archivos_id_seq OWNER TO postgres;

--
-- Name: subida_archivos_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.subida_archivos_id_seq OWNED BY proyectos.subida_archivos.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: auditoria; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.auditoria (
    id bigint NOT NULL,
    actividad character varying(255) NOT NULL,
    direccion_ip character varying(255),
    id_usuario bigint,
    accion character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE seguridad.auditoria OWNER TO postgres;

--
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.auditoria_id_seq OWNER TO postgres;

--
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.auditoria_id_seq OWNED BY seguridad.auditoria.id;


--
-- Name: configuraciones; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.configuraciones (
    id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE seguridad.configuraciones OWNER TO postgres;

--
-- Name: configuraciones_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.configuraciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.configuraciones_id_seq OWNER TO postgres;

--
-- Name: configuraciones_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.configuraciones_id_seq OWNED BY seguridad.configuraciones.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE seguridad.model_has_permissions OWNER TO postgres;

--
-- Name: model_has_roles; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE seguridad.model_has_roles OWNER TO postgres;

--
-- Name: password_resets; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE seguridad.password_resets OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    estatus_id bigint NOT NULL,
    usuario_id bigint
);


ALTER TABLE seguridad.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.permissions_id_seq OWNED BY seguridad.permissions.id;


--
-- Name: role_has_permissions; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE seguridad.role_has_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    estatus_id bigint NOT NULL,
    usuario_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE seguridad.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.roles_id_seq OWNED BY seguridad.roles.id;


--
-- Name: usuarios; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.usuarios (
    id bigint NOT NULL,
    id_persona bigint NOT NULL,
    id_tipo_usuario bigint NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    phone_verified_at timestamp(0) without time zone,
    password_changed timestamp(0) without time zone,
    id_comunidad bigint,
    id_estatus bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    foto_url character varying
);


ALTER TABLE seguridad.usuarios OWNER TO postgres;

--
-- Name: COLUMN usuarios.foto_url; Type: COMMENT; Schema: seguridad; Owner: postgres
--

COMMENT ON COLUMN seguridad.usuarios.foto_url IS 'foto de perfil y a la vez l foto del proyecto en banca sin asignar';


--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.usuarios_id_seq OWNED BY seguridad.usuarios.id;


--
-- Name: vistas_notificaciones; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.vistas_notificaciones (
    id bigint NOT NULL,
    cant_not integer NOT NULL,
    not_vistas integer NOT NULL,
    not_new integer NOT NULL,
    user_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE seguridad.vistas_notificaciones OWNER TO postgres;

--
-- Name: vistas_notificaciones_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.vistas_notificaciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.vistas_notificaciones_id_seq OWNER TO postgres;

--
-- Name: vistas_notificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.vistas_notificaciones_id_seq OWNED BY seguridad.vistas_notificaciones.id;


--
-- Name: vistas_solicitudes; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.vistas_solicitudes (
    id bigint NOT NULL,
    cant_soli integer NOT NULL,
    soli_vistas integer NOT NULL,
    soli_new integer NOT NULL,
    user_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE seguridad.vistas_solicitudes OWNER TO postgres;

--
-- Name: vistas_solicitudes_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.vistas_solicitudes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.vistas_solicitudes_id_seq OWNER TO postgres;

--
-- Name: vistas_solicitudes_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.vistas_solicitudes_id_seq OWNED BY seguridad.vistas_solicitudes.id;


--
-- Name: clasificacion_componentes id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_componentes ALTER COLUMN id SET DEFAULT nextval('administrativo.clasificacion_componentes_id_seq'::regclass);


--
-- Name: clasificacion_proyectos id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_proyectos ALTER COLUMN id SET DEFAULT nextval('administrativo.clasificacion_proyectos_id_seq'::regclass);


--
-- Name: componentes_proyectos id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.componentes_proyectos ALTER COLUMN id SET DEFAULT nextval('administrativo.componentes_proyectos_id_seq'::regclass);


--
-- Name: direccion id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.direccion ALTER COLUMN id SET DEFAULT nextval('administrativo.direccion_id_seq'::regclass);


--
-- Name: estado id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.estado ALTER COLUMN id SET DEFAULT nextval('administrativo.estado_id_seq'::regclass);


--
-- Name: estatus id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.estatus ALTER COLUMN id SET DEFAULT nextval('administrativo.estatus_id_seq'::regclass);


--
-- Name: items id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items ALTER COLUMN id SET DEFAULT nextval('administrativo.items_id_seq'::regclass);


--
-- Name: items_evaluados id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items_evaluados ALTER COLUMN id SET DEFAULT nextval('administrativo.items_evaluados_id_seq'::regclass);


--
-- Name: motivo_denegacion id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.motivo_denegacion ALTER COLUMN id SET DEFAULT nextval('administrativo.motivo_denegacion_id_seq'::regclass);


--
-- Name: municipio id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.municipio ALTER COLUMN id SET DEFAULT nextval('administrativo.municipio_id_seq'::regclass);


--
-- Name: parroquia id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.parroquia ALTER COLUMN id SET DEFAULT nextval('administrativo.parroquia_id_seq'::regclass);


--
-- Name: tipo_usuario id; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.tipo_usuario ALTER COLUMN id SET DEFAULT nextval('administrativo.tipo_usuario_id_seq'::regclass);


--
-- Name: aperturas id; Type: DEFAULT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.aperturas ALTER COLUMN id SET DEFAULT nextval('entidades.aperturas_id_seq'::regclass);


--
-- Name: comunidad id; Type: DEFAULT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.comunidad ALTER COLUMN id SET DEFAULT nextval('entidades.comunidad_id_seq'::regclass);


--
-- Name: persona id; Type: DEFAULT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.persona ALTER COLUMN id SET DEFAULT nextval('entidades.persona_id_seq'::regclass);


--
-- Name: profesores_clases_aperturadas id; Type: DEFAULT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.profesores_clases_aperturadas ALTER COLUMN id SET DEFAULT nextval('entidades.profesores_clases_aperturadas_id_seq'::regclass);


--
-- Name: usuario_datos id; Type: DEFAULT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.usuario_datos ALTER COLUMN id SET DEFAULT nextval('entidades.usuario_datos_id_seq'::regclass);


--
-- Name: actividades_equipos id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos ALTER COLUMN id SET DEFAULT nextval('proyectos.actividades_equipos_id_seq'::regclass);


--
-- Name: avances_equipos id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.avances_equipos ALTER COLUMN id SET DEFAULT nextval('proyectos.avances_equipos_id_seq'::regclass);


--
-- Name: correcciones id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.correcciones ALTER COLUMN id SET DEFAULT nextval('proyectos.correcciones_id_seq'::regclass);


--
-- Name: equipos id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.equipos ALTER COLUMN id SET DEFAULT nextval('proyectos.equipos_id_seq'::regclass);


--
-- Name: integrantes id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.integrantes ALTER COLUMN id SET DEFAULT nextval('proyectos.integrantes_id_seq'::regclass);


--
-- Name: necesidades id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades ALTER COLUMN id SET DEFAULT nextval('proyectos.necesidades_id_seq'::regclass);


--
-- Name: notificaciones id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.notificaciones ALTER COLUMN id SET DEFAULT nextval('proyectos.notificaciones_id_seq'::regclass);


--
-- Name: postulaciones id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.postulaciones ALTER COLUMN id SET DEFAULT nextval('proyectos.postulaciones_id_seq'::regclass);


--
-- Name: proyecto_clasificado id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyecto_clasificado ALTER COLUMN id SET DEFAULT nextval('proyectos.proyecto_clasificado_id_seq'::regclass);


--
-- Name: proyectos id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos.proyectos_id_seq'::regclass);


--
-- Name: solicitudes id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes ALTER COLUMN id SET DEFAULT nextval('proyectos.solicitudes_id_seq'::regclass);


--
-- Name: subida_archivos id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.subida_archivos ALTER COLUMN id SET DEFAULT nextval('proyectos.subida_archivos_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: auditoria id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.auditoria ALTER COLUMN id SET DEFAULT nextval('seguridad.auditoria_id_seq'::regclass);


--
-- Name: configuraciones id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.configuraciones ALTER COLUMN id SET DEFAULT nextval('seguridad.configuraciones_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permissions ALTER COLUMN id SET DEFAULT nextval('seguridad.permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles ALTER COLUMN id SET DEFAULT nextval('seguridad.roles_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios ALTER COLUMN id SET DEFAULT nextval('seguridad.usuarios_id_seq'::regclass);


--
-- Name: vistas_notificaciones id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.vistas_notificaciones ALTER COLUMN id SET DEFAULT nextval('seguridad.vistas_notificaciones_id_seq'::regclass);


--
-- Name: vistas_solicitudes id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.vistas_solicitudes ALTER COLUMN id SET DEFAULT nextval('seguridad.vistas_solicitudes_id_seq'::regclass);


--
-- Data for Name: clasificacion_componentes; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.clasificacion_componentes (id, id_clasificacion, id_componente_proyecto, created_at, updated_at) FROM stdin;
1	13	1	2023-12-31 13:30:45	2023-12-31 13:30:45
2	13	2	2023-12-31 13:30:45	2023-12-31 13:30:45
3	15	1	2024-01-10 18:37:04	2024-01-10 18:37:04
4	16	1	2024-01-10 20:24:44	2024-01-10 20:24:44
5	16	2	2024-01-10 20:24:44	2024-01-10 20:24:44
6	15	2	2024-01-21 18:01:56	2024-01-21 18:01:56
8	17	1	2024-01-22 03:10:41	2024-01-22 03:10:41
9	17	2	2024-01-22 03:10:41	2024-01-22 03:10:41
10	3	1	2024-01-22 03:10:41	2024-01-22 03:10:41
11	3	2	2024-01-22 03:10:41	2024-01-22 03:10:41
12	3	3	2024-01-22 03:10:41	2024-01-22 03:10:41
13	3	4	2024-01-22 03:10:41	2024-01-22 03:10:41
\.


--
-- Data for Name: clasificacion_proyectos; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.clasificacion_proyectos (id, trayecto, descripcion, carrera, id_estatus, created_at, updated_at) FROM stdin;
2	2	SISTEMAS	INF	1	2023-10-02 16:02:43	2023-10-02 16:02:43
3	3	SISTEMAS INFORMATICOS	INF	1	2023-10-02 16:04:09	2023-10-02 16:04:09
4	4	REDES	INF	1	2023-10-02 16:06:49	2023-10-02 16:06:49
5	1	Archivos	AD	1	2023-10-02 16:27:02	2023-10-02 16:27:02
6	2	INVENTARIO	AD	1	2023-10-02 16:28:03	2023-10-02 16:28:03
7	3	BIENES NACIONALES	AD	1	2023-10-02 16:28:42	2023-10-02 16:28:42
1	1	Arquitectura del computador	INF	1	2023-07-25 15:39:22	2023-07-25 15:48:52
13	4	SISTEMAS DE INVENTARIO	AD	1	2023-12-31 13:30:45	2023-12-31 13:30:45
14	1	CIRCUITOS	EL	1	2024-01-10 18:22:49	2024-01-10 18:22:49
15	2	BOMBILLOS	EL	1	2024-01-10 18:37:04	2024-01-10 18:37:04
16	3	PLANTA ELECTRICA	EL	1	2024-01-10 20:24:43	2024-01-10 20:24:43
17	1	Mantenimiento basico	MM	1	2024-01-22 03:10:41	2024-01-22 03:10:41
\.


--
-- Data for Name: componentes_proyectos; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.componentes_proyectos (id, descripcion, id_estatus, created_at, updated_at) FROM stdin;
1	Trabajo de Investigación	1	2023-12-31 12:02:19	2023-12-31 12:02:19
2	Laminas	1	2023-12-31 12:02:19	2023-12-31 12:02:19
3	Producto	1	2023-12-31 12:02:19	2023-12-31 12:02:19
4	Portafolio	1	2023-12-31 12:02:19	2023-12-31 12:02:19
\.


--
-- Data for Name: direccion; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.direccion (id, id_estado, id_municipio, id_parroquia, detalles, created_at, updated_at) FROM stdin;
1	126	1691	5804	Detalles	2023-07-14 18:31:31	2023-07-14 18:31:31
5	126	1691	5804	\N	2023-07-18 10:37:38	2023-07-18 10:37:38
6	126	1691	5804	\N	2023-07-18 14:04:53	2023-07-18 14:04:53
7	126	1691	5804	\N	2023-07-18 14:06:03	2023-07-18 14:06:03
8	126	1691	5804	\N	2023-07-18 14:08:41	2023-07-18 14:08:41
9	126	1691	5804	\N	2023-07-18 14:10:19	2023-07-18 14:10:19
10	126	1691	5804	\N	2023-07-18 14:18:17	2023-07-18 14:18:17
11	126	1691	5804	\N	2023-07-18 14:19:03	2023-07-18 14:19:03
12	126	1691	5804	\N	2023-07-18 14:19:40	2023-07-18 14:19:40
13	126	1691	5804	\N	2023-07-18 14:19:52	2023-07-18 14:19:52
14	126	1691	5804	\N	2023-07-18 14:21:43	2023-07-18 14:21:43
15	126	1691	5804	\N	2023-07-18 14:22:16	2023-07-18 14:22:16
16	126	1691	5804	\N	2023-07-18 14:23:04	2023-07-18 14:23:04
17	126	1691	5804	\N	2023-07-18 14:24:45	2023-07-18 14:24:45
18	126	1691	5804	\N	2023-07-18 14:25:36	2023-07-18 14:25:36
19	126	1691	5804	\N	2023-07-18 14:26:51	2023-07-18 14:26:51
20	126	1691	5804	\N	2023-07-18 14:28:01	2023-07-18 14:28:01
21	126	1691	5804	\N	2023-07-18 14:29:09	2023-07-18 14:29:09
22	126	1691	5804	\N	2023-07-18 14:37:29	2023-07-18 14:37:29
23	126	1691	5804	\N	2023-07-18 14:38:15	2023-07-18 14:38:15
24	126	1691	5804	\N	2023-07-18 14:39:55	2023-07-18 14:39:55
25	126	1691	5804	\N	2023-07-18 14:40:24	2023-07-18 14:40:24
26	126	1691	5804	\N	2023-07-18 14:46:22	2023-07-18 14:46:22
27	126	1691	5804	\N	2023-07-18 14:51:59	2023-07-18 14:51:59
28	126	1691	5804	\N	2023-07-18 14:55:57	2023-07-18 14:55:57
29	126	1691	5804	\N	2023-07-18 14:56:37	2023-07-18 14:56:37
30	126	1691	5804	\N	2023-07-18 14:57:54	2023-07-18 14:57:54
31	126	1691	5804	\N	2023-07-18 15:00:31	2023-07-18 15:00:31
32	126	1691	5804	\N	2023-07-20 10:23:35	2023-07-20 10:23:35
33	126	1691	5804	Av. Principal de Ruiz Pineda	2023-07-20 15:53:26	2023-07-20 15:53:26
34	126	1691	5804	Av. Principal de Ruiz Pineda	2023-07-20 15:57:42	2023-07-20 15:57:42
35	126	1691	5804	Av. Principal de Ruiz Pineda	2023-07-20 15:59:55	2023-07-20 15:59:55
36	126	1691	5804	Av. Principal de Ruiz Pineda	2023-07-20 16:06:32	2023-07-20 16:06:32
37	126	1691	5804	\N	2023-07-20 16:08:05	2023-07-20 16:08:05
38	126	1691	5804	Av. Principal de Ruiz Pineda	2023-07-20 16:09:56	2023-07-20 16:09:56
39	126	1691	5804	Av. Principal de Ruiz Pineda	2023-07-20 16:10:29	2023-07-20 16:10:29
41	127	1691	5804	Detalles	2023-08-11 09:41:00	2023-08-11 09:41:00
42	126	1691	5804	Detalles	2023-08-11 09:41:58	2023-08-11 11:46:40
43	126	1691	5804	Detalless	2023-08-22 10:26:41	2023-08-22 10:26:41
44	140	1885	6475	La california norte, al frente de damasco	2023-10-25 14:22:28	2023-10-25 14:22:28
45	140	1885	6475	La california norte, al frente de damasco	2023-10-25 14:24:22	2023-10-25 14:24:22
46	140	1885	6475	La california norte, al frente de damasco	2023-10-25 14:25:20	2023-10-25 14:25:20
47	140	1885	6475	California norte, al frente de damasco	2023-10-25 14:45:23	2023-10-25 14:45:23
48	140	1885	6475	California Norte, al frente de damasco	2023-10-25 15:31:57	2023-10-25 15:31:57
49	140	1885	6475	California norte, al frente de damasco	2023-10-25 15:35:31	2023-10-25 15:35:31
50	126	1691	5802	Antimano	2023-10-25 18:51:00	2023-10-25 18:51:00
51	126	1691	5802	Antimano	2023-10-25 18:58:26	2023-10-25 18:58:26
52	126	1691	5802	Antimano	2023-10-25 19:07:40	2023-10-25 19:07:40
53	142	1910	6546	Tabures	2023-10-31 12:03:50	2023-10-31 12:03:50
54	126	1691	5802	Antimano	2023-10-31 14:47:02	2023-10-31 14:47:02
55	126	1691	5802	Antimano	2023-10-31 15:05:05	2023-10-31 15:05:05
56	126	1691	5802	Antimano	2023-10-31 15:21:39	2023-10-31 15:21:39
57	126	1691	5802	Antimano	2023-10-31 15:28:47	2023-10-31 15:28:47
58	140	1885	6475	Avenida Francisco de Miranda cruce con calle Santiago de León, frente al Unicentro el Marqués. Torre I.N.T.T. Av. Santiago León de Caracas, Caracas 1071, Miranda	2023-10-31 15:41:12	2023-10-31 15:41:12
59	140	1885	6475	Avenida Francisco de Miranda cruce con calle Santiago de León, frente al Unicentro el Marqués. Torre I.N.T.T. Av. Santiago León de Caracas, Caracas 1071, Miranda	2023-10-31 15:52:09	2023-10-31 15:52:09
60	126	1691	5800	Tangamandapio	2024-01-10 18:57:59	2024-01-10 18:57:59
61	126	1691	5800	Otra direccion	2024-01-10 19:12:59	2024-01-10 19:12:59
62	126	1691	5800	Direccion	2024-01-10 19:27:55	2024-01-10 19:27:55
63	126	1691	5803	Candelaria	2024-01-21 19:52:39	2024-01-21 19:52:39
64	126	1691	5800	bellas artes	2024-01-22 17:28:58	2024-01-22 17:28:58
65	126	1691	5809	antimano	2024-01-22 18:11:16	2024-01-22 18:11:16
66	126	1691	5800	SAN MARTIN	2024-01-22 18:59:36	2024-01-22 18:59:36
67	126	1691	5804	Av. Principal de Ruiz Pineda	2024-01-22 19:03:17	2024-01-22 19:03:17
68	126	1691	5804	Av. Principal de Ruiz Pineda	2024-01-22 19:04:54	2024-01-22 19:04:54
69	126	1691	5804	Av. Principal de Ruiz Pineda	2024-01-22 19:07:26	2024-01-22 19:07:26
70	126	1691	5804	Detalles de direccion	2024-01-22 19:08:50	2024-01-22 19:08:50
71	126	1691	5800	Detalles de direccion	2024-01-22 19:29:51	2024-01-22 19:29:51
72	126	1691	5800	san martin	2024-01-25 18:34:06	2024-01-25 18:34:06
\.


--
-- Data for Name: estado; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.estado (id, nombre_estado, codigo_estado) FROM stdin;
126	Distrito Capital	01
127	Amazonas	02
128	Anzoátegui	03
129	Apure	04
130	Aragua	05
131	Barinas	06
132	Bolívar	07
133	Carabobo	08
134	Cojedes	09
135	Delta Amacuro	10
136	Falcón	11
137	Guárico	12
138	Lara	13
139	Mérida	14
140	Bolivariano de Miranda	15
141	Monagas	16
142	Nueva Esparta	17
143	Portuguesa	18
144	Sucre	19
145	Táchira	20
146	Trujillo	21
147	Yaracuy	22
148	Zulia	23
149	La Guaira	24
150	Dependencias Federales	25
\.


--
-- Data for Name: estatus; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.estatus (id, descripcion, categoria, created_at, updated_at) FROM stdin;
1	Activo	General	2023-07-14 18:31:31	2023-07-14 18:31:31
2	Inactivo	General	2023-07-14 18:31:31	2023-07-14 18:31:31
3	Denegado	Necesidades	2023-08-10 12:17:09	2023-08-10 12:17:09
4	En espera de verificación	Necesidades	2023-08-10 12:17:45	2023-08-10 12:17:45
5	Aprobado	Necesidades	2023-08-10 12:20:21	2023-08-10 12:20:21
6	En desarrollo	Proyecto	2023-08-10 12:20:21	2023-08-10 12:20:21
7	Finalizado	Proyecto	2023-08-10 12:20:21	2023-08-10 12:20:21
8	En espera de asignación	Proyecto	2023-08-11 13:39:23	2023-08-11 13:39:23
9	Aperturado	Equipos	2023-12-21 11:46:32	2023-12-21 11:46:32
10	Retirado	Equipos	2023-12-21 11:49:53	2023-12-21 11:49:53
11	En espera de respuesta	Solicitudes Equipos	2023-12-22 11:25:06	2023-12-22 11:25:06
12	Rechazado	Solicitudes Equipos	2023-12-22 11:25:22	2023-12-22 11:25:22
13	Solicitud aceptada	Solicitudes Equipos	2023-12-26 00:53:51	2023-12-26 00:53:51
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.items (id, descripcion, id_estatus, created_at, updated_at, user_id) FROM stdin;
6	LA COMUNIDAD	1	2023-08-21 17:26:55	2023-08-22 12:10:59	2
2	FASE 1. LA COMUNIDAD	1	2023-08-04 15:22:18	2024-01-21 18:16:21	2
5	fase 2. el problema	1	2023-08-09 13:56:01	2024-01-21 18:18:02	2
\.


--
-- Data for Name: items_evaluados; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.items_evaluados (id, item_id, porcentaje, clasificacion_id, created_at, updated_at, id_estatus, user_id) FROM stdin;
3	2	10	1	2023-08-09 15:00:51	2023-08-09 15:00:51	1	2
1	5	10	1	2023-08-09 14:11:18	2023-08-09 15:28:41	1	2
12	2	50	13	2023-12-31 13:30:45	2023-12-31 13:30:45	1	37
13	6	50	13	2023-12-31 13:30:45	2023-12-31 13:30:45	1	37
14	2	100	14	2024-01-10 18:22:49	2024-01-10 18:22:49	1	37
15	2	100	15	2024-01-10 18:37:04	2024-01-10 18:37:04	1	37
16	2	50	16	2024-01-10 20:24:44	2024-01-10 20:24:44	1	57
17	6	50	16	2024-01-10 20:24:44	2024-01-10 20:24:44	1	57
18	2	50	17	2024-01-22 03:10:41	2024-01-22 03:10:41	1	2
19	5	50	17	2024-01-22 03:10:41	2024-01-22 03:10:41	1	2
20	2	50	3	2023-08-09 15:00:51	2023-08-09 15:00:51	1	2
21	5	50	3	2023-08-09 15:00:51	2023-08-09 15:00:51	1	2
\.


--
-- Data for Name: motivo_denegacion; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.motivo_denegacion (id, descripcion, id_estatus, user_id, created_at, updated_at) FROM stdin;
1	PROYECTO SIN IMPACTO SOCIAL	1	2	2023-08-10 12:00:30	2023-10-23 14:14:33
\.


--
-- Data for Name: municipio; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.municipio (id, codigo_municipio, nombre_municipio, id_estado) FROM stdin;
1692	0201	Autonomo Alto Orinoco	127
1836	1302	Crespo	138
1835	1301	Andrés Eloy Blanco	138
1829	1210	Ortiz	137
1830	1211	José Félix Ribas	137
1831	1212	Juan Germán Roscio	137
1833	1214	Santa María De Ipire	137
1834	1215	Pedro Zaraza	137
1823	1204	San Gerónimo De Guayabal	137
1824	1205	Leonardo Infante	137
1825	1206	Las Mercedes	137
1826	1207	Julián Mellado	137
1820	1201	Camaguán	137
1828	1209	José Tadeo Monagas	137
1821	1202	Chaguaramas	137
1822	1203	El Socorro	137
1819	1125	Zamora	136
1818	1124	Urumaco	136
1817	1123	Unión	136
1816	1122	Tocópero	136
1815	1121	Sucre	136
1814	1120	Silva	136
1813	1119	San Francisco	136
1812	1118	Piritu	136
1811	1117	Petit	136
1810	1116	Palmasola	136
1808	1114	Miranda	136
1807	1113	Mauroa	136
1806	1112	Los Taques	136
1805	1111	Jacura	136
1792	1002	Casacoima	135
1804	1110	Federación	136
1793	1003	Pedernales	135
1794	1004	Tucupita	135
1795	1101	Acosta	136
1791	1001	Antonio Díaz	135
1798	1104	Cacique Manaure	136
1796	1102	Bolívar	136
1799	1105	Carirubana	136
1800	1106	Colina	136
1801	1107	Dabajuro	136
1802	1108	Democracia	136
1803	1109	Falcón	136
1694	0203	Autonomo Atures	127
1698	0207	Autonomo Río Negro	127
1699	0301	Anaco	128
1695	0204	Autonomo Autana	127
1696	0205	Autonomo Maroa	127
1697	0206	Autonomo Manapiare	127
1700	0302	Aragua	128
1702	0304	Francisco Del Carmen Carvajal	128
1703	0305	Francisco De Miranda	128
1704	0306	Guanta	128
1706	0308	Juan Antonio Sotillo	128
1705	0307	Independencia	128
1707	0309	Juan Manuel Cajigal	128
1709	0311	Libertad	128
1710	0312	Manuel Ezequiel Bruzual	128
1711	0313	Pedro María Freites	128
1712	0314	Píritu	128
1713	0315	San José De Guanipa	128
1714	0316	San Juan De Capistrano	128
1715	0317	Santa Ana	128
1716	0318	Simón Bolívar	128
1717	0319	Simón Rodríguez	128
1718	0320	Sir Arthur Mc Gregor	128
1720	0401	Achaguas	129
1721	0402	Biruaca	129
1722	0403	Muñoz	129
1723	0404	Páez	129
1724	0405	Pedro Camejo	129
1725	0406	Rómulo Gallegos	129
1726	0407	San Fernando	129
1727	0501	Bolívar	130
1728	0502	Camatagua	130
1729	0503	Girardot	130
1730	0504	José Angel Lamas	130
1731	0505	José Félix Ribas	130
1733	0507	Libertador	130
1734	0508	Mario Briceño Iragorry	130
1735	0509	San Casimiro	130
1736	0510	San Sebastián	130
1737	0511	Santiago Mariño	130
1738	0512	Santos Michelena	130
1739	0513	Sucre	130
1740	0514	Tovar	130
1741	0515	Urdaneta	130
1742	0516	Zamora	130
1744	0518	Ocumare De La Costa De Oro	130
1745	0601	Alberto Arvelo Torrealba	131
1746	0602	Antonio José De Sucre	131
1747	0603	Arismendi	131
1748	0604	Barinas	131
1749	0605	Bolívar	131
1750	0606	Cruz Paredes	131
1751	0607	Ezequiel Zamora	131
1752	0608	Obispos	131
1753	0609	Pedraza	131
1754	0610	Rojas	131
1755	0611	Sosa	131
1758	0702	Cedeño	132
1757	0701	Caroní	132
1759	0703	El Callao	132
1760	0704	Gran Sabana	132
1761	0705	Heres	132
1762	0706	Piar	132
1763	0707	Bolivariano Angostura	132
1764	0708	Roscio	132
1765	0709	Sifontes	132
1766	0710	Sucre	132
1767	0711	Padre Pedro Chien	132
1768	0801	Bejuma	133
1769	0802	Carlos Arvelo	133
1770	0803	Diego Ibarra	133
1772	0805	Juan José Mora	133
1773	0806	Libertador	133
1774	0807	Los Guayos	133
1775	0808	Miranda	133
1776	0809	Montalbán	133
1777	0810	Naguanagua	133
1778	0811	Puerto Cabello	133
1779	0812	San Diego	133
1780	0813	San Joaquín	133
1782	0901	Anzoátegui	134
1783	0902	Falcón	134
1784	0903	Girardot	134
1785	0904	Lima Blanco	134
1787	0906	Ricaurte	134
1788	0907	Rómulo Gallegos	134
1789	0908	Ezequiel Zamora	134
1790	0909	Tinaco	134
1868	1502	Andrés Bello	140
1869	1503	Baruta	140
1871	1505	Buroz	140
1872	1506	Carrizal	140
1873	1507	Chacao	140
1874	1508	Cristóbal Rojas	140
1875	1509	El Hatillo	140
1877	1511	Independencia	140
1878	1512	Lander	140
1879	1513	Los Salias	140
1880	1514	Páez	140
1881	1515	Paz Castillo	140
1883	1517	Plaza	140
1884	1518	Simón Bolívar	140
1885	1519	Sucre	140
1886	1520	Urdaneta	140
1889	1602	Aguasay	141
1887	1521	Zamora	140
1890	1603	Bolívar	141
1891	1604	Caripe	141
1892	1605	Cedeño	141
1893	1606	Ezequiel Zamora	141
1894	1607	Libertador	141
1895	1608	Maturín	141
1896	1609	Piar	141
1898	1611	Santa Bárbara	141
1899	1612	Sotillo	141
1900	1613	Uracoa	141
1901	1701	Antolín Del Campo	142
1902	1702	Arismendi	142
1903	1703	Díaz	142
1905	1705	Gómez	142
1906	1706	Maneiro	142
1907	1707	Marcano	142
1908	1708	Mariño	142
1909	1709	Península De Macanao	142
1910	1710	Tubores	142
1911	1711	Villalba	142
1913	1802	Araure	143
1914	1803	Esteller	143
1915	1804	Guanare	143
1916	1805	Guanarito	143
1918	1807	Ospino	143
1919	1808	Páez	143
1920	1809	Papelón	143
1921	1810	San Genaro De Boconoito	143
1922	1811	San Rafael De Onoto	143
1923	1812	Santa Rosalía	143
1925	1814	Turén	143
1924	1813	Sucre	143
1927	1902	Andrés Mata	144
1928	1903	Arismendi	144
1990	2201	Arístides Bastidas	147
1991	2202	Bolívar	147
1992	2203	Bruzual	147
1970	2101	Andrés Bello	146
1971	2102	Boconó	146
1972	2103	Bolívar	146
1973	2104	Candelaria	146
1974	2105	Carache	146
1975	2106	Escuque	146
1977	2108	Juan Vicente Campo Elías	146
1978	2109	La Ceiba	146
1979	2110	Miranda	146
1980	2111	Monte Carmelo	146
1981	2112	Motatán	146
1982	2113	Pampán	146
1983	2114	Pampanito	146
1984	2115	Rafael Rangel	146
1985	2116	San Rafael De Carvajal	146
1986	2117	Sucre	146
1987	2118	Trujillo	146
1989	2120	Valera	146
1946	2006	Córdoba	145
1943	2003	Ayacucho	145
1945	2005	Cárdenas	145
1944	2004	Bolívar	145
1947	2007	Fernández Feo	145
1942	2002	Antonio Rómulo Costa	145
1948	2008	Francisco De Miranda	145
1949	2009	García De Hevia	145
1950	2010	Guásimos	145
1951	2011	Independencia	145
1952	2012	Jáuregui	145
1954	2014	Junín	145
1955	2015	Libertad	145
1956	2016	Libertador	145
1957	2017	Lobatera	145
1958	2018	Michelena	145
1959	2019	Panamericano	145
1960	2020	Pedro María Ureña	145
1961	2021	Rafael Urdaneta	145
1963	2023	San Cristóbal	145
1965	2025	Simón Rodríguez	145
1964	2024	Seboruco	145
1966	2026	Sucre	145
1967	2027	Torbes	145
1968	2028	Uribante	145
1969	2029	San Judas Tadeo	145
1940	1915	Valdez	144
1939	1914	Sucre	144
1937	1912	Montes	144
1936	1911	Mejía	144
1935	1910	Mariño	144
1934	1909	Libertador	144
1932	1907	Cajigal	144
1931	1906	Bolívar	144
1929	1904	Benítez	144
1866	1423	Zea	139
1865	1422	Tulio Febres Cordero	139
1864	1421	Tovar	139
1863	1420	Sucre	139
1861	1418	Rivas Dávila	139
1860	1417	Rangel	139
1859	1416	Pueblo Llano	139
1858	1415	Padre Noguera	139
1856	1413	Miranda	139
1855	1412	Libertador	139
1854	1411	Justo Briceño	139
1853	1410	Julio César Salas	139
1852	1409	Guaraque	139
1849	1406	Campo Elías	139
1850	1407	Caracciolo Parra Olmedo	139
1851	1408	Cardenal Quintero	139
1848	1405	Arzobispo Chacón	139
1845	1402	Andrés Bello	139
1846	1403	Antonio Pinto Salinas	139
1847	1404	Aricagua	139
1843	1309	Urdaneta	138
1842	1308	Torres	138
1841	1307	Simón Planas	138
1840	1306	Palavecino	138
1838	1304	Jiménez	138
1837	1303	Iribarren	138
1691	0101	Bolivariano Libertador	126
1867	1501	Acevedo	140
1870	1504	Brión	140
1876	1510	Bolivariano Guaicaipuro	140
1882	1516	Pedro Gual	140
1888	1601	Acosta	141
1897	1610	Punceres	141
1904	1704	García	142
1912	1801	Agua Blanca	143
1917	1806	Monseñor José Vicente De Unda	143
1926	1901	Andrés Eloy Blanco	144
2004	2301	Almirante Padilla	148
2005	2302	Baralt	148
2006	2303	Cabimas	148
2007	2304	Catatumbo	148
2008	2305	Colón	148
2009	2306	Francisco Javier Pulgar	148
2010	2307	Jesús Enrique Lossada	148
2012	2309	La Cañada De Urdaneta	148
2011	2308	Jesús María Semprún	148
2014	2311	Machiques De Perijá	148
2015	2312	Mara	148
2016	2313	Maracaibo	148
2013	2310	Lagunillas	148
2017	2314	Miranda	148
2018	2315	Indǵrna Bolivariano Guajira	148
2019	2316	Rosario De Perijá	148
2020	2317	San Francisco	148
2021	2318	Santa Rita	148
2022	2319	Simón Bolívar	148
2023	2320	Sucre	148
2024	2321	Valmore Rodríguez	148
2025	2401	Vargas	149
1993	2204	Cocorote	147
1994	2205	Independencia	147
1995	2206	José Antonio Páez	147
1996	2207	La Trinidad	147
1997	2208	Manuel Monge	147
1998	2209	Nirgua	147
1999	2210	Peña	147
2000	2211	San Felipe	147
2001	2212	Sucre	147
2002	2213	Urachiche	147
2003	2214	Veroes	147
1976	2107	José Felipe Márquez Cañizales	146
1988	2119	Urdaneta	146
1941	2001	Andrés Bello	145
1953	2013	José María Vargas	145
1962	2022	Samuel Darío Maldonado	145
1938	1913	Ribero	144
1933	1908	Cruz Salmerón Acosta	144
1862	1419	Santos Marquina	139
1857	1414	Obispo Ramos De Lora	139
1844	1401	Alberto Adriani	139
1839	1305	Morán	138
1832	1213	San José De Guaribe	137
1827	1208	Francisco De Miranda	137
1809	1115	Monseñor Iturriza	136
1797	1103	Buchivacoa	136
1693	0202	Autonomo Atabapo	127
1701	0303	Fernando De Peñalver	128
1708	0310	José Gregorio Monagas	128
1719	0321	Turístico Diego Bautista Urbaneja	128
1732	0506	José Rafael Revenga	130
1743	0517	Francisco Linares Alcántara	130
1756	0612	Andrés Eloy Blanco	131
1771	0804	Guacara	133
1781	0814	Valencia	133
1786	0905	Pao De San Juan Bautista	134
2026	2501	Dependencias Federales	150
1930	1905	Bermúdez	144
\.


--
-- Data for Name: parroquia; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.parroquia (id, codigo_parroquia, nombre_parroquia, id_municipio) FROM stdin;
5800	010100	Libertador	1691
5801	010101	Altagracia	1691
5802	010102	Antímano	1691
5803	010103	Candelaria	1691
5804	010104	Caricuao	1691
5805	010105	Catedral	1691
5806	010106	Coche	1691
5807	010107	El Junquito	1691
5808	010108	El Paraíso	1691
5809	010109	El Recreo	1691
5810	010110	El Valle	1691
5811	010111	La Pastora	1691
5812	010112	La Vega	1691
5813	010113	Macarao	1691
5814	010114	San Agustín	1691
5815	010115	San Bernardino	1691
5816	010116	San José	1691
5817	010117	San Juan	1691
5818	010118	San Pedro	1691
5819	010119	Santa Rosalía	1691
5820	010120	Santa Teresa	1691
5821	010121	Sucre	1691
5822	010122	23 De Enero	1691
5823	020100	Alto Orinoco	1692
5824	020101	Huachamacare	1692
5825	020102	Marawaka	1692
5826	020103	Mavaca	1692
5827	020104	Sierra Parima	1692
5828	020200	San Fernando de Atabapo	1693
5829	020201	Ucata	1693
5830	020202	Yapacana	1693
5831	020203	Caname	1693
5832	020300	Atures	1694
5833	020301	Fernando Girón Tovar	1694
5834	020302	Luis Alberto Gómez	1694
5835	020303	Parhueña	1694
5836	020304	Platanillal	1694
5837	020400	Autana	1695
5838	020401	Samariapo	1695
5839	020402	Sipapo	1695
5840	020403	Munduapo	1695
5841	020404	Guayapo	1695
5842	020500	Maroa	1696
5843	020501	Victorino	1696
5844	020502	Comunidad	1696
5845	020600	San Juan de Manapiare	1697
5846	020601	Alto Ventuari	1697
5847	020602	Medio Ventuari	1697
5848	020603	Bajo Ventuari	1697
5849	020700	San Carlos de Río Negro	1698
5850	020701	Solano	1698
5851	020702	Casiquiare	1698
5852	020703	Cocuy	1698
5853	030101	Capital Anaco	1699
5854	030102	San Joaquín	1699
5855	030103	Buena Vista	1699
5856	030201	Capital Aragua de Barcelona	1700
5857	030202	Cachipo	1700
5858	030301	Capital Fernando de Peñalver	1701
5859	030302	San Miguel	1701
5860	030303	Sucre	1701
5861	030401	Capital Francisco del Carmen Carvajal	1702
5862	030402	Santa Bárbara	1702
5863	030501	Capital Francisco de Miranda	1703
5864	030502	Atapirire	1703
5865	030503	Boca del Pao	1703
5866	030504	El Pao	1703
5867	030505	Múcura	1703
5868	030601	Capital Guanta	1704
5869	030602	Chorrerón	1704
5870	030701	Capital Independencia	1705
5871	030702	Mamo	1705
5872	030801	Capital Puerto La Cruz	1706
5873	030802	Pozuelos	1706
5874	030901	Capital Juan Manuel Cajigal	1707
5875	030902	San Pablo	1707
5876	031001	Capital José Gregorio Monagas	1708
5877	031002	Piar	1708
5878	031003	San Diego de Cabrutica	1708
5879	031004	Santa Clara	1708
5880	031005	Uverito	1708
5881	031006	Zuata	1708
5882	031101	Capital Libertad	1709
5883	031102	El Carito	1709
5884	031103	Santa Inés	1709
5885	031201	Capital Manuel Ezequiel Bruzual	1710
5886	031202	Guanape	1710
5887	031203	Sabana de Uchire	1710
5888	031301	Capital Pedro María Fréites	1711
5889	031302	Libertador	1711
5890	031303	Santa Rosa	1711
5891	031304	Urica	1711
5892	031401	Capital Píritu	1712
5893	031402	San Francisco	1712
5894	031500	San José de Guanipa	1713
5895	031601	Capital San Juan de Capistrano	1714
5896	031602	Boca de Chávez	1714
5897	031701	Capital Santa Ana	1715
5898	031702	Pueblo Nuevo	1715
5899	031801	El Carmen	1716
5900	031802	San Cristóbal	1716
5901	031803	Bergantín	1716
5902	031804	Caigua	1716
5903	031805	El Pilar	1716
5904	031806	Naricual	1716
5905	031901	Edmundo Barrios	1717
5906	031902	Miguel Otero Silva	1717
5907	032001	Capital Sir Arthur Mc Gregor	1718
5908	032002	Tomás Alfaro Calatrava	1718
5909	032101	Capital Diego Bautista Urbaneja	1719
5910	032102	El Morro	1719
5911	040101	Urbana Achaguas	1720
5912	040102	Apurito	1720
5913	040103	El Yagual	1720
5914	040104	Guachara	1720
5915	040105	Mucuritas	1720
5916	040106	Queseras del Medio	1720
5917	040200	Municipio Biruaca	1721
5918	040301	Urbana Bruzual	1722
5919	040302	Mantecal	1722
5920	040303	Quintero	1722
5921	040304	Rincón Hondo	1722
5922	040305	San Vicente	1722
5923	040401	Urbana Guasdualito	1723
5924	040402	Aramendi	1723
5925	040403	El Amparo	1723
5926	040404	San Camilo	1723
5927	040405	Urdaneta	1723
5928	040501	Urbana San Juan de Payara	1724
5929	040502	Codazzi	1724
5930	040503	Cunaviche	1724
5931	040601	Urbana Elorza	1725
5932	040602	La Trinidad	1725
5933	040701	Urbana San Fernando	1726
5934	040702	El Recreo	1726
5935	040703	Peñalver	1726
5936	040704	San Rafael de Atamaica	1726
5937	050101	San Mateo	1727
5938	050201	Camatagua	1728
5939	050202	Carmen de Cura	1728
5940	050300	Girardot	1729
5941	050302	No Urbana Choroní	1729
5942	050303	Urbana Las Delicias	1729
5943	050304	Urbana Madre María de San José	1729
5944	050305	Urbana Joaquín Crespo	1729
5945	050306	Urbana Pedro José Ovalles	1729
5946	050307	Urbana José Casanova Godoy	1729
5947	050308	Urbana Andrés Eloy Blanco	1729
5948	050309	Urbana Los Tacariguas	1729
5949	050401	Santa Cruz	1730
5950	050501	Urbana Juan Vicente Bolívar y Ponte	1731
5951	050502	Urbana Castor Nieves Ríos	1731
5952	050503	No Urbana Las Guacamayas	1731
5953	050504	No Urbana Pao de Zárate	1731
5954	050505	No Urbana Zuata	1731
5955	050601	José Rafael Revenga El Consejo	1732
5956	050701	Libertador	1733
5957	050702	No Urbana San Martín de Porres	1733
5958	050801	Mario Briceño Iragorry	1734
5959	050802	Urbana Caña de Azúcar	1734
5960	050901	San Casimiro	1735
5961	050902	No Urbana Güiripa	1735
5962	050903	No Urbana Ollas de Caramacate	1735
5963	050904	No Urbana Valle Morín	1735
5964	051001	San Sebastián de Los Reyes	1736
5965	051101	Santiago Mariño	1737
5966	051102	No Urbana Arévalo Aponte	1737
5967	051103	No Urbana Chuao	1737
5968	051104	No Urbana Samán de Güere	1737
5969	051105	No Urbana Alfredo Pacheco Miranda	1737
5970	051201	Santos Michelena	1738
5971	051202	No Urbana Tiara	1738
5972	051301	Sucre	1739
5973	051302	No Urbana Bella Vista	1739
5974	051401	La Colonia Tovar	1740
5975	051501	Urdaneta	1741
5976	051502	No Urbana Las Peñitas	1741
5977	051503	No Urbana San Francisco de Cara	1741
5978	051504	No Urbana Taguay	1741
5979	051601	Zamora	1742
5980	051602	No Urbana Magdaleno	1742
5981	051603	No Urbana San Francisco de Asís	1742
5982	051604	No Urbana Valles de Tucutunemo	1742
5983	051605	No Urbana Augusto Mijares	1742
5984	051701	Francisco Linares Alcántara	1743
5985	051702	No Urbana Francisco de Miranda	1743
5986	051703	No Urbana Monseñor Feliciano González	1743
5987	051801	Ocumare de la Costa	1743
5988	060101	Sabaneta	1745
5989	060102	Rodríguez Domínguez	1745
5990	060201	Ticoporo	1746
5991	060202	Andrés Bello	1746
5992	060203	Nicolás Pulido	1746
5993	060301	Arismendi	1747
5994	060302	Guadarrama	1747
5995	060303	La Unión	1747
5996	060304	San Antonio	1747
5997	060401	Barinas	1748
5998	060402	Alfredo Arvelo Larriva	1748
5999	060403	San Silvestre	1748
6000	060404	Santa Inés	1748
6001	060405	Santa Lucía	1748
6002	060406	Torunos	1748
6003	060407	El Carmen	1748
6004	060408	Don Rómulo Betancourt	1748
6005	060409	Corazón de Jesús	1748
6006	060410	Ramón Ignacio Méndez	1748
6007	060411	Alto Barinas	1748
6008	060412	Manuel Palacio Fajardo	1748
6009	060413	Juan Antonio Rodríguez Domínguez	1748
6010	060414	Dominga Ortiz de Páez	1748
6011	060501	Barinitas	1749
6012	060502	Altamira	1749
6013	060503	Calderas	1749
6014	060601	Barrancas	1750
6015	060602	El Socorro	1750
6016	060603	Masparrito	1750
6017	060701	Santa Bárbara	1751
6018	060702	José Ignacio del Pumar	1751
6019	060703	Pedro Briceño Méndez	1751
6020	060704	Ramón Ignacio Méndez	1751
6021	060801	Obispos	1752
6022	060802	El Real	1752
6023	060803	La Luz	1752
6024	060804	Los Guasimitos	1752
6025	060901	Ciudad Bolivia	1753
6026	060902	Ignacio Briceño	1753
6027	060903	José Félix Ribas	1753
6028	060904	Páez	1753
6029	061001	Libertad	1754
6030	061002	Dolores	1754
6031	061003	Palacios Fajardo	1754
6032	061004	Santa Rosa	1754
6033	061005	Simón Rodríguez	1754
6034	061101	Ciudad de Nutrias	1755
6035	061102	El Regalo 	1755
6036	061103	Puerto de Nutrias	1755
6037	061104	Santa Catalina	1755
6038	061105	Simón Bolívar	1755
6039	061201	El Cantón	1756
6040	061202	Santa Cruz de Guacas	1756
6041	061203	Puerto Vivas	1756
6042	070101	Cachamay	1757
6043	070102	Chirica	1757
6044	070103	Dalla Costa	1757
6045	070104	Once de Abril	1757
6046	070105	Simón Bolívar	1757
6047	070106	Unare	1757
6048	070107	Universidad	1757
6049	070108	Vista al Sol	1757
6050	070109	Pozo Verde	1757
6051	070110	Yocoima	1757
6052	070111	Cinco de Julio	1757
6053	070201	Sección Capital Cedeño	1758
6054	070202	Altagracia	1758
6055	070203	Ascensión Farreras	1758
6056	070204	Guaniamo	1758
6057	070205	La Urbana	1758
6058	070206	Pijiguaos	1758
6059	070301	El Callao	1759
6060	070401	Sección Capital Gran Sabana	1760
6061	070402	Ikabarú	1761
6062	070501	Agua Salada	1761
6063	070502	Catedral	1761
6064	070503	José Antonio Páez	1761
6065	070504	La Sabanita	1761
6066	070505	Marhuanta	1761
6067	070506	Vista Hermosa	1761
6068	070507	Orinoco	1761
6069	070508	Panapana	1761
6070	070509	Zea	1761
6071	070601	Sección Capital Piar	1762
6072	070602	Andrés Eloy Blanco	1762
6073	070603	Pedro Cova	1762
6074	070701	Sección Capital Angostura	1763
6075	070702	Barceloneta	1763
6076	070703	San Francisco	1763
6077	070704	Santa Bárbara	1763
6078	070801	Sección Capital Roscio	1764
6079	070802	Salom	1764
6080	070901	Sección Capital Sifontes	1765
6081	070902	Dalla Costa	1765
6082	070903	San Isidro	1765
6083	071001	Sección Capital Sucre	1766
6084	071002	Aripao	1766
6085	071003	Guarataro	1766
6086	071004	Las Majadas	1766
6087	071005	Moitaco	1766
6088	071101	Padre Pedro Chien, El Palmar	1767
6089	080101	Bejuma	1768
6090	080102	No Urbana Canoabo	1768
6091	080103	No Urbana Simón Bolívar	1768
6092	080201	Urbana Güigüe	1769
6093	080202	No Urbana Belén	1769
6094	080203	No Urbana Tacarigua	1769
6095	080301	Urbana Aguas Calientes	1770
6096	080302	Urbana Mariara	1770
6097	080400	Guacara	1771
6098	080401	Urbana Ciudad Alianza	1771
6099	080403	No Urbana Yagua	1771
6100	080501	Urbana Morón	1772
6101	080502	No Urbana Urama	1772
6102	080601	Urbana Tocuyito	1773
6103	080602	Urbana Independencia	1773
6104	080701	Urbana Los Guayos	1774
6105	080801	Urbana Miranda	1775
6106	080901	Urbana Montalbán	1776
6107	081001	Urbana Naguanagua	1777
6108	081101	Urbana Bartolomé Salom	1778
6109	081102	Urbana Democracia	1778
6110	081103	Urbana Fraternidad	1778
6111	081104	Urbana Goaigoaza	1778
6112	081105	Urbana Juan José Flores	1778
6113	081106	Urbana Unión	1778
6114	081107	No Urbana Borburata	1778
6115	081108	No Urbana Patanemo	1778
6116	081201	Urbana San Diego	1779
6117	081301	Urbana San Joaquín	1780
6118	081401	Urbana Candelaria	1781
6119	081402	Urbana Catedral	1781
6120	081403	Urbana El Socorro	1781
6121	081404	Urbana Miguel Peña	1781
6122	081405	Urbana Rafael Urdaneta	1781
6123	081406	Urbana San Blas	1781
6124	081407	Urbana San José	1781
6125	081408	Urbana Santa Rosa	1781
6126	081409	No Urbana Negro Primero	1781
6127	090101	Cojedes	1782
6128	090102	Juan de Mata Suárez	1782
6129	090201	Tinaquillo	1783
6130	090301	El Baúl	1784
6131	090302	Sucre	1784
6132	090401	Macapo	1785
6133	090402	La Aguadita	1785
6134	090501	El Pao	1786
6135	090601	Libertad de Cojedes	1787
6136	090602	El Amparo	1787
6137	090701	Rómulo Gallegos	1788
6138	090801	San Carlos de Austria	1789
6139	090802	Juan Ángel Bravo	1789
6140	090803	Manuel Manrique	1789
6141	090901	General en Jefe José Laurencio Silva	1790
6142	100101	Curiapo	1791
6143	100102	Almirante Luis Brión	1791
6144	100103	Francisco Aniceto Lugo	1791
6145	100104	Manuel Renaud	1791
6146	100105	Padre Barral	1791
6147	100106	Santos de Abelgas	1791
6148	100201	Imataca	1792
6149	100202	Cinco de Julio	1792
6150	100203	Juan Bautista Arismendi	1792
6151	100204	Manuel Piar	1792
6152	100205	Rómulo Gallegos	1792
6153	100301	Pedernales	1793
6154	100302	Luis Beltrán Prieto Figueroa	1793
6155	100401	San José	1794
6156	100402	José Vidal Marcano	1794
6157	100403	Juan Millán	1794
6158	100404	Leonardo Ruíz Pineda	1794
6159	100405	Mariscal Antonio José de Sucre	1794
6160	100406	Monseñor Argimiro García	1794
6161	100407	San Rafael	1794
6162	100408	Virgen del Valle	1794
6163	110101	San Juan de los Cayos	1795
6164	110102	Capadare	1795
6165	110103	La Pastora	1795
6166	110104	Libertador	1795
6167	110201	San Luis	1796
6168	110202	Aracua	1796
6169	110203	La Peña	1796
6170	110301	Capatárida	1797
6171	110302	Bariro	1797
6172	110303	Borojó	1797
6173	110304	Guajiro	1797
6174	110305	Seque	1797
6175	110306	Zazárida	1797
6176	110401	Cacique Manaure, Yaracal	1798
6177	110501	Carirubana	1799
6178	110502	Norte	1799
6179	110503	Punta Cardón	1799
6180	110504	Santa Ana	1799
6181	110601	La Vela de Coro	1800
6182	110602	Acurigua	1800
6183	110603	Guaibacoa	1800
6184	110604	Las Calderas	1800
6185	110605	Macoruca	1800
6186	110701	Dabajuro	1801
6187	110801	Pedregal	1802
6188	110802	Agua Clara	1802
6189	110803	Avaria	1802
6190	110804	Piedra Grande	1802
6191	110805	Purureche	1802
6192	110901	Pueblo Nuevo	1803
6193	110902	Adícora	1803
6194	110903	Baraived	1803
6195	110904	Buena Vista	1803
6196	110905	Jadacaquiva	1803
6197	110906	Moruy	1803
6198	110907	Adaure	1803
6199	110908	El Hato	1803
6200	110909	El Vínculo	1803
6201	111001	Churuguara	1804
6202	111002	Agua Larga	1804
6203	111003	El Paují	1804
6204	111004	Independencia	1804
6205	111005	Mapararí	1804
6206	111101	Jacura	1805
6207	111102	Agua Linda	1805
6208	111103	Araurima	1805
6209	111201	Los Taques	1806
6210	111202	Judibana	1806
6211	111301	Mene de Mauroa	1807
6212	111302	Casigua	1807
6213	111303	San Félix	1807
6214	111401	San Antonio	1808
6215	111402	San Gabriel	1808
6216	111403	Santa Ana	1808
6217	111404	Guzmán Guillermo	1808
6218	111405	Mitare	1808
6219	111406	Río Seco	1808
6220	111407	Sabaneta	1808
6221	111501	Chichiriviche	1809
6222	111502	Boca de Tocuyo	1809
6223	111503	Tocuyo de la Costa	1809
6224	111601	Palmasola	1810
6225	111701	Cabure	1811
6226	111702	Colina	1811
6227	111703	Curimagua	1811
6228	111801	Píritu	1812
6229	111802	San José de la Costa	1812
6230	111901	San Francisco, Mirimire	1813
6231	112001	Tucacas	1814
6232	112002	Boca de Aroa	1814
6233	112101	Sucre	1815
6234	112102	Pecaya	1815
6235	112201	Tocópero	1816
6236	112301	Santa Cruz de Bucaral	1817
6237	112302	El Charal	1817
6238	112303	Las Vegas del Tuy	1817
6239	112401	Urumaco	1818
6240	112402	Bruzual	1818
6241	112501	Puerto Cumarebo	1819
6242	112502	La Ciénaga	1819
6243	112503	La Soledad	1819
6244	112504	Pueblo Cumarebo	1819
6245	112505	Zazárida	1819
6246	120101	Capital Camaguán	1820
6247	120102	Puerto Miranda	1820
6248	120103	Uverito	1820
6249	120201	Chaguaramas	1821
6250	120301	El Socorro	1822
6251	120401	Capital San Gerónimo de Guayabal	1823
6252	120402	Cazorla	1823
6253	120501	Capital Valle de La Pascua	1824
6254	120502	Espino	1824
6255	120601	Capital Las Mercedes	1825
6256	120602	Cabruta	1825
6257	120603	Santa Rita de Manapire	1825
6258	120701	Capital El Sombrero	1826
6259	120702	Sosa	1826
6260	120801	Capital Calabozo	1827
6261	120802	El Calvario	1827
6262	120803	El Rastro	1827
6263	120804	Guardatinajas	1827
6264	120901	Capital Altagracia de Orituco	1828
6265	120902	Lezama	1828
6266	120903	Libertad de Orituco	1828
6267	120904	Paso Real de Macaira	1828
6268	120905	San Francisco de Macaira	1828
6387	141207	Jacinto Plaza	1855
6269	120906	San Rafael de Orituco	1828
6270	120907	Soublette	1828
6271	121001	Capital Ortiz	1829
6272	121002	San Francisco de Tiznado	1829
6273	121003	San José de Tiznado	1829
6274	121004	San Lorenzo de Tiznado	1829
6275	121101	Capital Tucupido	1830
6276	121102	San Rafael de Laya	1830
6277	121201	Capital San Juan de Los Morros	1831
6278	121202	Cantagallo	1831
6279	121203	Parapara	1831
6280	121301	San José de Guaribe	1832
6281	121401	Capital Santa María de Ipire	1833
6282	121402	Altamira	1833
6283	121501	Capital Zaraza	1834
6284	121502	San José de Unare	1834
6285	130101	Pío Tamayo	1835
6286	130102	Quebrada Honda de Guache	1835
6287	130103	Yacambú	1835
6288	130201	Fréitez	1836
6289	130202	José María Blanco	1836
6290	130301	Catedral	1837
6291	130302	Concepción	1837
6292	130303	El Cují	1837
6293	130304	Juan de Villegas	1837
6294	130305	Santa Rosa	1837
6295	130306	Tamaca	1837
6296	130307	Unión	1837
6297	130308	Aguedo Felipe Alvarado	1837
6298	130309	Buena Vista	1837
6299	130310	Juárez	1837
6300	130401	Juan Bautista Rodríguez	1838
6301	130402	Cuara	1838
6302	130403	Diego de Lozada	1838
6303	130404	Paraíso de San José	1838
6304	130405	San Miguel	1838
6305	130406	Tintorero	1838
6306	130407	José Bernardo Dorante	1838
6307	130408	Coronel Mariano Peraza	1838
6308	130501	Bolívar	1839
6309	130502	Anzoátegui	1839
6310	130503	Guarico	1839
6311	130504	Hilario Luna y Luna	1839
6312	130505	Humocaro Alto	1839
6313	130506	Humocaro Bajo	1839
6314	130507	La Candelaria	1839
6315	130508	Morán	1839
6316	130601	Cabudare	1840
6317	130602	José Gregorio Bastidas	1840
6318	130603	Agua Viva	1840
6319	130701	Sarare	1841
6320	130702	Buría	1841
6321	130703	Gustavo Vegas León	1841
6322	130801	Trinidad Samuel	1842
6323	130802	Antonio Díaz	1842
6324	130803	Camacaro	1842
6325	130804	Castañeda	1842
6326	130805	Cecilio Zubillaga	1842
6327	130806	Chiquinquirá	1842
6328	130807	El Blanco 	1842
6329	130808	Espinoza de los Monteros	1842
6330	130809	Lara	1842
6331	130810	Las Mercedes	1842
6332	130811	Manuel Morillo	1842
6333	130812	Montaña Verde 	1842
6334	130813	Montes de Oca	1842
6335	130814	Torres	1842
6336	130815	Heriberto Arroyo	1842
6337	130816	Reyes Vargas	1842
6338	130817	Altagracia	1842
6339	130901	Siquisique	1843
6340	130902	Moroturo	1843
6341	130903	San Miguel	1843
6342	130904	Xaguas	1843
6343	140101	Presidente Betancourt	1844
6344	140102	Presidente Páez	1844
6345	140103	Presidente Rómulo Gallegos	1844
6346	140104	Gabriel Picón González	1844
6347	140105	Héctor Amable Mora	1844
6348	140106	José Nucete Sardi 	1844
6349	140107	Pulido Méndez	1844
6350	140201	La Azulita	1845
6351	140301	Capital Antonio Pinto Salinas	1846
6352	140302	Mesa Bolívar	1846
6353	140303	Mesa de Las Palmas	1846
6354	140401	Capital Aricagua	1847
6355	140402	San Antonio	1847
6356	140501	Capital Arzobispo Chacón	1848
6357	140502	Capurí	1848
6358	140503	Chacantá	1848
6359	140504	El Molino	1848
6360	140505	Guaimaral	1848
6361	140506	Mucutuy	1848
6362	140507	Mucuchachí	1848
6363	140601	Fernández Peña	1849
6364	140602	Matriz	1849
6365	140603	Montalbán	1849
6366	140604	Acequias	1849
6367	140605	Jají	1849
6368	140606	La Mesa	1849
6369	140607	San José del Sur	1849
6370	140701	Capital Caracciolo Parra Olmedo	1850
6371	140702	Florencio Ramírez	1850
6372	140801	Capital Cardenal Quintero	1851
6373	140802	Las Piedras	1851
6374	140901	Capital Guaraque	1852
6375	140902	Mesa de Quintero	1852
6376	140903	Río Negro	1852
6377	141001	Capital Julio César Salas	1853
6378	141002	Palmira	1853
6379	141101	Capital Justo Briceño	1854
6380	141102	San Cristóbal de Torondoy	1854
6381	141201	Antonio Spinetti Dini	1855
6382	141202	Arias	1855
6383	141203	Caracciolo Parra Pérez	1855
6384	141204	Domingo Peña	1855
6385	141205	El Llano	1855
6386	141206	Gonzalo Picón Febres	1855
6388	141208	Juan Rodríguez Suárez	1855
6389	141209	Lasso de la Vega	1855
6390	141210	Mariano Picón Salas	1855
6391	141211	Milla	1855
6392	141212	Osuna Rodríguez	1855
6393	141213	Sagrario	1855
6394	141214	El Morro	1855
6395	141215	Los Nevados	1855
6396	141301	Capital Miranda	1856
6397	141302	Andrés Eloy Blanco	1856
6398	141303	La Venta	1856
6399	141304	Piñango	1856
6400	141401	Capital Obispo Ramos de Lora	1857
6401	141402	Eloy Paredes	1857
6402	141403	San Rafael de Alcázar	1857
6403	141501	Padre Noguera, Santa María de Caparo	1858
6404	141601	Pueblo Llano	1859
6405	141701	Capital Rangel	1860
6406	141702	Cacute	1860
6407	141703	La Toma	1860
6408	141704	Mucurubá	1860
6409	141705	San Rafael	1860
6410	141801	Capital Rivas Dávila	1861
6411	141802	Gerónimo Maldonado	1861
6412	141901	Santos Marquina, Tabay	1862
6413	142001	Capital Sucre	1863
6414	142002	Chiguará	1863
6415	142003	Estánques	1863
6416	142004	La Trampa	1863
6417	142005	Pueblo Nuevo del Sur	1863
6418	142006	San Juan	1863
6419	142101	El Amparo	1864
6420	142102	El Llano	1864
6421	142103	San Francisco	1864
6422	142104	Tovar	1864
6423	142201	Capital Tulio Febres Cordero	1865
6424	142202	Independencia	1865
6425	142203	María de la Concepción Palacios Blanco	1865
6426	142204	Santa Apolonia	1865
6427	142301	Capital Zea	1866
6428	142302	Caño El Tigre	1866
6429	150101	Caucagua	1867
6430	150102	Aragüita	1867
6431	150103	Arévalo González	1867
6432	150104	Capaya	1867
6433	150105	El Café	1867
6434	150106	Marizapa	1867
6435	150107	Panaquire	1867
6436	150108	Ribas	1867
6437	150201	San José de Barlovento	1868
6438	150202	Cumbo	1868
6439	150301	Nuestra Señora del Rosario de Baruta	1869
6440	150302	El Cafetal	1869
6441	150303	Las Minas de Baruta	1869
6442	150401	Higuerote	1870
6443	150402	Curiepe	1870
6444	150403	Tacarigua	1870
6445	150501	Mamporal	1871
6446	150601	Carrizal	1872
6447	150701	Chacao	1873
6448	150801	Charallave	1874
6449	150802	Las Brisas	1874
6450	150901	El Hatillo	1875
6451	151001	Los Teques	1876
6452	151002	Altagracia de La Montaña	1876
6453	151003	Cecilio Acosta	1876
6454	151004	El Jarillo	1876
6455	151005	Paracotos	1876
6456	151006	San Pedro	1876
6457	151007	Tácata	1876
6458	151101	Santa Teresa del Tuy	1877
6459	151102	El Cartanal	1877
6460	151201	Ocumare del Tuy	1878
6461	151202	La Democracia	1878
6462	151203	Santa Bárbara	1878
6463	151301	San Antonio de Los Altos	1879
6464	151401	Río Chico	1880
6465	151402	El Guapo	1880
6466	151403	Tacarigua de La Laguna	1880
6467	151404	Paparo	1880
6468	151405	San Fernando del Guapo	1880
6469	151501	Santa Lucía	1881
6470	151601	Cúpira	1882
6471	151602	Machurucuto	1882
6472	151701	Guarenas	1883
6473	151801	San Francisco de Yare	1884
6474	151802	San Antonio de Yare	1884
6475	151901	Petare	1885
6476	151902	Caucagüita	1885
6477	151903	Fila de Mariche	1885
6478	151904	La Dolorita	1885
6479	151905	Leoncio Martínez	1885
6480	152001	Cúa	1886
6481	152002	Nueva Cúa	1886
6482	152101	Guatire	1887
6483	152102	Bolívar	1887
6484	160101	Capital Acosta	1888
6485	160102	San Francisco	1888
6486	160201	Aguasay	1889
6487	160301	Caripito	1890
6488	160401	Capital Caripe	1891
6489	160402	El Guácharo	1891
6490	160403	La Guanota	1891
6491	160404	Sabana de Piedra	1891
6492	160405	San Agustín	1891
6493	160406	Teresén	1891
6494	160501	Capital Cedeño	1892
6495	160502	Areo	1892
6496	160503	San Félix	1892
6497	160504	Viento Fresco	1892
6498	160601	Capital Ezequiel Zamora	1893
6499	160602	El Tejero	1893
6500	160701	Capital Libertador 	1894
6501	160702	Chaguaramas	1894
6502	160703	Las Alhuacas	1894
6503	160704	Tabasca	1894
6504	160801	Capital Maturín	1895
6505	160802	Alto de los Godos	1895
6506	160803	Boquerón	1895
6507	160804	Las Cocuizas	1895
6508	160805	San Simón	1895
6509	160806	Santa Cruz	1895
6510	160807	El Corozo	1895
6511	160808	El Furrial	1895
6512	160809	Jusepín	1895
6513	160810	La Pica	1895
6514	160811	San Vicente	1895
6515	160901	Capital Piar	1896
6516	160902	Aparicio	1896
6517	160903	Chaguaramal	1896
6518	160904	El Pinto	1896
6519	160905	Guanaguana	1896
6520	160906	La Toscana	1896
6521	160907	Taguaya	1896
6522	161001	Capital Punceres	1897
6523	161002	Cachipo	1897
6524	161101	Santa Bárbara	1898
6525	161201	Capital Sotillo	1899
6526	161202	Los Barrancos de Fajardo	1899
6527	161301	Uracoa	1900
6528	170101	Antolín del Campo, La Plaza De Paraguachí	1901
6529	170201	Arismendi, La Asunción	1902
6530	170301	Capital Díaz	1903
6531	170302	Zabala	1903
6532	170401	Capital García	1904
6533	170402	Francisco Fajardo	1904
6534	170501	Capital Gómez	1905
6535	170502	Bolívar	1905
6536	170503	Guevara	1905
6537	170504	Matasiete	1905
6538	170505	Sucre	1905
6539	170601	Capital Maneiro	1906
6540	170602	Aguirre	1906
6541	170701	Capital Marcano	1907
6542	170702	Adrián	1907
6543	170801	Mariño, Porlamar	1908
6544	170901	Capital Península de Macanao	1909
6545	170902	San Francisco	1909
6546	171001	Capital Tubores	1910
6547	171002	Los Barales	1910
6548	171101	Capital Villalba	1911
6549	171102	Vicente Fuentes	1911
6550	180101	Agua Blanca	1912
6551	180201	Capital Araure	1913
6552	180202	Río Acarigua	1913
6553	180301	Capital Esteller	1914
6554	180302	Uveral	1914
6555	180401	Capital Guanare	1915
6556	180402	Córdoba	1915
6557	180403	San José de la Montaña	1915
6558	180404	San Juan de Guanaguanare	1915
6559	180405	Virgen de la Coromoto	1915
6560	180501	Capital Guanarito	1916
6561	180502	Trinidad de la Capilla	1916
6562	180503	Divina Pastora	1916
6563	180601	Capital Monseñor José Vicente de Unda	1917
6564	180602	Peña Blanca	1917
6565	180701	Capital Ospino	1918
6566	180702	Aparición	1918
6567	180703	La Estación	1918
6568	180801	Capital Páez	1919
6569	180802	Payara	1919
6570	180803	Pimpinela	1919
6571	180804	Ramón Peraza	1919
6572	180901	Capital Papelón	1920
6573	180902	Caño Delgadito	1920
6574	181001	Capital San Genaro de Boconoito	1921
6575	181002	Antolín Tovar	1921
6576	181101	Capital San Rafael de Onoto	1922
6577	181102	Santa Fe	1922
6578	181103	Thermo Morles	1922
6579	181201	Capital Santa Rosalía	1923
6580	181202	Florida	1923
6581	181301	Capital Sucre	1924
6582	181302	Concepción	1924
6583	181303	San Rafael de Palo Alzado	1924
6584	181304	Uvencio Antonio Velásquez	1924
6585	181305	San José de Saguaz	1924
6586	181306	Villa Rosa	1924
6587	181401	Capital Turén	1925
6588	181402	Canelones	1925
6589	181403	Santa Cruz	1925
6590	181404	San Isidro Labrador	1925
6591	190101	Mariño	1926
6592	190102	Rómulo Gallegos	1926
6593	190201	San José de Aerocuar	1927
6594	190202	Tavera Acosta	1927
6595	190301	Río Caribe	1928
6596	190302	Antonio José de Sucre	1928
6597	190303	El Morro de Puerto Santo	1928
6598	190304	Puerto Santo	1928
6599	190305	San Juan de Las Galdonas	1928
6600	190401	El Pilar	1929
6601	190402	El Rincón	1929
6602	190403	General Francisco Antonio Vásquez	1929
6603	190404	Guaraúnos	1929
6604	190405	Tunapuicito	1929
6605	190406	Unión	1929
6606	190501	Bolívar	1930
6607	190502	Macarapana	1930
6608	190503	Santa Catalina	1930
6609	190504	Santa Rosa	1930
6610	190505	Santa Teresa	1930
6611	190601	Bolívar, Marigüitar	1931
6612	190701	Yaguaraparo	1932
6613	190702	El Paujil	1932
6614	190703	Libertad	1932
6615	190801	Araya	1933
6616	190802	Chacopata	1933
6617	190803	Manicuare	1933
6618	190901	Tunapuy	1934
6619	190902	Campo Elías	1934
6620	191001	Irapa	1935
6621	191002	Campo Claro	1935
6622	191003	Marabal	1935
6623	191004	San Antonio de Irapa	1935
6624	191005	Soro	1935
6625	191101	Mejía, San Antonio del Golfo	1936
6626	191201	Cumanacoa	1937
6627	191202	Arenas	1937
6628	191203	Aricagua	1937
6629	191204	Cocollar	1937
6630	191205	San Fernando	1937
6631	191206	San Lorenzo	1937
6632	191301	Cariaco	1938
6633	191302	Catuaro	1938
6634	191303	Rendón	1938
6635	191304	Santa Cruz	1938
6636	191305	Santa María	1938
6637	191401	Altagracia	1939
6638	191402	Ayacucho	1939
6639	191403	Santa Inés	1939
6640	191404	Valentín Valiente	1939
6641	191405	San Juan	1939
6642	191406	Raúl Leoni	1939
6643	191407	Gran Mariscal	1939
6644	191501	Güiria	1940
6645	191502	Bideau	1940
6646	191503	Cristóbal Colón	1940
6647	191504	Punta de Piedras	1940
6648	200101	Andrés Bello, Cordero	1941
6649	200200	Antonio Rómulo Costa, Las mesas	1942
6650	200301	Ayacucho	1943
6651	200302	Rivas Berti	1943
6652	200303	San Pedro del Río	1943
6653	200401	Bolívar	1944
6654	200402	Palotal	1944
6655	200403	Juan Vicente Gómez	1944
6656	200404	Isaías Medina Angarita	1944
6657	200501	Cárdenas	1945
6658	200502	Amenodoro Rangel Lamús	1945
6659	200503	La Florida	1945
6660	200601	Córdoba, Santa Ana	1946
6661	200700	Fernández Feo	1947
6662	200702	Alberto Adriani	1947
6663	200703	Santo Domingo	1947
6664	200801	Francisco de Miranda	1948
6665	200901	García de Hevia	1949
6666	200902	Boca de Grita	1949
6667	200903	José Antonio Páez	1949
6668	201001	Guásimos, Palmira	1950
6669	201101	Independencia	1951
6670	201102	Juan Germán Roscio	1951
6671	201103	Román Cárdenas	1951
6672	201201	Jáuregui	1952
6673	201202	Emilio Constantino Guerrero	1952
6674	201203	Monseñor Miguel Antonio Salas	1952
6675	201301	José María Vargas, El Cobre	1953
6676	201401	Junín	1954
6677	201402	La Petrólea	1954
6678	201403	Quinimarí	1954
6679	201404	Bramón	1954
6680	201501	Libertad	1955
6681	201502	Cipriano Castro	1955
6682	201503	Manuel Felipe Rugeles	1955
6683	201600	Libertador	1956
6684	201602	Don Emeterio Ochoa	1956
6685	201603	Doradas	1956
6686	201604	San Joaquín de Navay	1956
6687	201701	Lobatera	1957
6688	201702	Constitución	1957
6689	201801	Michelena	1958
6690	201901	Panamericano	1959
6691	201902	La Palmita 	1959
6692	202001	Pedro María Ureña	1960
6693	202002	Nueva Arcadia	1960
6694	202101	Rafael Urdaneta	1961
6695	202201	Samuel Darío Maldonado	1962
6696	202202	Boconó	1962
6697	202203	Hernández	1962
6698	202301	La Concordia	1963
6699	202302	Pedro María Morantes	1963
6700	202303	San Juan Bautista	1963
6701	202304	San Sebastián	1963
6702	202305	Dr. Francisco Romero Lobo	1963
6703	202401	Seboruco	1964
6704	202501	Simón Rodríguez	1965
6705	202601	Sucre	1966
6706	202602	Eleazar López Contreras	1966
6707	202603	San Pablo	1966
6708	202701	Torbes	1967
6709	202801	Uribante	1968
6710	202802	Cárdenas	1968
6711	202803	Juan Pablo Peñaloza	1968
6712	202804	Potosí	1968
6713	202901	San Judas Tadeo, Umuquena	1969
6714	210101	Santa Isabel	1970
6715	210102	Araguaney	1970
6716	210103	El Jagüito	1970
6717	210104	La Esperanza	1970
6718	210201	Boconó	1971
6719	210202	El Carmen	1971
6720	210203	Mosquey	1971
6721	210204	Ayacucho	1971
6722	210205	Burbusay	1971
6723	210206	General Rivas	1971
6724	210207	Guaramacal	1971
6725	210208	Vega de Guaramacal	1971
6726	210209	Monseñor Jáuregui	1971
6727	210210	Rafael Rangel	1971
6728	210211	San Miguel	1971
6729	210212	San José	1971
6730	210301	Sabana Grande	1972
6731	210302	Cheregüé	1972
6732	210303	Granados	1972
6733	210401	Chejendé	1973
6734	210402	Arnoldo Gabaldón	1973
6735	210403	Bolivia	1973
6736	210404	Carrillo	1973
6737	210405	Cegarra	1973
6738	210406	Manuel Salvador Ulloa	1973
6739	210407	San José	1973
6740	210501	Carache	1974
6741	210502	Cuicas	1974
6742	210503	La Concepción	1974
6743	210504	Panamericana	1974
6744	210505	Santa Cruz	1974
6745	210601	Escuque	1975
6746	210602	La Unión	1975
6747	210603	Sabana Libre	1975
6748	210604	Santa Rita	1975
6749	210701	El Socorro	1976
6750	210702	Antonio José de Sucre	1976
6751	210703	Los Caprichos	1976
6752	210801	Campo Elías	1977
6753	210802	Arnoldo Gabaldón	1977
6754	210901	Santa Apolonia	1978
6755	210902	El Progreso	1978
6756	210903	La Ceiba	1978
6757	210904	Tres de Febrero	1978
6758	211001	El Dividive	1979
6759	211002	Agua Santa	1979
6760	211003	Agua Caliente	1979
6761	211004	El Cenizo	1979
6762	211005	Valerita	1979
6763	211101	Monte Carmelo	1980
6764	211102	Buena Vista	1980
6765	211103	Santa María del Horcón	1980
6766	211201	Motatán	1981
6767	211202	El Baño	1981
6768	211203	Jalisco	1981
6769	211301	Pampán	1982
6770	211302	Flor de Patria	1982
6771	211303	La Paz	1982
6772	211304	Santa Ana	1982
6773	211401	Pampanito	1983
6774	211402	La Concepción	1983
6775	211403	Pampanito II	1983
6776	211501	Betijoque	1984
6777	211502	La Pueblita	1984
6778	211503	Los Cedros	1984
6779	211504	José Gregorio Hernández	1984
6780	211601	Carvajal	1985
6781	211602	Antonio Nicolás Briceño	1985
6782	211603	Campo Alegre	1985
6783	211604	José Leonardo Suárez	1985
6784	211701	Sabana de Mendoza	1986
6785	211702	El Paraíso	1986
6786	211703	Junín	1986
6787	211704	Valmore Rodríguez	1986
6788	211801	Andrés Linares	1987
6789	211802	Chiquinquirá	1987
6790	211803	Cristóbal Mendoza	1987
6791	211804	Cruz Carrillo	1987
6792	211805	Matriz	1987
6793	211806	Monseñor Carrillo	1987
6794	211807	Tres Esquinas	1987
6795	211901	La Quebrada	1987
6796	211902	Cabimbú	1987
6797	211903	Jajó	1987
6798	211904	La Mesa	1987
6799	211905	Santiago	1987
6800	211906	Tuñame	1987
6801	212001	Juan Ignacio Montilla	1989
6802	212002	La Beatriz	1989
6803	212003	Mercedes Díaz	1989
6804	212004	San Luis	1989
6805	212005	La Puerta	1989
6806	212006	Mendoza	1989
6807	220101	Arístides Bastidas, San Pablo	1990
6808	220201	Bolívar, Aroa	1991
6809	220301	Capital Bruzual	1992
6810	220302	Campo Elías	1992
6811	220401	Cocorote	1993
6812	220501	Independencia	1994
6813	220601	José Antonio Páez	1995
6814	220701	La Trinidad, Boraure	1996
6815	220801	Manuel Monge, Yumare	1997
6816	220901	Capital Nirgua	1998
6817	220902	Salom	1998
6818	220903	Temerla	1998
6819	221001	Capital Peña	1999
6820	221002	San Andrés	1999
6821	221101	Capital San Felipe	2000
6822	221102	Albarico	2000
6823	221103	San Javier	2000
6824	221201	Sucre, Guama	2001
6825	221301	Urachiche	2002
6826	221401	Capital Veroes	2003
6827	221402	El Guayabo	2003
6828	230101	Isla de Toas	2004
6829	230102	Monagas	2004
6830	230201	San Timoteo	2005
6831	230202	General Urdaneta 	2005
6832	230203	Libertador	2005
6833	230204	Manuel Guanipa Matos	2005
6834	230205	Marcelino Briceño 	2005
6835	230206	Pueblo Nuevo	2005
6836	230301	Ambrosio	2006
6837	230302	Carmen Herrera	2006
6838	230303	Germán Ríos Linares	2006
6839	230304	La Rosa	2006
6840	230305	Jorge Hernández	2006
6841	230306	Rómulo Betancourt	2006
6842	230307	San Benito	2006
6843	230308	Arístides Calvani	2006
6844	230309	Punta Gorda	2006
6845	230401	Encontrados	2007
6846	230402	Udón Pérez	2007
6847	230501	San Carlos del Zulia	2008
6848	230502	Moralito 	2008
6849	230503	Santa Bárbara	2008
6850	230504	Santa Cruz del Zulia	2008
6851	230505	Urribarri	2008
6852	230601	Simón Rodríguez	2009
6853	230602	Carlos Quevedo	2009
6854	230603	Francisco Javier Pulgar	2009
6855	230604	Agustín Codazzi	2009
6856	230701	La Concepción	2010
6857	230702	José Ramón Yepes	2010
6858	230703	Mariano Parra León	2010
6859	230704	San José	2010
6860	230801	Jesús María Semprún	2011
6861	230802	Barí	2011
6862	230901	Concepción	2012
6863	230902	Andrés Bello	2012
6864	230903	Chiquinquirá	2012
6865	230904	El Carmelo	2012
6866	230905	Potreritos	2012
6867	231001	Alonso de Ojeda	2013
6868	231002	Libertad	2013
6869	231003	Campo Lara	2013
6870	231004	Eleazar López Contreras	2013
6871	231005	Venezuela	2013
6872	231006	El Danto	2013
6873	231101	Libertad	2014
6874	231102	Bartolomé de las Casas	2014
6875	231103	Río Negro	2014
6876	231104	San José de Perijá	2014
6877	231201	San Rafael	2015
6878	231202	La Sierrita	2015
6879	231203	Las Parcelas	2015
6880	231204	Luis de Vicente	2015
6881	231205	Monseñor Marcos Sergio Godoy	2015
6882	231206	Ricaurte	2015
6883	231207	Tamare	2015
6884	231301	Antonio Borjas Romero	2016
6885	231302	Bolívar	2016
6886	231303	Cacique Mara	2016
6887	231304	Caracciolo Parra Pérez	2016
6888	231305	Cecilio Acosta	2016
6889	231306	Cristo de Aranza	2016
6890	231307	Coquivacoa	2016
6891	231308	Chiquinquirá	2016
6892	231309	Francisco Eugenio Bustamante	2016
6893	231310	Idelfonso Vásquez	2016
6894	231311	Juana de Ávila	2016
6895	231312	Luis Hurtado Higuera	2016
6896	231313	Manuel Dagnino	2016
6897	231314	Olegario Villalobos	2016
6898	231315	Raúl Leoni	2016
6899	231316	Santa Lucía	2016
6900	231317	Venancio Pulgar	2016
6901	231318	San Isidro	2016
6902	231401	Altagracia	2017
6903	231402	Ana María Campos	2017
6904	231403	Faría	2017
6905	231404	San Antonio	2017
6906	231405	San José	2017
6907	231406	José Antonio Chaves	2017
6908	231501	Sinamaica	2018
6909	231502	Alta Guajira	2018
6910	231503	Elías Sánchez Rubio	2018
6911	231504	Guajira	2018
6912	231601	El Rosario	2019
6913	231602	Donaldo García	2019
6914	231603	Sixto Zambrano	2019
6915	231701	San Francisco	2020
6916	231702	El Bajo	2020
6917	231703	Domitila Flores	2020
6918	231704	Francisco Ochoa	2020
6919	231705	Los Cortijos	2020
6920	231706	Marcial Hernández	2020
6921	231707	José Domingo Rus	2020
6922	231801	Santa Rita	2021
6923	231802	El Mene	2021
6924	231803	José Cenovio Urribarri	2021
6925	231804	Pedro Lucas Urribarri	2021
6926	231901	Manuel Manrique	2022
6927	231902	Rafael María Baralt	2022
6928	231903	Rafael Urdaneta	2022
6929	232001	Bobures	2023
6930	232002	El Batey	2023
6931	232003	Gibraltar	2023
6932	232004	Heras	2023
6933	232005	Monseñor Arturo Celestino Álvarez	2023
6934	232006	Rómulo Gallegos	2023
6935	232101	La Victoria	2024
6936	232102	Rafael Urdaneta	2024
6937	232103	Raúl Cuenca	2024
6938	240101	Caraballeda	2025
6939	240102	Carayaca	2025
6940	240103	Caruao	2025
6941	240104	Catia La Mar	2025
6942	240105	El Junko	2025
6943	240106	La Guaira	2025
6944	240107	Macuto	2025
6945	240108	Maiquetía	2025
6946	240109	Naiguatá	2025
6947	240110	Urimare	2025
6948	240111	Carlos Soublette	2025
6949	250101	Gran Roque	2026
6950	250102	Los Testigos	2026
6951	250103	Chimanas	2026
\.


--
-- Data for Name: tipo_usuario; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.tipo_usuario (id, descripcion, created_at, updated_at) FROM stdin;
1	ESTUDIANTE	2023-07-14 18:31:31	2023-07-14 18:31:31
2	COMUNIDAD	2023-07-14 18:31:31	2023-07-14 18:31:31
3	INTERNO	2023-07-14 18:31:31	2023-07-14 18:31:31
\.


--
-- Data for Name: aperturas; Type: TABLE DATA; Schema: entidades; Owner: postgres
--

COPY entidades.aperturas (id, carrera, trayecto, seccion, created_at, updated_at) FROM stdin;
4	INF	1	7123	2024-01-17 10:48:01	2024-01-17 10:48:01
5	INF	3	7121	2024-01-21 01:18:46	2024-01-21 01:18:46
\.


--
-- Data for Name: comunidad; Type: TABLE DATA; Schema: entidades; Owner: postgres
--

COPY entidades.comunidad (id, nombre, rif, telefono, email, id_direccion, created_at, updated_at, descripcion, instagram, facebook, fecha_actualizacion_datos) FROM stdin;
7	UNIDOS CONTRA EL CANCER VENEZUELA	J281430333	04124256532	\N	39	2023-07-20 16:10:29	2023-07-20 16:10:29	\N	\N	\N	\N
14	EMPRESA PRUEBA	J17864450-2	4241623426	\N	53	2023-10-31 12:03:50	2023-10-31 12:03:50	\N	\N	\N	\N
16	Instituto Nacional de Transporte Terrestre (INTT)	G20002414-2	4126153004	\N	59	2023-10-31 15:52:09	2023-10-31 15:52:09	\N	\N	\N	\N
17	Conductores unidos	\N	04121021693	\N	63	2024-01-21 19:52:39	2024-01-21 19:52:39	\N	\N	\N	\N
18	liceo andres bello	\N	4129127852	\N	64	2024-01-22 17:28:58	2024-01-22 17:28:58	\N	\N	\N	\N
19	liceo AMT	\N	4169344962	\N	66	2024-01-22 18:59:36	2024-01-22 18:59:36	\N	\N	\N	\N
22	UNIDOS CONTRA EL CANCER VENEZUELA2	J2814303332	04124256533	\N	69	2024-01-22 19:07:26	2024-01-22 19:07:26	\N	\N	\N	\N
23	liceo muñoz tebar	\N	04242942636	\N	72	2024-01-25 18:34:06	2024-01-25 18:34:06	\N	\N	\N	\N
1	EMPRESAS POLAR S.A	\N	04127081154	\N	1	2023-07-14 18:31:31	2023-07-14 18:31:31	\N	\N	\N	\N
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: entidades; Owner: postgres
--

COPY entidades.persona (id, nombres, apellidos, cedula, fullname, telefono, id_direccion, created_at, updated_at) FROM stdin;
1	Desarrollo	Comunidad	12345654	Desarrollo Comunidad	04127081154	\N	2023-07-14 18:31:31	2023-07-14 18:31:31
32	ROXLENE FRANSHESCA	VERA HERNÁNDEZ	28143033	ROXLENE FRANSHESCA VERA HERNÁNDEZ	04127081155	37	2023-07-20 16:08:05	2023-07-20 16:08:05
41	JOSE	ESPINOZA	V17864450	JOSE ESPINOZA	\N	\N	2023-10-31 12:03:50	2023-10-31 12:03:50
49	EURO ALEJANDRO	GONZALEZ PEÑA	26838059	EURO ALEJANDRO GONZALEZ PEÑA	04141175756	61	2024-01-10 19:12:59	2024-01-10 19:12:59
50	PAULA VALENTINA	GALLARDO CONTRERAS	28447913	PAULA VALENTINA GALLARDO CONTRERAS	04125353681	62	2024-01-10 19:27:55	2024-01-10 19:27:55
52	ROSAURA DEL VALLE	HERNANDEZ TORRES	9411198	ROSAURA DEL VALLE HERNANDEZ TORRES	04242251556	\N	2024-01-17 10:32:35	2024-01-17 10:32:35
60	ROXANA EVELYN	NOBLOT HERNANDEZ	17167728	ROXANA EVELYN NOBLOT HERNANDEZ	04242251556	\N	2024-01-17 10:48:01	2024-01-17 10:48:01
47	RAFAEL ANTONIO	BRITO OZUNA	V24906478	RAFAEL ANTONIO BRITO OZUNA	\N	\N	2023-10-31 15:52:09	2023-10-31 15:52:09
72	RAFAEL ANTONIO	BRITO OZUNA	24906477	RAFAEL ANTONIO BRITO OZUNA	04127081154	\N	2024-01-18 16:25:42	2024-01-18 16:25:42
73	PROFESOR	ASESOR	24906110	PROFESOR ASESOR	04127081154	\N	2024-01-21 01:18:45	2024-01-21 01:18:45
74	Oscarly	Archila	V28218508	Oscarly Archila	\N	\N	2024-01-21 19:52:39	2024-01-21 19:52:39
75	andres	ruiz	V12345678	andres ruiz	\N	\N	2024-01-22 17:28:58	2024-01-22 17:28:58
45	YONAIKER ALFONSO	LINAREZ SANCHEZ	19658653	YONAIKER ALFONSO LINAREZ SANCHEZ	412912785000	57	2023-10-31 15:28:47	2023-10-31 15:28:47
76	YONAIKER ALFONSO	LINAREZ SANCHEZ	196586501	YONAIKER ALFONSO LINAREZ SANCHEZ	4129127852	65	2024-01-22 18:11:16	2024-01-22 18:11:16
77	Ana	pita	V13616369	Ana pita	\N	\N	2024-01-22 18:59:36	2024-01-22 18:59:36
78	ROXLENE FRANSHESCA	VERA HERNÁNDEZ	28143036	ROXLENE FRANSHESCA VERA HERNÁNDEZ	04127081156	70	2024-01-22 19:08:50	2024-01-22 19:08:50
79	YONAIKER ALFONSO	LINAREZ SANCHEZ	19658650	YONAIKER ALFONSO LINAREZ SANCHEZ	04129127852	71	2024-01-22 19:29:51	2024-01-22 19:29:51
80	maikel	ramirez	V12345678	maikel ramirez	\N	\N	2024-01-25 18:34:06	2024-01-25 18:34:06
\.


--
-- Data for Name: profesores_clases_aperturadas; Type: TABLE DATA; Schema: entidades; Owner: postgres
--

COPY entidades.profesores_clases_aperturadas (id, user_id, clase_aperturada_id, tipo_asesor, id_estatus, created_at, updated_at) FROM stdin;
1	68	4	METODOLOGICO	1	2024-01-17 10:48:01	2024-01-17 10:48:01
2	68	4	METODOLOGICO	1	2024-01-17 10:48:01	2024-01-17 10:48:01
3	81	5	METOLÓGICO	1	2024-01-21 01:18:46	2024-01-21 01:18:46
\.


--
-- Data for Name: usuario_datos; Type: TABLE DATA; Schema: entidades; Owner: postgres
--

COPY entidades.usuario_datos (id, id_usuario, cod_carrera, seccion, trayecto, estatus_id, created_at, updated_at) FROM stdin;
40	37	INF	7121	3	1	2023-07-20 16:08:05	2023-07-20 16:08:05
49	57	INF	7122	5	1	2024-01-10 19:12:59	2024-01-10 19:12:59
50	58	INF	7123	1	1	2024-01-10 19:27:55	2024-01-10 19:27:55
52	89	INF	7121	3	1	2024-01-22 19:08:50	2024-01-22 19:08:50
53	90	INF	7122	5	1	2024-01-22 19:29:51	2024-01-22 19:29:51
51	84	INF	7121	3	1	2024-01-22 18:11:16	2024-01-22 18:11:16
\.


--
-- Data for Name: actividades_equipos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.actividades_equipos (id, descripcion, equipo_id, user_id, producto, created_at, updated_at, cod_actividad, actividad_padre, proyecto_id, estatus_id) FROM stdin;
53	Primera actualización de proyecto	46	84	\N	2024-02-09 04:53:35	2024-02-09 04:53:35	4609022024040202	\N	\N	1
54	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:53:35	2024-02-09 04:53:35	4609022024040202	\N	\N	1
55	Primera actualización de proyecto	46	84	\N	2024-02-09 04:55:22	2024-02-09 04:55:22	4609022024040202	\N	\N	1
3	Asignación de proyecto	46	81	\N	2024-02-07 20:34:47	2024-02-07 20:34:47	4607022024200202	\N	2	1
5	Asignación de proyecto2	46	82	\N	2024-02-07 20:34:47	2024-02-07 20:34:47	4607022024200202	3	2	1
4	Asignación de proyecto1	46	83	\N	2024-02-07 20:34:47	2024-02-07 20:34:47	4607022024200202	3	2	1
6	Primera actualización de proyecto	46	84	\N	2024-02-09 03:27:01	2024-02-09 03:27:01	4609022024030202	\N	\N	1
7	Primera actualización de proyecto	46	84	\N	2024-02-09 03:28:10	2024-02-09 03:28:10	4609022024030202	\N	\N	1
8	Actualización de trabajo de investigación	46	84	\N	2024-02-09 03:28:10	2024-02-09 03:28:10	4609022024030202	\N	\N	1
9	Primera actualización de proyecto	46	84	\N	2024-02-09 03:28:22	2024-02-09 03:28:22	4609022024030202	\N	\N	1
10	Actualización de trabajo de investigación	46	84	\N	2024-02-09 03:28:22	2024-02-09 03:28:22	4609022024030202	\N	\N	1
11	Primera actualización de proyecto	46	84	\N	2024-02-09 03:28:25	2024-02-09 03:28:25	4609022024030202	\N	\N	1
12	Actualización de trabajo de investigación	46	84	\N	2024-02-09 03:28:25	2024-02-09 03:28:25	4609022024030202	\N	\N	1
13	Primera actualización de proyecto	46	84	\N	2024-02-09 03:28:37	2024-02-09 03:28:37	4609022024030202	\N	\N	1
14	Actualización de trabajo de investigación	46	84	\N	2024-02-09 03:28:37	2024-02-09 03:28:37	4609022024030202	\N	\N	1
15	Actualización de laminas de presentación	46	84	\N	2024-02-09 03:28:37	2024-02-09 03:28:37	4609022024030202	\N	\N	1
16	Primera actualización de proyecto	46	84	\N	2024-02-09 03:42:23	2024-02-09 03:42:23	4609022024030202	\N	\N	1
17	Actualización de trabajo de investigación	46	84	\N	2024-02-09 03:42:23	2024-02-09 03:42:23	4609022024030202	\N	\N	1
18	Actualización de laminas de presentación	46	84	\N	2024-02-09 03:42:23	2024-02-09 03:42:23	4609022024030202	\N	\N	1
19	Primera actualización de proyecto	46	84	\N	2024-02-09 04:38:57	2024-02-09 04:38:57	4609022024040202	\N	\N	1
20	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:38:57	2024-02-09 04:38:57	4609022024040202	\N	\N	1
21	Primera actualización de proyecto	46	84	\N	2024-02-09 04:39:12	2024-02-09 04:39:12	4609022024040202	\N	\N	1
22	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:39:12	2024-02-09 04:39:12	4609022024040202	\N	\N	1
23	Primera actualización de proyecto	46	84	\N	2024-02-09 04:39:28	2024-02-09 04:39:28	4609022024040202	\N	\N	1
24	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:39:28	2024-02-09 04:39:28	4609022024040202	\N	\N	1
25	Primera actualización de proyecto	46	84	\N	2024-02-09 04:39:33	2024-02-09 04:39:33	4609022024040202	\N	\N	1
26	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:39:33	2024-02-09 04:39:33	4609022024040202	\N	\N	1
27	Primera actualización de proyecto	46	84	\N	2024-02-09 04:39:44	2024-02-09 04:39:44	4609022024040202	\N	\N	1
28	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:39:44	2024-02-09 04:39:44	4609022024040202	\N	\N	1
29	Primera actualización de proyecto	46	84	\N	2024-02-09 04:40:22	2024-02-09 04:40:22	4609022024040202	\N	\N	1
30	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:40:22	2024-02-09 04:40:22	4609022024040202	\N	\N	1
31	Primera actualización de proyecto	46	84	\N	2024-02-09 04:44:18	2024-02-09 04:44:18	4609022024040202	\N	\N	1
32	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:44:18	2024-02-09 04:44:18	4609022024040202	\N	\N	1
33	Primera actualización de proyecto	46	84	\N	2024-02-09 04:45:46	2024-02-09 04:45:46	4609022024040202	\N	\N	1
34	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:45:46	2024-02-09 04:45:46	4609022024040202	\N	\N	1
35	Primera actualización de proyecto	46	84	\N	2024-02-09 04:46:00	2024-02-09 04:46:00	4609022024040202	\N	\N	1
36	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:46:00	2024-02-09 04:46:00	4609022024040202	\N	\N	1
37	Primera actualización de proyecto	46	84	\N	2024-02-09 04:47:02	2024-02-09 04:47:02	4609022024040202	\N	\N	1
38	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:47:02	2024-02-09 04:47:02	4609022024040202	\N	\N	1
39	Primera actualización de proyecto	46	84	\N	2024-02-09 04:47:49	2024-02-09 04:47:49	4609022024040202	\N	\N	1
40	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:47:49	2024-02-09 04:47:49	4609022024040202	\N	\N	1
41	Primera actualización de proyecto	46	84	\N	2024-02-09 04:48:06	2024-02-09 04:48:06	4609022024040202	\N	\N	1
42	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:48:06	2024-02-09 04:48:06	4609022024040202	\N	\N	1
43	Primera actualización de proyecto	46	84	\N	2024-02-09 04:48:15	2024-02-09 04:48:15	4609022024040202	\N	\N	1
44	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:48:15	2024-02-09 04:48:15	4609022024040202	\N	\N	1
45	Primera actualización de proyecto	46	84	\N	2024-02-09 04:48:42	2024-02-09 04:48:42	4609022024040202	\N	\N	1
46	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:48:42	2024-02-09 04:48:42	4609022024040202	\N	\N	1
47	Primera actualización de proyecto	46	84	\N	2024-02-09 04:51:31	2024-02-09 04:51:31	4609022024040202	\N	\N	1
48	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:51:31	2024-02-09 04:51:31	4609022024040202	\N	\N	1
49	Primera actualización de proyecto	46	84	\N	2024-02-09 04:51:38	2024-02-09 04:51:38	4609022024040202	\N	\N	1
50	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:51:38	2024-02-09 04:51:38	4609022024040202	\N	\N	1
51	Primera actualización de proyecto	46	84	\N	2024-02-09 04:53:00	2024-02-09 04:53:00	4609022024040202	\N	\N	1
52	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:53:00	2024-02-09 04:53:00	4609022024040202	\N	\N	1
56	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:55:22	2024-02-09 04:55:22	4609022024040202	\N	\N	1
57	Primera actualización de proyecto	46	84	\N	2024-02-09 04:55:44	2024-02-09 04:55:44	4609022024040202	\N	\N	1
58	Actualización de trabajo de investigación	46	84	\N	2024-02-09 04:55:44	2024-02-09 04:55:44	4609022024040202	\N	\N	1
\.


--
-- Data for Name: avances_equipos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.avances_equipos (id, equipo_id, item_evaluado_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: correcciones; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.correcciones (id, actividad_id, user_id, comentario, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: equipos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.equipos (id, trayecto, carrera, seccion, proyecto_id, id_estatus, user_id, created_at, updated_at) FROM stdin;
4	3	INF	7121	\N	1	37	2023-12-22 13:56:35	2023-12-30 19:36:28
44	5	INF	7122	\N	1	57	2024-01-15 01:10:53	2024-01-15 14:57:12
46	3	INF	7121	2	6	84	2024-01-22 18:21:35	2024-02-07 20:34:47
\.


--
-- Data for Name: integrantes; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.integrantes (id, equipo_id, user_id, scrum_master, id_estatus, created_at, updated_at) FROM stdin;
4	4	37	t	1	2023-12-22 13:56:35	2023-12-22 13:56:35
53	46	84	t	1	2024-01-22 18:21:35	2024-01-22 18:21:35
5	4	53	f	1	2023-12-30 19:36:28	2023-12-31 09:35:44
45	44	57	t	1	2024-01-15 01:10:53	2024-01-15 01:10:53
56	46	89	f	1	2024-02-06 16:01:25	2024-02-06 16:01:25
\.


--
-- Data for Name: necesidades; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.necesidades (id, user_id, necesidad, cod_necesidad, id_estatus, direccion_id, created_at, updated_at, id_motivo, evaluado_por, fecha_verificacion) FROM stdin;
1	2	SISTEMA DE NÓMINA	1021608	3	1	2023-08-10 16:12:19	2023-08-11 12:15:48	1	\N	\N
4	2	DESDE EL FRONT	212140831	4	43	2023-08-21 14:59:31	2023-08-22 12:10:42	\N	\N	\N
3	2	SISTEMA DE CONTROL DE ESTUDIO	212140832	4	1	2023-08-21 14:21:32	2023-10-23 12:29:25	\N	\N	\N
6	2	SISTEMA DE CONTROL DE ESTUDIO3	092091036	3	1	2023-10-09 09:10:36	2023-11-06 12:28:33	1	\N	\N
5	2	SISTEMA DE CONTROL DE ESTUDIO2	092091049	5	1	2023-10-09 09:09:49	2023-11-13 17:16:58	\N	\N	\N
7	82	Administracion de cuentas y gestion de libros contables	2182200131	5	63	2024-01-21 20:36:31	2024-01-22 00:03:20	\N	\N	\N
8	82	Mantenimiento de maquinaria de invernadero	2282030148	5	63	2024-01-22 03:04:48	2024-01-22 03:11:15	\N	\N	\N
9	83	limpieza de maquina	2283170110	5	64	2024-01-22 17:32:10	2024-01-22 17:48:15	\N	\N	\N
10	83	problemas de maquinas	2583180159	5	64	2024-01-25 18:35:59	2024-01-25 18:40:22	\N	\N	\N
\.


--
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.notificaciones (id, descripcion, user_id, equipo_id, leido, created_at, updated_at) FROM stdin;
1	ROXLENE VERA solicitó unirse al equipo a: YONAIKER LINAREZ	37	4	f	2023-12-25 19:07:48	2023-12-25 19:07:48
2	ROXLENE VERA solicitó unirse al equipo a: YONAIKER LINAREZ	37	4	f	2023-12-26 00:00:47	2023-12-26 00:00:47
3	ROXLENE VERA solicitó unirse al equipo a: YONAIKER LINAREZ	37	4	f	2023-12-26 00:25:27	2023-12-26 00:25:27
4	ROXLENE VERA solicitó unirse al equipo a: YONAIKER LINAREZ	37	4	f	2023-12-26 00:38:24	2023-12-26 00:38:24
5	ROXLENE VERA solicitó unirse al equipo a: YONAIKER LINAREZ	37	4	f	2023-12-26 00:40:23	2023-12-26 00:40:23
6	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	37	4	f	2023-12-30 16:07:31	2023-12-30 16:07:31
7	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	37	4	f	2023-12-30 16:12:02	2023-12-30 16:12:02
8	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	37	4	f	2023-12-30 16:17:20	2023-12-30 16:17:20
9	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	37	4	f	2023-12-30 16:17:41	2023-12-30 16:17:41
10	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	37	4	f	2023-12-30 16:18:44	2023-12-30 16:18:44
11	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	37	4	f	2023-12-30 16:21:27	2023-12-30 16:21:27
12	ROXLENE VERA ACEPTÓ su solicitud para unirse al equipo.	37	4	f	2023-12-30 19:36:28	2023-12-30 19:36:28
13	Se ha solicitado desincorporar del equipo a: YONAIKER LINAREZ	37	4	f	2023-12-30 19:50:01	2023-12-30 19:50:01
14	Se ha solicitado desincorporar del equipo a: YONAIKER LINAREZ	37	4	f	2023-12-30 20:01:11	2023-12-30 20:01:11
15	El asesor: ROXLENE VERA aceptó su solicitud de desincorporación.	37	4	f	2023-12-31 09:35:45	2023-12-31 09:35:45
16	Se ha solicitado desincorporar del equipo a: YONAIKER LINAREZ	37	4	f	2023-12-31 09:37:54	2023-12-31 09:37:54
17	El asesor: ROXLENE VERA rechazó su solicitud de desincorporación.	37	4	f	2023-12-31 09:38:25	2023-12-31 09:38:25
18	El asesor: ROXLENE VERA rechazó su solicitud de desincorporación.	37	4	f	2023-12-31 09:41:07	2023-12-31 09:41:07
19	El asesor: ROXLENE VERA rechazó su solicitud de desincorporación.	37	4	f	2023-12-31 09:41:38	2023-12-31 09:41:38
26	Eliminación de equipo	37	\N	f	2024-01-10 19:59:10	2024-01-10 19:59:10
27	Creación de equipo	57	\N	f	2024-01-10 20:01:04	2024-01-10 20:01:04
28	Eliminación de equipo	57	\N	f	2024-01-10 20:01:33	2024-01-10 20:01:33
29	Creación de equipo	57	\N	f	2024-01-10 20:02:22	2024-01-10 20:02:22
30	Eliminación de equipo	57	\N	f	2024-01-10 20:02:24	2024-01-10 20:02:24
31	Creación de equipo	57	\N	f	2024-01-10 20:03:48	2024-01-10 20:03:48
32	Eliminación de equipo	57	\N	f	2024-01-10 20:04:45	2024-01-10 20:04:45
33	Creación de equipo	57	\N	f	2024-01-10 20:06:23	2024-01-10 20:06:23
34	Eliminación de equipo	57	\N	f	2024-01-10 20:06:28	2024-01-10 20:06:28
35	Creación de equipo	57	\N	f	2024-01-10 20:07:55	2024-01-10 20:07:55
36	Eliminación de equipo	57	\N	f	2024-01-10 20:07:57	2024-01-10 20:07:57
37	Creación de equipo	57	\N	f	2024-01-10 20:08:22	2024-01-10 20:08:22
38	Eliminación de equipo	57	\N	f	2024-01-10 20:08:26	2024-01-10 20:08:26
39	Creación de equipo	57	\N	f	2024-01-10 20:09:21	2024-01-10 20:09:21
40	Eliminación de equipo	57	\N	f	2024-01-10 20:09:24	2024-01-10 20:09:24
41	Creación de equipo	57	\N	f	2024-01-10 20:09:40	2024-01-10 20:09:40
42	Eliminación de equipo	57	\N	f	2024-01-10 20:09:49	2024-01-10 20:09:49
43	Creación de equipo	57	\N	f	2024-01-10 20:10:15	2024-01-10 20:10:15
44	Eliminación de equipo	57	\N	f	2024-01-10 20:10:17	2024-01-10 20:10:17
45	Creación de equipo	57	\N	f	2024-01-10 20:10:23	2024-01-10 20:10:23
46	Eliminación de equipo	57	\N	f	2024-01-10 20:10:30	2024-01-10 20:10:30
47	Creación de equipo	57	\N	f	2024-01-10 20:10:58	2024-01-10 20:10:58
48	Eliminación de equipo	57	\N	f	2024-01-10 20:11:00	2024-01-10 20:11:00
49	Creación de equipo	57	\N	f	2024-01-10 20:26:08	2024-01-10 20:26:08
50	Eliminación de equipo	57	\N	f	2024-01-10 20:26:29	2024-01-10 20:26:29
51	Creación de equipo	57	\N	f	2024-01-10 20:26:40	2024-01-10 20:26:40
52	Creación de equipo	58	\N	f	2024-01-13 20:49:22	2024-01-13 20:49:22
53	Eliminación de equipo	58	\N	f	2024-01-13 20:49:26	2024-01-13 20:49:26
54	Creación de equipo	58	\N	f	2024-01-13 20:50:13	2024-01-13 20:50:13
55	Eliminación de equipo	58	\N	f	2024-01-13 20:50:15	2024-01-13 20:50:15
56	Creación de equipo	58	\N	f	2024-01-13 20:51:13	2024-01-13 20:51:13
57	Eliminación de equipo	58	\N	f	2024-01-13 20:51:15	2024-01-13 20:51:15
58	Creación de equipo	58	\N	f	2024-01-13 20:51:44	2024-01-13 20:51:44
59	Eliminación de equipo	58	\N	f	2024-01-13 20:51:59	2024-01-13 20:51:59
60	Creación de equipo	58	\N	f	2024-01-13 20:52:01	2024-01-13 20:52:01
61	Eliminación de equipo	58	\N	f	2024-01-13 20:52:17	2024-01-13 20:52:17
62	Creación de equipo	58	\N	f	2024-01-13 20:52:29	2024-01-13 20:52:29
63	Eliminación de equipo	58	\N	f	2024-01-13 20:52:35	2024-01-13 20:52:35
64	Creación de equipo	58	\N	f	2024-01-13 20:52:43	2024-01-13 20:52:43
65	Eliminación de equipo	58	\N	f	2024-01-13 20:53:03	2024-01-13 20:53:03
66	Creación de equipo	58	\N	f	2024-01-13 20:53:06	2024-01-13 20:53:06
67	Eliminación de equipo	58	\N	f	2024-01-13 20:53:23	2024-01-13 20:53:23
68	Creación de equipo	58	\N	f	2024-01-13 20:53:28	2024-01-13 20:53:28
69	Eliminación de equipo	58	\N	f	2024-01-13 21:38:52	2024-01-13 21:38:52
70	Creación de equipo	58	\N	f	2024-01-13 21:38:58	2024-01-13 21:38:58
71	Eliminación de equipo	58	\N	f	2024-01-13 21:39:04	2024-01-13 21:39:04
72	Creación de equipo	58	\N	f	2024-01-13 21:39:30	2024-01-13 21:39:30
73	Eliminación de equipo	58	\N	f	2024-01-13 21:43:23	2024-01-13 21:43:23
74	Creación de equipo	58	\N	f	2024-01-13 21:43:26	2024-01-13 21:43:26
75	Eliminación de equipo	58	\N	f	2024-01-13 21:45:08	2024-01-13 21:45:08
76	Creación de equipo	58	\N	f	2024-01-13 21:46:25	2024-01-13 21:46:25
77	Eliminación de equipo	58	\N	f	2024-01-13 21:46:35	2024-01-13 21:46:35
78	Creación de equipo	58	\N	f	2024-01-13 21:49:11	2024-01-13 21:49:11
79	Eliminación de equipo	58	\N	f	2024-01-13 21:51:24	2024-01-13 21:51:24
80	Creación de equipo	58	\N	f	2024-01-13 21:51:51	2024-01-13 21:51:51
81	Eliminación de equipo	58	\N	f	2024-01-13 21:59:41	2024-01-13 21:59:41
82	Creación de equipo	58	\N	f	2024-01-13 21:59:44	2024-01-13 21:59:44
83	Eliminación de equipo	58	\N	f	2024-01-13 22:00:59	2024-01-13 22:00:59
84	Creación de equipo	58	\N	f	2024-01-13 22:01:01	2024-01-13 22:01:01
85	Eliminación de equipo	57	\N	f	2024-01-14 11:58:03	2024-01-14 11:58:03
86	Creación de equipo	57	\N	f	2024-01-14 11:58:05	2024-01-14 11:58:05
87	Eliminación de equipo	58	\N	f	2024-01-14 18:48:29	2024-01-14 18:48:29
25	Creación de equipo	57	\N	f	2024-01-10 19:55:48	2024-01-10 19:55:48
138	Eliminación de equipo	84	\N	f	2024-01-22 18:21:26	2024-01-22 18:21:26
139	Creación de equipo	84	\N	f	2024-01-22 18:21:35	2024-01-22 18:21:35
140	Se ha solicitado a: PAULA GALLARDO unirse al equipo	84	46	f	2024-01-22 18:21:54	2024-01-22 18:21:54
141	Se ha solicitado a: PAULA GALLARDO unirse al equipo	84	46	f	2024-01-22 18:28:15	2024-01-22 18:28:15
111	Eliminación de equipo	57	\N	f	2024-01-15 00:54:07	2024-01-15 00:54:07
112	Creación de equipo	57	\N	f	2024-01-15 01:09:02	2024-01-15 01:09:02
113	Eliminación de equipo	57	\N	f	2024-01-15 01:09:40	2024-01-15 01:09:40
114	Creación de equipo	57	\N	f	2024-01-15 01:09:53	2024-01-15 01:09:53
115	Eliminación de equipo	57	\N	f	2024-01-15 01:10:34	2024-01-15 01:10:34
116	Creación de equipo	57	\N	f	2024-01-15 01:10:53	2024-01-15 01:10:53
117	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-15 01:11:04	2024-01-15 01:11:04
118	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	44	f	2024-01-15 14:57:12	2024-01-15 14:57:12
119	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	44	f	2024-01-15 15:02:18	2024-01-15 15:02:18
120	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	44	f	2024-01-15 15:09:29	2024-01-15 15:09:29
121	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	44	f	2024-01-15 15:18:15	2024-01-15 15:18:15
122	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-15 17:44:57	2024-01-15 17:44:57
123	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-15 17:46:00	2024-01-15 17:46:00
124	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-15 17:46:47	2024-01-15 17:46:47
125	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-15 17:48:18	2024-01-15 17:48:18
126	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-15 17:49:47	2024-01-15 17:49:47
127	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	44	f	2024-01-15 17:50:31	2024-01-15 17:50:31
128	Se ha solicitado a: PAULA GALLARDO unirse al equipo	57	44	f	2024-01-19 17:40:54	2024-01-19 17:40:54
129	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	44	f	2024-01-19 17:42:19	2024-01-19 17:42:19
130	Se creado un proyecto en base a la necesidad 2182200131	60	\N	f	2024-01-22 00:01:32	2024-01-22 00:01:32
131	Se creado un proyecto en base a la necesidad 2182200131	82	\N	f	2024-01-22 00:03:20	2024-01-22 00:03:20
132	Se creado un proyecto en base a la necesidad 2182200131	60	\N	f	2024-01-22 00:03:20	2024-01-22 00:03:20
133	Se creado un proyecto en base a su necesidad 2282030148	82	\N	f	2024-01-22 03:11:15	2024-01-22 03:11:15
134	Se creado un proyecto en base a la necesidad 2282030148	2	\N	f	2024-01-22 03:11:15	2024-01-22 03:11:15
135	Se creado un proyecto en base a su necesidad 2283170110	83	\N	f	2024-01-22 17:48:15	2024-01-22 17:48:15
136	Se creado un proyecto en base a la necesidad 2283170110	2	\N	f	2024-01-22 17:48:15	2024-01-22 17:48:15
137	Creación de equipo	84	\N	f	2024-01-22 18:20:49	2024-01-22 18:20:49
142	Se ha solicitado a: PAULA GALLARDO unirse al equipo	84	46	f	2024-01-22 18:29:00	2024-01-22 18:29:00
143	Se ha solicitado a: PAULA GALLARDO unirse al equipo	84	46	f	2024-01-22 18:29:19	2024-01-22 18:29:19
144	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	46	f	2024-01-22 18:30:36	2024-01-22 18:30:36
145	Se ha solicitado a: PAULA GALLARDO unirse al equipo	84	46	f	2024-01-22 18:32:21	2024-01-22 18:32:21
146	PAULA GALLARDO aceptó su solicitud para unirse al equipo.	58	46	f	2024-01-22 18:32:46	2024-01-22 18:32:46
148	¡🎉Bienvenido al sistema!🎉	88	\N	f	2024-01-22 19:07:27	2024-01-22 19:07:27
149	¡🎉Bienvenido al sistema!🎉	89	\N	f	2024-01-22 19:08:50	2024-01-22 19:08:50
150	¡🎉Bienvenido al sistema!🎉	90	\N	f	2024-01-22 19:29:51	2024-01-22 19:29:51
151	¡🎉Bienvenido al sistema!🎉	91	\N	f	2024-01-25 18:34:07	2024-01-25 18:34:07
152	Se creado un proyecto en base a su necesidad 2583180159	83	\N	f	2024-01-25 18:40:22	2024-01-25 18:40:22
153	Se creado un proyecto en base a la necesidad 2583180159	2	\N	f	2024-01-25 18:40:22	2024-01-25 18:40:22
154	Se ha solicitado a: YONAIKER LINAREZ unirse al equipo	57	44	f	2024-01-25 18:44:51	2024-01-25 18:44:51
155	Asignación de proyecto porcesada	81	46	f	2024-02-05 15:34:49	2024-02-05 15:34:49
156	Se ha solicitado a: ROXLENE VERA unirse al equipo	84	46	f	2024-02-06 16:00:48	2024-02-06 16:00:48
157	ROXLENE VERA aceptó su solicitud para unirse al equipo.	89	46	f	2024-02-06 16:01:25	2024-02-06 16:01:25
158	Asignación de proyecto procesada	81	46	f	2024-02-06 16:09:47	2024-02-06 16:09:47
159	Asignación de proyecto procesada	81	46	f	2024-02-07 19:41:41	2024-02-07 19:41:41
160	Asignación de proyecto procesada	81	46	f	2024-02-07 19:45:44	2024-02-07 19:45:44
161	Asignación de proyecto procesada	81	46	f	2024-02-07 20:34:47	2024-02-07 20:34:47
\.


--
-- Data for Name: postulaciones; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.postulaciones (id, proyecto_id, equipo_id, id_estatus, created_at, updated_at) FROM stdin;
8	2	44	1	2024-01-15 17:52:55	2024-01-15 17:52:55
9	3	44	1	2024-01-19 17:42:53	2024-01-19 17:42:53
10	5	44	1	2024-01-22 00:40:02	2024-01-22 00:40:02
11	4	44	1	2024-01-22 02:58:13	2024-01-22 02:58:13
12	5	46	1	2024-01-22 18:35:02	2024-01-22 18:35:02
13	1	46	1	2024-02-05 14:38:38	2024-02-05 14:38:38
14	2	46	1	2024-02-06 16:03:39	2024-02-06 16:03:39
\.


--
-- Data for Name: proyecto_clasificado; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.proyecto_clasificado (id, proyectos_id, clasificacion_id) FROM stdin;
1	1	1
2	1	1
3	2	2
4	2	3
5	3	1
6	3	1
7	4	2
8	4	3
9	5	2
10	5	3
15	10	5
16	11	17
17	12	1
18	13	1
\.


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.proyectos (id, necesidad_id, especificacion, id_estatus, created_at, updated_at, user_id) FROM stdin;
1	5	\N	8	2023-11-13 17:16:58	2023-11-13 17:16:58	2
3	5	\N	8	2023-11-13 17:24:18	2023-11-13 17:24:18	2
4	5	\N	8	2023-11-13 17:24:53	2023-11-13 17:24:53	2
10	7	\N	8	2024-01-22 00:03:20	2024-01-22 00:03:20	60
11	8	\N	8	2024-01-22 03:11:15	2024-01-22 03:11:15	2
12	9	\N	8	2024-01-22 17:48:15	2024-01-22 17:48:15	2
13	10	\N	8	2024-01-25 18:40:22	2024-01-25 18:40:22	2
5	5	\N	8	2023-11-13 17:27:29	2024-02-05 15:34:49	2
2	5	\N	6	2023-11-13 17:23:13	2024-02-07 20:34:47	2
\.


--
-- Data for Name: solicitudes; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.solicitudes (id, solicitante_id, equipo_id, user_id, id_estatus, integracion, integrante_id_desincorporar, motivo_desincorporacion, motivo_denegacion, created_at, updated_at) FROM stdin;
1	4	4	\N	12	f	5	No trabaja	A estas alturas no se puede desincorporar	2023-12-31 09:37:54	2023-12-31 09:41:07
37	45	44	90	11	t	\N	\N	\N	2024-01-25 18:44:51	2024-01-25 18:44:51
38	53	46	89	13	t	\N	\N	\N	2024-02-06 16:00:48	2024-02-06 16:01:25
\.


--
-- Data for Name: subida_archivos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.subida_archivos (id, proyecto_id, equipo_id, actividad_id, investigacion, presentacion, producto, portafolio, created_at, updated_at, titulo, edicion_trabajo, edicion_laminas, edicion_producto, edicion_portafolio, correccion_trabajo, correccion_laminas, correccion_producto, correccion_portafolio) FROM stdin;
4	2	46	58	equipos/462/investigacion.pdf		\N	\N	2024-02-09 03:28:10	2024-02-09 04:55:44	nuevo proyecto	25	2	0	0	0	0	0	0
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
83	2023_07_25_145056_create_administrativo_items_table	3
84	2023_07_14_163625_create_administrativo_motivo_denegacion_table	4
85	2023_12_18_124613_create_equipos_table	5
86	2023_12_18_130239_create_proyectos_integrantes_table	6
87	2023_12_18_131412_create_proyectos_avances_equipos_table	7
89	2023_12_18_133024_create_proyectos_correcciones_table	9
37	2019_12_14_000001_create_personal_access_tokens_table	1
38	2023_05_19_144152_create_schema	1
39	2023_05_19_150046_create_estatus_table	1
40	2023_05_19_150646_create_administrativo_estado_table	1
41	2023_05_19_150657_create_administrativo_municipio_table	1
42	2023_05_19_150705_create_administrativo_parroquia_table	1
43	2023_05_19_150719_create_administrativo_direccion_table	1
44	2023_07_14_163617_create_admistrativo_tipo_usuario_table	1
45	2023_07_14_163618_create_entidades_persona_table	1
46	2023_07_14_163619_create_entidades_comunidad_table	1
47	2023_07_14_163620_create_seguridad_usuarios_table	1
48	2023_07_14_163621_create_entidades_estudante_datos_table	1
49	2023_07_14_163622_create_seguridad_auditoria_table	1
50	2023_07_14_163623_create_seguridad_password_resets_table	1
51	2023_07_14_163624_create_permission_tables	1
77	2023_07_25_103144_create_administrativo_clasificacion_proyectos_table	2
78	2023_07_25_103147_create_proyectos_necesidades_table	2
79	2023_07_25_103240_create_proyectos_proyectos_table	2
80	2023_07_25_103241_create_proyectos_proyecto_clasificado_table	2
81	2023_07_25_104202_create_seguridad_configuraciones_table	2
82	2023_07_25_145057_create_administrativo_items_evaluados_table	2
103	2023_12_22_102739_create_notificaciones_table	11
111	2023_12_22_102327_create_solicitudes_table	12
112	2023_12_31_095619_create_administrativo_componentes_proyectos_table	13
115	2023_12_31_120447_create_administrativo_clasificacion_componentes_table	14
116	2024_01_14_213608_create_seguridad_vistas_notificaciones_table	15
117	2024_01_15_140231_create_seguridad_vistas_solicitudes_table	16
118	2024_01_15_152854_create_proyectos_postulaciones_table	17
120	2024_01_17_093055_create_entidades_aperturas_table	18
121	2024_01_17_093303_create_entidades_profesores_clases_aperturadas_table	18
88	2023_12_18_131852_create_proyectos_actividades_equipos_table	19
130	2023_12_18_133743_create_proyectos_subida_archivos_table	20
131	2024_02_07_192859_add_cod_actividad_to_proyectos_actividades_equipos_table	21
132	2024_02_07_193242_add_titulo_to_proyectos_subida_archivos_table	21
133	2024_02_09_011228_add_columns_to_proyectos_subidas_archivos	22
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.auditoria (id, actividad, direccion_ip, id_usuario, accion, created_at, updated_at) FROM stdin;
2	La comunidad: UNIDOS CONTRA EL CANCER VENEZUELA2 se acaba de registrar	\N	88	INSERT seguridad.usuarios	2024-01-22 19:07:27	2024-01-22 19:07:27
3	El estudiante: ROXLENE FRANSHESCA VERA HERNÁNDEZ se acaba de registrar	\N	89	INSERT seguridad.usuarios	2024-01-22 19:08:50	2024-01-22 19:08:50
4	El estudiante: YONAIKER ALFONSO LINAREZ SANCHEZ se acaba de registrar	\N	90	INSERT seguridad.usuarios	2024-01-22 19:29:51	2024-01-22 19:29:51
5	EURO ALEJANDRO GONZALEZ PEÑA consultó los disponibles para solictar integrantes para el equipo	\N	57	SELECT usuarios	2024-01-23 10:47:43	2024-01-23 10:47:43
6	EURO ALEJANDRO GONZALEZ PEÑA consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	57	SELECT usuarios	2024-01-23 10:48:44	2024-01-23 10:48:44
7	EURO ALEJANDRO GONZALEZ PEÑA consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	57	SELECT usuarios	2024-01-23 16:09:41	2024-01-23 16:09:41
8	EURO ALEJANDRO GONZALEZ PEÑA consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	57	SELECT usuarios	2024-01-23 16:11:57	2024-01-23 16:11:57
9	La comunidad: liceo muñoz tebar se acaba de registrar	\N	91	INSERT seguridad.usuarios	2024-01-25 18:34:07	2024-01-25 18:34:07
10	YONAIKER ALFONSO LINAREZ SANCHEZ consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	90	SELECT usuarios	2024-01-25 18:42:50	2024-01-25 18:42:50
11	YONAIKER ALFONSO LINAREZ SANCHEZ consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	90	SELECT usuarios	2024-01-25 18:43:12	2024-01-25 18:43:12
12	YONAIKER ALFONSO LINAREZ SANCHEZ consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	90	SELECT usuarios	2024-01-25 18:43:12	2024-01-25 18:43:12
13	YONAIKER ALFONSO LINAREZ SANCHEZ consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	90	SELECT usuarios	2024-01-25 18:43:26	2024-01-25 18:43:26
14	YONAIKER ALFONSO LINAREZ SANCHEZ consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	90	SELECT usuarios	2024-01-25 18:43:52	2024-01-25 18:43:52
15	EURO ALEJANDRO GONZALEZ PEÑA consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	57	SELECT usuarios	2024-01-25 18:44:42	2024-01-25 18:44:42
16	YONAIKER ALFONSO LINAREZ SANCHEZ consultó los estudiantes disponibles para solictar integrantes para el equipo	\N	84	SELECT usuarios	2024-02-05 13:58:08	2024-02-05 13:58:08
17	Consulta de estudiantes disponibles para solicitar integrantes para el equipo	\N	84	SELECT usuarios	2024-02-06 15:34:29	2024-02-06 15:34:29
18	Consulta de estudiantes disponibles para solicitar integrantes para el equipo	\N	84	SELECT usuarios	2024-02-06 15:44:27	2024-02-06 15:44:27
19	Consulta de estudiantes disponibles para solicitar integrantes para el equipo	\N	84	SELECT usuarios	2024-02-06 16:00:45	2024-02-06 16:00:45
\.


--
-- Data for Name: configuraciones; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.configuraciones (id, descripcion, status) FROM stdin;
1	MensajeriaSMS	t
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.model_has_roles (role_id, model_type, model_id) FROM stdin;
14	App\\Models\\User	60
13	App\\Models\\User	61
13	App\\Models\\User	62
13	App\\Models\\User	63
13	App\\Models\\User	64
13	App\\Models\\User	65
13	App\\Models\\User	66
13	App\\Models\\User	67
13	App\\Models\\User	68
14	App\\Models\\User	80
13	App\\Models\\User	81
10	App\\Models\\User	2
11	App\\Models\\User	57
12	App\\Models\\User	82
12	App\\Models\\User	83
11	App\\Models\\User	84
11	App\\Models\\User	58
12	App\\Models\\User	85
12	App\\Models\\User	86
12	App\\Models\\User	87
12	App\\Models\\User	88
11	App\\Models\\User	90
12	App\\Models\\User	91
11	App\\Models\\User	37
11	App\\Models\\User	89
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.permissions (id, name, guard_name, created_at, updated_at, estatus_id, usuario_id) FROM stdin;
18	Item_evaluativos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
19	Motivos_denegacion	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
20	Banco_necesidades	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
21	Banco_proyectos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
22	Lista_equipos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
23	Biblioteca_medios	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
24	Lista_proyectos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
25	Generacion_equipos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
26	Historico_equipos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
27	Mi_proyecto	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
28	Mis_necesidades	api	2024-01-15 18:54:26	2024-01-15 18:54:26	1	\N
29	Usuarios	api	2024-01-15 18:54:26	2024-01-15 18:54:26	1	\N
30	Roles	api	2024-01-15 18:54:26	2024-01-15 18:54:26	1	\N
31	Auditoria	api	2024-01-15 18:54:26	2024-01-15 18:54:26	1	\N
17	Administrativo	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
35	Asignacion_proyectos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
33	Inspeccion_equipos	api	2024-01-15 18:54:25	2024-01-15 18:54:25	1	\N
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.role_has_permissions (permission_id, role_id) FROM stdin;
17	10
17	14
18	10
18	14
19	10
19	14
20	10
20	14
21	10
21	14
21	13
21	11
22	10
22	13
22	14
23	10
23	11
23	12
23	13
23	14
24	10
24	12
24	13
25	11
26	10
26	11
27	10
27	11
28	12
29	10
30	10
31	10
33	10
35	13
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.roles (id, name, guard_name, estatus_id, usuario_id, created_at, updated_at) FROM stdin;
10	SUPER_ADMINISTRADOR	api	1	\N	2024-01-15 18:54:25	2024-01-15 18:54:25
13	ASESOR	api	1	\N	2024-01-15 18:54:25	2024-01-15 18:54:25
14	ADMINISTRADOR_PROYECTO	api	1	\N	2024-01-15 18:54:25	2024-01-15 18:54:25
11	ESTUDIANTE	api	2	\N	2024-01-15 18:54:25	2024-01-15 18:54:25
12	COMUNIDAD	api	2	\N	2024-01-15 18:54:25	2024-01-15 18:54:25
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.usuarios (id, id_persona, id_tipo_usuario, email, password, email_verified_at, phone_verified_at, password_changed, id_comunidad, id_estatus, created_at, updated_at, foto_url) FROM stdin;
49	41	2	espinoza@gmail.com	$2y$10$o10XqGqnmemzMwji4eZVp.5rAw81QKp9unTFi3MwrMLRHvpaxWuUO	2023-10-31 13:19:06	2023-10-31 13:19:06	\N	14	1	2023-10-31 12:03:50	2023-10-31 13:19:06	\N
37	32	1	roxlenevera362c@gmail.com	$2y$10$FS2ekYESnhXvpSoouarUguy1FaUvhBl96Gozx62Yimm.RdNp/sSx2	\N	\N	\N	\N	1	2023-07-20 16:08:05	2023-07-20 16:08:05	\N
88	32	2	roxlenevera362c2@hotmail.com	$2y$10$zX7HvScs00BksMEqZwAYiucO8iukABBwEACOpP6hRVw5weGCmxngy	\N	\N	\N	22	1	2024-01-22 19:07:26	2024-01-22 19:07:26	\N
57	49	1	alejandro@gmail.com	$2y$10$6OPXNWYUq9Q6aNNmwOcIhO08PQJyYP9eALD1q6/NN1jQzaNTPtNsy	2024-01-10 19:13:58	2024-01-10 19:13:58	\N	\N	1	2024-01-10 19:12:59	2024-01-10 19:13:58	\N
58	50	1	paula@gmail.com	$2y$10$v7YvtUB6A02LmcypcgCVjOLgCst1suljsCD/lVtd73VEsrnQSSuT2	2024-01-10 19:28:57	2024-01-10 19:28:57	\N	\N	1	2024-01-10 19:27:55	2024-01-10 19:28:57	\N
60	52	3	laprofe@gmail.com	$2y$10$uLfbfWkaqc.n0JUuE.z6qebs0DdSvnzmwkpGAfEIJmkw.SwxBZFDq	\N	\N	\N	\N	1	2024-01-17 10:32:35	2024-01-17 10:32:35	\N
68	60	3	roxana@gmail.com	$2y$10$lugaHLt/7xY7RjjPRgM1rOtff0509tIuWaIAPJxa01wbXPeL2.HyC	\N	\N	\N	\N	1	2024-01-17 10:48:01	2024-01-17 10:48:01	\N
55	47	2	rafth4@gmail.com	$2y$10$8b54LlKmC4o1IOUGCwkU3e5QY3Gi1xESsXnWttlHSGw3zPPaLbxzS	2023-10-31 15:53:04	2023-10-31 15:53:04	\N	16	1	2023-10-31 15:52:09	2023-10-31 15:53:04	\N
80	72	3	rafth43@gmail.com	$2y$10$L9qkNen1Ym/qbw1.fKgNQOqR7Xuy9s5agVWuch4KXpdJ1B.Eq2Hoq	\N	\N	\N	\N	1	2024-01-18 16:25:42	2024-01-21 03:01:41	perfiles/perfil(24906477).png
90	79	1	yonaiker@gmail.com	$2y$10$MvF7cz0BztmH3.lCGT6fJ.Ww5NpXG1AJE2rFFSbwq9tqhzxOSn9iG	2024-01-22 19:30:38	2024-01-22 19:30:38	\N	\N	1	2024-01-22 19:29:51	2024-01-22 19:30:38	\N
91	80	2	cuminidad@gmail.com	$2y$10$uXQd1.05jHEyzt96lwliAen9YttEHlEN0.sMS77RdtheURTdyNRqe	\N	\N	\N	23	1	2024-01-25 18:34:07	2024-01-25 18:34:07	\N
2	1	3	admin@admin.com	$2y$10$FS2ekYESnhXvpSoouarUguy1FaUvhBl96Gozx62Yimm.RdNp/sSx2	2023-10-25 15:06:39	2023-10-25 15:06:39	\N	1	1	2023-07-14 18:36:48	2024-01-21 20:12:53	perfiles/perfil(12345654).png
82	74	2	oscarly@gmail.com	$2y$10$iEkh8yBIm3ZeGYamAdIC6.B.g/xhsf5JLI9NOq2uWNT7ZtPFWdP32	2024-01-21 20:17:31	2024-01-21 20:17:31	\N	17	1	2024-01-21 19:52:39	2024-01-21 21:22:22	perfiles/perfil(V28218508).jpg
83	75	2	comunidad@gmail.com	$2y$10$jCPb5yPWmmx34yNHY6xFfO1N5JqzxBory.HqBbTp1I1u.DCkhcJO2	2024-01-22 17:30:30	2024-01-22 17:30:30	\N	18	1	2024-01-22 17:28:58	2024-01-22 17:36:00	perfiles/perfil(V12345678).png
53	45	1	yonaikerandroid2@gmail.com	$2y$10$YNokRQ6ahKHF0E4b45G09uSRL9T6oOZ177cG0S24wz0N4WiGWxwEi	2023-10-31 15:30:28	2023-10-31 15:30:28	\N	\N	1	2023-10-31 15:28:48	2023-10-31 15:30:28	\N
84	76	1	yonaiker3@gmail.com	$2y$10$OwO7CScFLC1kN.lMQsOc3elgZ14DFYFKaW/YvxUSLQTapeIBMOrG6	2024-01-22 18:12:35	2024-01-22 18:12:35	\N	\N	1	2024-01-22 18:11:16	2024-01-22 18:12:35	\N
85	77	2	liceo@gmail.com	$2y$10$BLwbbuZzhg.rSWKtK59BbushBHAw/jLhUMQXMb0oJ6nDwdOrYq2H.	\N	\N	\N	19	1	2024-01-22 18:59:36	2024-01-22 18:59:36	\N
81	73	3	asesor@gmail.com	$2y$10$FS2ekYESnhXvpSoouarUguy1FaUvhBl96Gozx62Yimm.RdNp/sSx2	\N	\N	\N	\N	1	2024-01-21 01:18:45	2024-01-21 01:18:45	\N
39	32	2	roxlenevera362c@hotmail.com	$2y$10$OwO7CScFLC1kN.lMQsOc3elgZ14DFYFKaW/YvxUSLQTapeIBMOrG6	\N	\N	\N	7	1	2023-07-20 16:10:29	2023-07-20 16:10:29	\N
89	78	1	roxlenevera3626c@gmail.com	$2y$10$FS2ekYESnhXvpSoouarUguy1FaUvhBl96Gozx62Yimm.RdNp/sSx2	\N	\N	\N	\N	1	2024-01-22 19:08:50	2024-01-22 19:08:50	\N
\.


--
-- Data for Name: vistas_notificaciones; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.vistas_notificaciones (id, cant_not, not_vistas, not_new, user_id, created_at, updated_at) FROM stdin;
38	1	0	1	90	2024-01-22 19:30:49	2024-01-22 19:30:49
29	34	45	-11	58	2024-01-15 14:50:47	2024-01-22 19:31:42
30	3	0	3	2	2024-01-18 14:34:04	2024-01-25 18:40:53
31	0	0	0	80	2024-01-18 16:30:36	2024-01-18 16:30:36
32	0	0	0	81	2024-01-21 02:15:53	2024-01-21 02:15:53
28	47	43	4	57	2024-01-14 22:32:05	2024-01-21 18:09:51
34	2	0	2	60	2024-01-21 21:51:00	2024-01-22 00:03:26
35	20	0	20	37	2024-01-22 02:55:05	2024-01-22 02:55:05
33	2	2	0	82	2024-01-21 20:21:42	2024-01-22 03:13:31
36	1	0	1	83	2024-01-22 17:31:23	2024-01-22 17:48:56
39	11	0	11	89	2024-02-06 15:50:27	2024-02-06 16:01:28
37	17	14	3	84	2024-01-22 18:13:01	2024-02-07 21:47:43
\.


--
-- Data for Name: vistas_solicitudes; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.vistas_solicitudes (id, cant_soli, soli_vistas, soli_new, user_id, created_at, updated_at) FROM stdin;
1	0	0	0	57	2024-01-15 14:08:03	2024-01-15 14:50:00
3	0	0	0	37	2024-01-22 02:55:05	2024-01-22 02:55:05
4	0	0	0	84	2024-01-22 18:13:01	2024-01-22 18:13:01
5	0	0	0	90	2024-01-22 19:30:48	2024-01-22 19:30:48
2	0	1	-1	58	2024-01-15 14:50:47	2024-01-22 19:31:42
6	1	1	0	89	2024-02-06 15:50:26	2024-02-06 16:01:25
\.


--
-- Name: clasificacion_componentes_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.clasificacion_componentes_id_seq', 13, true);


--
-- Name: clasificacion_proyectos_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.clasificacion_proyectos_id_seq', 17, true);


--
-- Name: componentes_proyectos_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.componentes_proyectos_id_seq', 4, true);


--
-- Name: direccion_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.direccion_id_seq', 72, true);


--
-- Name: estado_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.estado_id_seq', 1, false);


--
-- Name: estatus_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.estatus_id_seq', 13, true);


--
-- Name: items_evaluados_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.items_evaluados_id_seq', 21, true);


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.items_id_seq', 6, true);


--
-- Name: motivo_denegacion_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.motivo_denegacion_id_seq', 1, true);


--
-- Name: municipio_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.municipio_id_seq', 1, false);


--
-- Name: parroquia_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.parroquia_id_seq', 1, false);


--
-- Name: tipo_usuario_id_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.tipo_usuario_id_seq', 4, true);


--
-- Name: aperturas_id_seq; Type: SEQUENCE SET; Schema: entidades; Owner: postgres
--

SELECT pg_catalog.setval('entidades.aperturas_id_seq', 5, true);


--
-- Name: comunidad_id_seq; Type: SEQUENCE SET; Schema: entidades; Owner: postgres
--

SELECT pg_catalog.setval('entidades.comunidad_id_seq', 23, true);


--
-- Name: persona_id_seq; Type: SEQUENCE SET; Schema: entidades; Owner: postgres
--

SELECT pg_catalog.setval('entidades.persona_id_seq', 80, true);


--
-- Name: profesores_clases_aperturadas_id_seq; Type: SEQUENCE SET; Schema: entidades; Owner: postgres
--

SELECT pg_catalog.setval('entidades.profesores_clases_aperturadas_id_seq', 3, true);


--
-- Name: usuario_datos_id_seq; Type: SEQUENCE SET; Schema: entidades; Owner: postgres
--

SELECT pg_catalog.setval('entidades.usuario_datos_id_seq', 53, true);


--
-- Name: actividades_equipos_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.actividades_equipos_id_seq', 58, true);


--
-- Name: avances_equipos_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.avances_equipos_id_seq', 1, false);


--
-- Name: correcciones_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.correcciones_id_seq', 1, false);


--
-- Name: equipos_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.equipos_id_seq', 46, true);


--
-- Name: integrantes_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.integrantes_id_seq', 56, true);


--
-- Name: necesidades_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.necesidades_id_seq', 10, true);


--
-- Name: notificaciones_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.notificaciones_id_seq', 161, true);


--
-- Name: postulaciones_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.postulaciones_id_seq', 14, true);


--
-- Name: proyecto_clasificado_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.proyecto_clasificado_id_seq', 18, true);


--
-- Name: proyectos_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.proyectos_id_seq', 13, true);


--
-- Name: solicitudes_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.solicitudes_id_seq', 38, true);


--
-- Name: subida_archivos_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.subida_archivos_id_seq', 4, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 133, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.auditoria_id_seq', 19, true);


--
-- Name: configuraciones_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.configuraciones_id_seq', 1, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.permissions_id_seq', 35, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.roles_id_seq', 14, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.usuarios_id_seq', 91, true);


--
-- Name: vistas_notificaciones_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.vistas_notificaciones_id_seq', 39, true);


--
-- Name: vistas_solicitudes_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.vistas_solicitudes_id_seq', 6, true);


--
-- Name: clasificacion_componentes clasificacion_componentes_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_componentes
    ADD CONSTRAINT clasificacion_componentes_pkey PRIMARY KEY (id);


--
-- Name: clasificacion_proyectos clasificacion_proyectos_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_proyectos
    ADD CONSTRAINT clasificacion_proyectos_pkey PRIMARY KEY (id);


--
-- Name: componentes_proyectos componentes_proyectos_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.componentes_proyectos
    ADD CONSTRAINT componentes_proyectos_pkey PRIMARY KEY (id);


--
-- Name: direccion direccion_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.direccion
    ADD CONSTRAINT direccion_pkey PRIMARY KEY (id);


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- Name: estatus estatus_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.estatus
    ADD CONSTRAINT estatus_pkey PRIMARY KEY (id);


--
-- Name: items_evaluados items_evaluados_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items_evaluados
    ADD CONSTRAINT items_evaluados_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: motivo_denegacion motivo_denegacion_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.motivo_denegacion
    ADD CONSTRAINT motivo_denegacion_pkey PRIMARY KEY (id);


--
-- Name: municipio municipio_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.municipio
    ADD CONSTRAINT municipio_pkey PRIMARY KEY (id);


--
-- Name: parroquia parroquia_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.parroquia
    ADD CONSTRAINT parroquia_pkey PRIMARY KEY (id);


--
-- Name: tipo_usuario tipo_usuario_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id);


--
-- Name: aperturas aperturas_pkey; Type: CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.aperturas
    ADD CONSTRAINT aperturas_pkey PRIMARY KEY (id);


--
-- Name: comunidad comunidad_pkey; Type: CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.comunidad
    ADD CONSTRAINT comunidad_pkey PRIMARY KEY (id);


--
-- Name: persona persona_pkey; Type: CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id);


--
-- Name: profesores_clases_aperturadas profesores_clases_aperturadas_pkey; Type: CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.profesores_clases_aperturadas
    ADD CONSTRAINT profesores_clases_aperturadas_pkey PRIMARY KEY (id);


--
-- Name: usuario_datos usuario_datos_pkey; Type: CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.usuario_datos
    ADD CONSTRAINT usuario_datos_pkey PRIMARY KEY (id);


--
-- Name: actividades_equipos actividades_equipos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos
    ADD CONSTRAINT actividades_equipos_pkey PRIMARY KEY (id);


--
-- Name: avances_equipos avances_equipos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.avances_equipos
    ADD CONSTRAINT avances_equipos_pkey PRIMARY KEY (id);


--
-- Name: correcciones correcciones_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.correcciones
    ADD CONSTRAINT correcciones_pkey PRIMARY KEY (id);


--
-- Name: equipos equipos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id);


--
-- Name: integrantes integrantes_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.integrantes
    ADD CONSTRAINT integrantes_pkey PRIMARY KEY (id);


--
-- Name: necesidades necesidades_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades
    ADD CONSTRAINT necesidades_pkey PRIMARY KEY (id);


--
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id);


--
-- Name: postulaciones postulaciones_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.postulaciones
    ADD CONSTRAINT postulaciones_pkey PRIMARY KEY (id);


--
-- Name: proyecto_clasificado proyecto_clasificado_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyecto_clasificado
    ADD CONSTRAINT proyecto_clasificado_pkey PRIMARY KEY (id);


--
-- Name: proyectos proyectos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (id);


--
-- Name: solicitudes solicitudes_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes
    ADD CONSTRAINT solicitudes_pkey PRIMARY KEY (id);


--
-- Name: subida_archivos subida_archivos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.subida_archivos
    ADD CONSTRAINT subida_archivos_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);


--
-- Name: configuraciones configuraciones_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.configuraciones
    ADD CONSTRAINT configuraciones_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: permissions seguridad_permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permissions
    ADD CONSTRAINT seguridad_permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles seguridad_roles_name_guard_name_unique; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles
    ADD CONSTRAINT seguridad_roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: vistas_notificaciones vistas_notificaciones_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.vistas_notificaciones
    ADD CONSTRAINT vistas_notificaciones_pkey PRIMARY KEY (id);


--
-- Name: vistas_solicitudes vistas_solicitudes_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.vistas_solicitudes
    ADD CONSTRAINT vistas_solicitudes_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON seguridad.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX model_has_roles_model_id_model_type_index ON seguridad.model_has_roles USING btree (model_id, model_type);


--
-- Name: clasificacion_componentes administrativo_clasificacion_componentes_id_clasificacion_forei; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_componentes
    ADD CONSTRAINT administrativo_clasificacion_componentes_id_clasificacion_forei FOREIGN KEY (id_clasificacion) REFERENCES administrativo.clasificacion_proyectos(id);


--
-- Name: clasificacion_componentes administrativo_clasificacion_componentes_id_componente_proyecto; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_componentes
    ADD CONSTRAINT administrativo_clasificacion_componentes_id_componente_proyecto FOREIGN KEY (id_componente_proyecto) REFERENCES administrativo.componentes_proyectos(id);


--
-- Name: clasificacion_proyectos administrativo_clasificacion_proyectos_id_estatus_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.clasificacion_proyectos
    ADD CONSTRAINT administrativo_clasificacion_proyectos_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: componentes_proyectos administrativo_componentes_proyectos_id_estatus_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.componentes_proyectos
    ADD CONSTRAINT administrativo_componentes_proyectos_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id);


--
-- Name: direccion administrativo_direccion_id_estado_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.direccion
    ADD CONSTRAINT administrativo_direccion_id_estado_foreign FOREIGN KEY (id_estado) REFERENCES administrativo.estado(id) ON UPDATE CASCADE;


--
-- Name: direccion administrativo_direccion_id_municipio_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.direccion
    ADD CONSTRAINT administrativo_direccion_id_municipio_foreign FOREIGN KEY (id_municipio) REFERENCES administrativo.municipio(id) ON UPDATE CASCADE;


--
-- Name: direccion administrativo_direccion_id_parroquia_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.direccion
    ADD CONSTRAINT administrativo_direccion_id_parroquia_foreign FOREIGN KEY (id_parroquia) REFERENCES administrativo.parroquia(id) ON UPDATE CASCADE;


--
-- Name: items_evaluados administrativo_items_evaluados_clasificacion_id_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items_evaluados
    ADD CONSTRAINT administrativo_items_evaluados_clasificacion_id_foreign FOREIGN KEY (clasificacion_id) REFERENCES administrativo.clasificacion_proyectos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: items administrativo_items_id_estatus_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items
    ADD CONSTRAINT administrativo_items_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: motivo_denegacion administrativo_motivo_denegacion_id_estatus_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.motivo_denegacion
    ADD CONSTRAINT administrativo_motivo_denegacion_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: motivo_denegacion administrativo_motivo_denegacion_user_id_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.motivo_denegacion
    ADD CONSTRAINT administrativo_motivo_denegacion_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: municipio administrativo_municipio_id_estado_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.municipio
    ADD CONSTRAINT administrativo_municipio_id_estado_foreign FOREIGN KEY (id_estado) REFERENCES administrativo.estado(id) ON UPDATE CASCADE;


--
-- Name: parroquia administrativo_parroquia_id_municipio_foreign; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.parroquia
    ADD CONSTRAINT administrativo_parroquia_id_municipio_foreign FOREIGN KEY (id_municipio) REFERENCES administrativo.municipio(id) ON UPDATE CASCADE;


--
-- Name: items_evaluados items_evaluados_fk; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items_evaluados
    ADD CONSTRAINT items_evaluados_fk FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: items_evaluados items_evaluados_fk_item_id; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items_evaluados
    ADD CONSTRAINT items_evaluados_fk_item_id FOREIGN KEY (item_id) REFERENCES administrativo.items(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: items_evaluados items_evaluados_fk_user_id; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items_evaluados
    ADD CONSTRAINT items_evaluados_fk_user_id FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: items items_fk_user_id; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.items
    ADD CONSTRAINT items_fk_user_id FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: comunidad entidades_comunidad_id_direccion_foreign; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.comunidad
    ADD CONSTRAINT entidades_comunidad_id_direccion_foreign FOREIGN KEY (id_direccion) REFERENCES administrativo.direccion(id) ON UPDATE CASCADE;


--
-- Name: persona entidades_persona_id_direccion_foreign; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.persona
    ADD CONSTRAINT entidades_persona_id_direccion_foreign FOREIGN KEY (id_direccion) REFERENCES administrativo.direccion(id) ON UPDATE CASCADE;


--
-- Name: profesores_clases_aperturadas entidades_profesores_clases_aperturadas_clase_aperturada_id_for; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.profesores_clases_aperturadas
    ADD CONSTRAINT entidades_profesores_clases_aperturadas_clase_aperturada_id_for FOREIGN KEY (clase_aperturada_id) REFERENCES entidades.aperturas(id);


--
-- Name: profesores_clases_aperturadas entidades_profesores_clases_aperturadas_id_estatus_foreign; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.profesores_clases_aperturadas
    ADD CONSTRAINT entidades_profesores_clases_aperturadas_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id);


--
-- Name: profesores_clases_aperturadas entidades_profesores_clases_aperturadas_user_id_foreign; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.profesores_clases_aperturadas
    ADD CONSTRAINT entidades_profesores_clases_aperturadas_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: usuario_datos entidades_usuario_datos_estatus_id_foreign; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.usuario_datos
    ADD CONSTRAINT entidades_usuario_datos_estatus_id_foreign FOREIGN KEY (estatus_id) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: usuario_datos entidades_usuario_datos_id_usuario_foreign; Type: FK CONSTRAINT; Schema: entidades; Owner: postgres
--

ALTER TABLE ONLY entidades.usuario_datos
    ADD CONSTRAINT entidades_usuario_datos_id_usuario_foreign FOREIGN KEY (id_usuario) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: necesidades necesidades_fk; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades
    ADD CONSTRAINT necesidades_fk FOREIGN KEY (id_motivo) REFERENCES administrativo.motivo_denegacion(id) ON UPDATE CASCADE;


--
-- Name: necesidades necesidades_fk_evaluado_por; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades
    ADD CONSTRAINT necesidades_fk_evaluado_por FOREIGN KEY (evaluado_por) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: actividades_equipos proyectos_actividades_equipos_actividad_padre_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos
    ADD CONSTRAINT proyectos_actividades_equipos_actividad_padre_foreign FOREIGN KEY (actividad_padre) REFERENCES proyectos.actividades_equipos(id);


--
-- Name: actividades_equipos proyectos_actividades_equipos_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos
    ADD CONSTRAINT proyectos_actividades_equipos_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id);


--
-- Name: actividades_equipos proyectos_actividades_equipos_estatus_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos
    ADD CONSTRAINT proyectos_actividades_equipos_estatus_id_foreign FOREIGN KEY (estatus_id) REFERENCES administrativo.estatus(id);


--
-- Name: actividades_equipos proyectos_actividades_equipos_proyecto_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos
    ADD CONSTRAINT proyectos_actividades_equipos_proyecto_id_foreign FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(id);


--
-- Name: actividades_equipos proyectos_actividades_equipos_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.actividades_equipos
    ADD CONSTRAINT proyectos_actividades_equipos_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: avances_equipos proyectos_avances_equipos_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.avances_equipos
    ADD CONSTRAINT proyectos_avances_equipos_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id);


--
-- Name: avances_equipos proyectos_avances_equipos_item_evaluado_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.avances_equipos
    ADD CONSTRAINT proyectos_avances_equipos_item_evaluado_id_foreign FOREIGN KEY (item_evaluado_id) REFERENCES administrativo.items_evaluados(id);


--
-- Name: correcciones proyectos_correcciones_actividad_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.correcciones
    ADD CONSTRAINT proyectos_correcciones_actividad_id_foreign FOREIGN KEY (actividad_id) REFERENCES proyectos.actividades_equipos(id);


--
-- Name: correcciones proyectos_correcciones_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.correcciones
    ADD CONSTRAINT proyectos_correcciones_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: equipos proyectos_equipos_id_estatus_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.equipos
    ADD CONSTRAINT proyectos_equipos_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id);


--
-- Name: equipos proyectos_equipos_proyecto_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.equipos
    ADD CONSTRAINT proyectos_equipos_proyecto_id_foreign FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(id);


--
-- Name: equipos proyectos_equipos_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.equipos
    ADD CONSTRAINT proyectos_equipos_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: proyectos proyectos_fk_user_id; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_fk_user_id FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: integrantes proyectos_integrantes_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.integrantes
    ADD CONSTRAINT proyectos_integrantes_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id);


--
-- Name: integrantes proyectos_integrantes_id_estatus_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.integrantes
    ADD CONSTRAINT proyectos_integrantes_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id);


--
-- Name: integrantes proyectos_integrantes_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.integrantes
    ADD CONSTRAINT proyectos_integrantes_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: necesidades proyectos_necesidades_direccion_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades
    ADD CONSTRAINT proyectos_necesidades_direccion_id_foreign FOREIGN KEY (direccion_id) REFERENCES administrativo.direccion(id) ON UPDATE CASCADE;


--
-- Name: necesidades proyectos_necesidades_status_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades
    ADD CONSTRAINT proyectos_necesidades_status_id_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: necesidades proyectos_necesidades_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.necesidades
    ADD CONSTRAINT proyectos_necesidades_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: notificaciones proyectos_notificaciones_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.notificaciones
    ADD CONSTRAINT proyectos_notificaciones_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id);


--
-- Name: notificaciones proyectos_notificaciones_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.notificaciones
    ADD CONSTRAINT proyectos_notificaciones_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: postulaciones proyectos_postulaciones_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.postulaciones
    ADD CONSTRAINT proyectos_postulaciones_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id);


--
-- Name: postulaciones proyectos_postulaciones_id_estatus_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.postulaciones
    ADD CONSTRAINT proyectos_postulaciones_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id);


--
-- Name: postulaciones proyectos_postulaciones_proyecto_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.postulaciones
    ADD CONSTRAINT proyectos_postulaciones_proyecto_id_foreign FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(id);


--
-- Name: proyecto_clasificado proyectos_proyecto_clasificado_clasificacion_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyecto_clasificado
    ADD CONSTRAINT proyectos_proyecto_clasificado_clasificacion_id_foreign FOREIGN KEY (clasificacion_id) REFERENCES administrativo.clasificacion_proyectos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: proyecto_clasificado proyectos_proyecto_clasificado_proyectos_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyecto_clasificado
    ADD CONSTRAINT proyectos_proyecto_clasificado_proyectos_id_foreign FOREIGN KEY (proyectos_id) REFERENCES proyectos.proyectos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: proyectos proyectos_proyectos_necesidad_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_proyectos_necesidad_id_foreign FOREIGN KEY (necesidad_id) REFERENCES proyectos.necesidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: proyectos proyectos_proyectos_status_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_proyectos_status_id_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: solicitudes proyectos_solicitudes_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes
    ADD CONSTRAINT proyectos_solicitudes_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id) ON DELETE CASCADE;


--
-- Name: solicitudes proyectos_solicitudes_id_estatus_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes
    ADD CONSTRAINT proyectos_solicitudes_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id);


--
-- Name: solicitudes proyectos_solicitudes_integrante_id_desincorporar_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes
    ADD CONSTRAINT proyectos_solicitudes_integrante_id_desincorporar_foreign FOREIGN KEY (integrante_id_desincorporar) REFERENCES proyectos.integrantes(id);


--
-- Name: solicitudes proyectos_solicitudes_solicitante_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes
    ADD CONSTRAINT proyectos_solicitudes_solicitante_id_foreign FOREIGN KEY (solicitante_id) REFERENCES proyectos.integrantes(id);


--
-- Name: solicitudes proyectos_solicitudes_user_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.solicitudes
    ADD CONSTRAINT proyectos_solicitudes_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: subida_archivos proyectos_subida_archivos_actividad_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.subida_archivos
    ADD CONSTRAINT proyectos_subida_archivos_actividad_id_foreign FOREIGN KEY (actividad_id) REFERENCES proyectos.actividades_equipos(id);


--
-- Name: subida_archivos proyectos_subida_archivos_equipo_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.subida_archivos
    ADD CONSTRAINT proyectos_subida_archivos_equipo_id_foreign FOREIGN KEY (equipo_id) REFERENCES proyectos.equipos(id);


--
-- Name: subida_archivos proyectos_subida_archivos_proyecto_id_foreign; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.subida_archivos
    ADD CONSTRAINT proyectos_subida_archivos_proyecto_id_foreign FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(id);


--
-- Name: auditoria seguridad_auditoria_id_usuario_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.auditoria
    ADD CONSTRAINT seguridad_auditoria_id_usuario_foreign FOREIGN KEY (id_usuario) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: model_has_permissions seguridad_model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.model_has_permissions
    ADD CONSTRAINT seguridad_model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES seguridad.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles seguridad_model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.model_has_roles
    ADD CONSTRAINT seguridad_model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES seguridad.roles(id) ON DELETE CASCADE;


--
-- Name: permissions seguridad_permissions_estatus_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permissions
    ADD CONSTRAINT seguridad_permissions_estatus_id_foreign FOREIGN KEY (estatus_id) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: permissions seguridad_permissions_usuario_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permissions
    ADD CONSTRAINT seguridad_permissions_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: role_has_permissions seguridad_role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.role_has_permissions
    ADD CONSTRAINT seguridad_role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES seguridad.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions seguridad_role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.role_has_permissions
    ADD CONSTRAINT seguridad_role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES seguridad.roles(id) ON DELETE CASCADE;


--
-- Name: roles seguridad_roles_estatus_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles
    ADD CONSTRAINT seguridad_roles_estatus_id_foreign FOREIGN KEY (estatus_id) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: roles seguridad_roles_usuario_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles
    ADD CONSTRAINT seguridad_roles_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id) ON UPDATE CASCADE;


--
-- Name: usuarios seguridad_usuarios_id_comunidad_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT seguridad_usuarios_id_comunidad_foreign FOREIGN KEY (id_comunidad) REFERENCES entidades.comunidad(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuarios seguridad_usuarios_id_estatus_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT seguridad_usuarios_id_estatus_foreign FOREIGN KEY (id_estatus) REFERENCES administrativo.estatus(id) ON UPDATE CASCADE;


--
-- Name: usuarios seguridad_usuarios_id_persona_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT seguridad_usuarios_id_persona_foreign FOREIGN KEY (id_persona) REFERENCES entidades.persona(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuarios seguridad_usuarios_id_tipo_usuario_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT seguridad_usuarios_id_tipo_usuario_foreign FOREIGN KEY (id_tipo_usuario) REFERENCES administrativo.tipo_usuario(id) ON UPDATE CASCADE;


--
-- Name: vistas_notificaciones seguridad_vistas_notificaciones_user_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.vistas_notificaciones
    ADD CONSTRAINT seguridad_vistas_notificaciones_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- Name: vistas_solicitudes seguridad_vistas_solicitudes_user_id_foreign; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.vistas_solicitudes
    ADD CONSTRAINT seguridad_vistas_solicitudes_user_id_foreign FOREIGN KEY (user_id) REFERENCES seguridad.usuarios(id);


--
-- PostgreSQL database dump complete
--

