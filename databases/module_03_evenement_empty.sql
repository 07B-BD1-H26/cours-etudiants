--
-- PostgreSQL database dump
--

\restrict E9pDzHPlvkYBifXyniEnJLTRO03ohHx3zMGVbrn4bC0e3oa18tMdjMUcR6ezHTp

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-22 11:06:18

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

DROP DATABASE module_03_evenements_empty;
--
-- TOC entry 4996 (class 1262 OID 16474)
-- Name: module_03_evenements_empty; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE module_03_evenements_empty WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_Canada.1252';


ALTER DATABASE module_03_evenements_empty OWNER TO postgres;

\unrestrict E9pDzHPlvkYBifXyniEnJLTRO03ohHx3zMGVbrn4bC0e3oa18tMdjMUcR6ezHTp
\connect module_03_evenements_empty
\restrict E9pDzHPlvkYBifXyniEnJLTRO03ohHx3zMGVbrn4bC0e3oa18tMdjMUcR6ezHTp

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
-- TOC entry 220 (class 1259 OID 16476)
-- Name: evenement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evenement (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    date_evenement date NOT NULL,
    lieu character varying(100) NOT NULL,
    capacite integer NOT NULL,
    actif boolean DEFAULT true NOT NULL,
    CONSTRAINT evenement_capacite_check CHECK ((capacite >= 0))
);


ALTER TABLE public.evenement OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16475)
-- Name: evenement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evenement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evenement_id_seq OWNER TO postgres;

--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 219
-- Name: evenement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evenement_id_seq OWNED BY public.evenement.id;


--
-- TOC entry 224 (class 1259 OID 16505)
-- Name: inscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscription (
    id integer NOT NULL,
    evenement_id integer NOT NULL,
    participant_id integer NOT NULL,
    date_inscription date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.inscription OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16504)
-- Name: inscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscription_id_seq OWNER TO postgres;

--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 223
-- Name: inscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscription_id_seq OWNED BY public.inscription.id;


--
-- TOC entry 222 (class 1259 OID 16491)
-- Name: participant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participant (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    courriel character varying(150) NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE public.participant OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16490)
-- Name: participant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.participant_id_seq OWNER TO postgres;

--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 221
-- Name: participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participant_id_seq OWNED BY public.participant.id;


--
-- TOC entry 4819 (class 2604 OID 16479)
-- Name: evenement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenement ALTER COLUMN id SET DEFAULT nextval('public.evenement_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 16508)
-- Name: inscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription ALTER COLUMN id SET DEFAULT nextval('public.inscription_id_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 16494)
-- Name: participant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant ALTER COLUMN id SET DEFAULT nextval('public.participant_id_seq'::regclass);


--
-- TOC entry 4986 (class 0 OID 16476)
-- Dependencies: 220
-- Data for Name: evenement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evenement (id, nom, date_evenement, lieu, capacite, actif) FROM stdin;
\.


--
-- TOC entry 4990 (class 0 OID 16505)
-- Dependencies: 224
-- Data for Name: inscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscription (id, evenement_id, participant_id, date_inscription) FROM stdin;
\.


--
-- TOC entry 4988 (class 0 OID 16491)
-- Dependencies: 222
-- Data for Name: participant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participant (id, nom, courriel, actif) FROM stdin;
\.


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 219
-- Name: evenement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evenement_id_seq', 1, false);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 223
-- Name: inscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscription_id_seq', 1, false);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 221
-- Name: participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participant_id_seq', 1, false);


--
-- TOC entry 4827 (class 2606 OID 16489)
-- Name: evenement evenement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenement
    ADD CONSTRAINT evenement_pkey PRIMARY KEY (id);


--
-- TOC entry 4833 (class 2606 OID 16517)
-- Name: inscription inscription_evenement_id_participant_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_evenement_id_participant_id_key UNIQUE (evenement_id, participant_id);


--
-- TOC entry 4835 (class 2606 OID 16515)
-- Name: inscription inscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 16503)
-- Name: participant participant_courriel_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_courriel_key UNIQUE (courriel);


--
-- TOC entry 4831 (class 2606 OID 16501)
-- Name: participant participant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_pkey PRIMARY KEY (id);


--
-- TOC entry 4836 (class 2606 OID 16518)
-- Name: inscription inscription_evenement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_evenement_id_fkey FOREIGN KEY (evenement_id) REFERENCES public.evenement(id);


--
-- TOC entry 4837 (class 2606 OID 16523)
-- Name: inscription inscription_participant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.participant(id);


-- Completed on 2026-01-22 11:06:19

--
-- PostgreSQL database dump complete
--

\unrestrict E9pDzHPlvkYBifXyniEnJLTRO03ohHx3zMGVbrn4bC0e3oa18tMdjMUcR6ezHTp

