--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Debian 15.12-1.pgdg120+1)
-- Dumped by pg_dump version 15.12 (Debian 15.12-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cuentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuentas (
    id_cuenta integer NOT NULL,
    nombre_cliente character varying(255),
    saldo numeric
);


ALTER TABLE public.cuentas OWNER TO postgres;

--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuentas_id_cuenta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuentas_id_cuenta_seq OWNER TO postgres;

--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuentas_id_cuenta_seq OWNED BY public.cuentas.id_cuenta;


--
-- Name: transacciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transacciones (
    id_transaccion integer NOT NULL,
    id_cuenta integer,
    tipo_transaccion character varying(10),
    monto numeric,
    fecha_transaccion timestamp without time zone
);


ALTER TABLE public.transacciones OWNER TO postgres;

--
-- Name: transacciones_id_transaccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transacciones_id_transaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_id_transaccion_seq OWNER TO postgres;

--
-- Name: transacciones_id_transaccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transacciones_id_transaccion_seq OWNED BY public.transacciones.id_transaccion;


--
-- Name: cuentas id_cuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas ALTER COLUMN id_cuenta SET DEFAULT nextval('public.cuentas_id_cuenta_seq'::regclass);


--
-- Name: transacciones id_transaccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones ALTER COLUMN id_transaccion SET DEFAULT nextval('public.transacciones_id_transaccion_seq'::regclass);


--
-- Data for Name: cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuentas (id_cuenta, nombre_cliente, saldo) FROM stdin;
1	Cliente 96	3204.48
2	Cliente 27	6047.42
3	Cliente 29	7395.37
4	Cliente 96	6558.38
5	Cliente 63	4135.53
6	Cliente 17	1179.4
7	Cliente 89	4011.69
8	Cliente 61	5131.0
9	Cliente 35	9056.96
10	Cliente 66	6725.15
11	Cliente 48	6514.59
12	Cliente 100	4533.49
13	Cliente 61	7512.48
14	Cliente 51	5716.06
15	Cliente 60	5098.63
16	Cliente 36	6649.94
17	Cliente 43	2405.09
18	Cliente 75	4089.85
19	Cliente 60	1815.69
20	Cliente 68	6670.42
21	Cliente 62	9510.04
22	Cliente 93	3680.5
23	Cliente 6	7620.29
24	Cliente 8	5127.61
25	Cliente 22	2530.16
26	Cliente 35	4622.66
27	Cliente 32	2278.71
28	Cliente 79	7254.59
29	Cliente 67	5107.18
30	Cliente 6	1052.54
31	Cliente 93	6787.56
\.


--
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transacciones (id_transaccion, id_cuenta, tipo_transaccion, monto, fecha_transaccion) FROM stdin;
1	1	retiro	366.83	2025-05-02 05:28:07.554299
2	2	deposito	175.82	2025-05-02 05:28:09.562137
3	3	deposito	681.25	2025-05-02 05:28:11.576872
4	4	retiro	629.17	2025-05-02 05:28:13.591992
5	5	deposito	241.2	2025-05-02 05:28:15.597835
6	6	retiro	877.64	2025-05-02 05:28:17.129797
7	7	retiro	220.57	2025-05-02 05:28:19.14539
8	8	retiro	113.81	2025-05-02 05:28:21.151748
9	9	deposito	279.53	2025-05-02 05:28:23.156908
10	10	deposito	899.7	2025-05-02 05:28:25.163298
11	11	retiro	705.76	2025-05-02 05:28:27.176673
12	12	retiro	376.82	2025-05-02 05:28:29.18158
13	13	deposito	494.34	2025-05-02 05:28:31.18755
14	14	retiro	321.93	2025-05-02 05:28:33.194571
15	15	deposito	115.91	2025-05-02 05:28:35.207925
16	16	deposito	931.06	2025-05-02 05:28:37.224283
17	17	retiro	467.67	2025-05-02 05:28:39.231982
18	18	retiro	386.69	2025-05-02 05:28:41.240594
19	19	deposito	855.69	2025-05-02 05:28:43.248485
20	20	retiro	541.53	2025-05-02 05:28:45.256026
21	21	deposito	979.89	2025-05-02 05:28:47.261931
22	22	deposito	315.82	2025-05-02 05:28:48.804687
23	23	deposito	761.15	2025-05-02 05:28:50.814876
24	24	deposito	269.06	2025-05-02 05:28:52.822322
25	25	deposito	681.65	2025-05-02 05:28:54.829468
26	26	deposito	415.9	2025-05-02 05:28:56.837837
27	27	deposito	751.51	2025-05-02 05:28:58.844968
28	28	deposito	344.09	2025-05-02 05:29:00.852712
29	29	deposito	468.38	2025-05-02 05:29:02.860348
30	30	deposito	961.3	2025-05-02 05:29:04.867525
31	31	deposito	880.88	2025-05-02 05:29:06.875054
\.


--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuentas_id_cuenta_seq', 31, true);


--
-- Name: transacciones_id_transaccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transacciones_id_transaccion_seq', 31, true);


--
-- Name: cuentas cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id_cuenta);


--
-- Name: transacciones transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id_transaccion);


--
-- Name: transacciones transacciones_id_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuentas(id_cuenta);


--
-- Name: TABLE cuentas; Type: ACL; Schema: public; Owner: postgres
--

GRANT INSERT ON TABLE public.cuentas TO generador_datos;
GRANT SELECT,INSERT ON TABLE public.cuentas TO mi_usuario;


--
-- Name: SEQUENCE cuentas_id_cuenta_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.cuentas_id_cuenta_seq TO mi_usuario;


--
-- Name: TABLE transacciones; Type: ACL; Schema: public; Owner: postgres
--

GRANT INSERT ON TABLE public.transacciones TO generador_datos;
GRANT SELECT,INSERT ON TABLE public.transacciones TO mi_usuario;


--
-- Name: SEQUENCE transacciones_id_transaccion_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.transacciones_id_transaccion_seq TO mi_usuario;


--
-- PostgreSQL database dump complete
--

