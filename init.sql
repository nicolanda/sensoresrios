--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)

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
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devices (
    sensor_id character varying NOT NULL,
    ip character varying
);


ALTER TABLE public.devices OWNER TO postgres;

--
-- Name: readings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.readings (
    reading_id integer NOT NULL,
    sensor_id character varying,
    dix real,
    "time" character varying
);


ALTER TABLE public.readings OWNER TO postgres;

--
-- Name: readings_reading_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.readings_reading_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.readings_reading_id_seq OWNER TO postgres;

--
-- Name: readings_reading_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.readings_reading_id_seq OWNED BY public.readings.reading_id;


--
-- Name: readings reading_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.readings ALTER COLUMN reading_id SET DEFAULT nextval('public.readings_reading_id_seq'::regclass);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devices (sensor_id, ip) FROM stdin;
1	192.168.1.1
2	192.162.1.1
3	192.162.1.2
4	192.162.1.15
6	192.268.1.1
5	192.268.1.2
8	192.268.1.5
9	192.268.1.6
12	192.268.1.12
7	192.268.1.51
\.


--
-- Data for Name: readings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.readings (reading_id, sensor_id, dix, "time") FROM stdin;
1	1	25.6	11:10:6 01/01/2021
2	1	25.6	11:15:6 01/01/2021
3	1	25.6	11:20:6 01/01/2021
4	1	25.6	11:10:6 01/01/2021
5	1	25.6	11:15:6 01/01/2021
6	1	25.6	11:20:6 01/01/2021
7	1	25.6	11:10:6 01/01/2021
8	1	25.6	11:15:6 01/01/2021
9	1	25.6	11:20:6 01/01/2021
10	2	30	1:12:6 01/30/2021
\.


--
-- Name: readings_reading_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.readings_reading_id_seq', 10, true);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (sensor_id);


--
-- Name: readings readings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.readings
    ADD CONSTRAINT readings_pkey PRIMARY KEY (reading_id);


--
-- Name: readings fk_device; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.readings
    ADD CONSTRAINT fk_device FOREIGN KEY (sensor_id) REFERENCES public.devices(sensor_id);


--
-- PostgreSQL database dump complete
--

