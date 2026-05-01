--
-- PostgreSQL database dump
--

\restrict ECUpbQemtAUF7sl21ZQZraFKdetoO1Fg4hZ0GrLEuedhHspbIdt5lK3WbAAs27V

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-04 10:37:18

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

DROP DATABASE module_03_evenements_data;
--
-- TOC entry 4998 (class 1262 OID 17615)
-- Name: module_03_evenements_data; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE module_03_evenements_data WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_Canada.1252';


ALTER DATABASE module_03_evenements_data OWNER TO postgres;

\unrestrict ECUpbQemtAUF7sl21ZQZraFKdetoO1Fg4hZ0GrLEuedhHspbIdt5lK3WbAAs27V
\connect module_03_evenements_data
\restrict ECUpbQemtAUF7sl21ZQZraFKdetoO1Fg4hZ0GrLEuedhHspbIdt5lK3WbAAs27V

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
-- TOC entry 219 (class 1259 OID 17616)
-- Name: evenement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evenement (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    date_evenement date NOT NULL,
    lieu character varying(100) NOT NULL,
    capacite integer NOT NULL,
    actif boolean DEFAULT true NOT NULL,
    prix numeric(8,2) DEFAULT 50 NOT NULL,
    CONSTRAINT evenement_capacite_check CHECK ((capacite >= 0))
);


ALTER TABLE public.evenement OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17627)
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
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 220
-- Name: evenement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evenement_id_seq OWNED BY public.evenement.id;


--
-- TOC entry 221 (class 1259 OID 17628)
-- Name: inscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscription (
    id integer NOT NULL,
    evenement_id integer NOT NULL,
    participant_id integer NOT NULL,
    date_inscription date DEFAULT CURRENT_DATE NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE public.inscription OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17638)
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
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 222
-- Name: inscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscription_id_seq OWNED BY public.inscription.id;


--
-- TOC entry 223 (class 1259 OID 17639)
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
-- TOC entry 224 (class 1259 OID 17647)
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
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 224
-- Name: participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participant_id_seq OWNED BY public.participant.id;


--
-- TOC entry 4819 (class 2604 OID 17648)
-- Name: evenement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenement ALTER COLUMN id SET DEFAULT nextval('public.evenement_id_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 17649)
-- Name: inscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription ALTER COLUMN id SET DEFAULT nextval('public.inscription_id_seq'::regclass);


--
-- TOC entry 4825 (class 2604 OID 17650)
-- Name: participant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant ALTER COLUMN id SET DEFAULT nextval('public.participant_id_seq'::regclass);


--
-- TOC entry 4987 (class 0 OID 17616)
-- Dependencies: 219
-- Data for Name: evenement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evenement (id, nom, date_evenement, lieu, capacite, actif, prix) FROM stdin;
1	Conférence Tech 2026	2026-03-15	Paris	300	t	50.00
3	Salon de l'Entrepreneuriat	2026-05-20	Marseille	500	t	50.00
4	Meetup Développement Web	2026-02-10	Toulouse	80	t	50.00
6	Conférence IA & Innovation	2026-07-10	Paris	400	t	50.00
8	Journée Big Data	2026-08-05	Nantes	180	t	50.00
9	Hackathon Étudiant	2026-08-20	Rennes	120	t	50.00
10	Sommet Cybersécurité	2026-09-02	Paris	350	f	50.00
12	Conférence UX/UI	2026-09-25	Strasbourg	150	t	50.00
13	Meetup Python	2026-10-03	Grenoble	90	t	50.00
14	Meetup Java	2026-10-10	Nice	90	f	50.00
15	Workshop Kubernetes	2026-10-18	Lille	50	t	50.00
17	Conférence FinTech	2026-11-12	La Défense	300	t	50.00
18	Forum RH & Tech	2026-11-20	Reims	200	f	50.00
19	Journée Qualité Logicielle	2026-12-01	Tours	140	t	50.00
20	Conférence Green IT	2026-12-10	Annecy	160	t	50.00
21	Bootcamp Full Stack	2027-01-15	Paris	30	t	50.00
23	Conférence Mobile Dev	2027-02-05	Montpellier	220	t	50.00
24	Meetup Startup	2027-02-12	Station F	180	t	50.00
25	Forum E-commerce	2027-02-25	Roubaix	260	t	50.00
27	Journée Test Logiciel	2027-03-12	Angers	110	t	50.00
28	Sommet IT Public	2027-03-20	Bercy	500	t	50.00
30	Rencontre CTO	2027-04-10	Paris	100	t	50.00
5	Formation Cybersécurité	2026-06-05	Lille	25	f	0.00
7	Forum Cloud Computing	2026-07-18	Lyon	250	f	0.00
11	Atelier DevOps	2026-09-15	Bordeaux	60	t	0.00
16	Salon Open Source	2026-11-02	Paris	600	t	0.00
26	Conférence Blockchain	2027-03-05	Paris	320	f	0.00
29	Atelier Accessibilité Web	2027-04-02	Caen	70	f	0.00
2	Atelier Data Science	2026-04-02	Lyon	40	t	0.00
22	Atelier SQL Avancé	2027-01-22	Lyon	40	f	0.00
\.


--
-- TOC entry 4989 (class 0 OID 17628)
-- Dependencies: 221
-- Data for Name: inscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscription (id, evenement_id, participant_id, date_inscription, actif) FROM stdin;
1	1	1	2026-01-10	t
2	1	2	2026-01-12	t
3	1	3	2026-01-15	t
4	2	2	2026-02-01	t
5	2	4	2026-02-02	t
6	3	1	2026-03-05	t
7	3	5	2026-03-06	t
8	3	6	2026-03-07	t
9	4	3	2026-01-25	t
10	4	4	2026-01-26	t
11	4	7	2026-01-27	t
12	5	2	2026-04-01	t
13	5	6	2026-04-02	t
21	5	10	2026-01-20	t
22	6	11	2026-01-22	t
23	6	12	2026-01-23	t
24	6	13	2026-01-24	t
25	7	14	2026-01-25	t
26	7	15	2026-01-26	t
27	9	16	2026-01-28	t
28	9	17	2026-01-29	t
29	9	18	2026-01-29	t
30	9	19	2026-01-30	t
31	10	20	2026-02-01	t
32	11	21	2026-02-03	t
33	11	22	2026-02-03	t
34	13	23	2026-02-05	t
35	13	24	2026-02-06	t
36	13	25	2026-02-06	t
37	14	26	2026-02-08	t
38	15	27	2026-02-10	t
39	15	28	2026-02-11	t
40	17	29	2026-02-14	t
41	17	30	2026-02-15	t
42	17	31	2026-02-15	t
43	18	32	2026-02-18	t
44	19	33	2026-02-20	t
45	19	34	2026-02-21	t
46	21	35	2026-02-24	t
47	21	36	2026-02-24	t
48	21	37	2026-02-25	t
49	22	38	2026-02-27	t
50	23	39	2026-03-01	t
51	23	40	2026-03-02	t
52	25	41	2026-03-04	t
53	25	42	2026-03-05	t
54	25	43	2026-03-05	t
55	26	44	2026-03-07	t
56	27	45	2026-03-09	t
57	27	46	2026-03-10	t
58	29	47	2026-03-12	t
59	30	1	2026-03-15	t
60	30	2	2026-03-15	t
61	30	3	2026-03-16	t
\.


--
-- TOC entry 4991 (class 0 OID 17639)
-- Dependencies: 223
-- Data for Name: participant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participant (id, nom, courriel, actif) FROM stdin;
1	Alice Martin	alice.martin@example.com	t
2	Bruno Lefèvre	bruno.lefevre@example.com	t
3	Camille Dupont	camille.dupont@example.com	t
4	David Moreau	david.moreau@example.com	t
5	Emma Girard	emma.girard@example.com	f
6	François Bernard	francois.bernard@example.com	t
7	Julie Petit	julie.petit@example.com	t
8	Alice Martin	alice.martin2@example.com	t
9	Bruno Lefevre	bruno.lefevre2@example.com	t
10	Camille Dupont	camille.dupont2@example.com	f
11	David Morel	david.morel@example.com	t
12	Emma Girard	emma.girard2@example.com	t
13	François Bernard	francois.bernard2@example.com	t
14	Julie Petit	julie.petit2@example.com	f
15	Lucas Renault	lucas.renault@example.com	t
16	Manon Dubois	manon.dubois@example.com	t
17	Nicolas Faure	nicolas.faure@example.com	t
18	Océane Leroy	oceane.leroy@example.com	t
19	Paul Gauthier	paul.gauthier@example.com	f
20	Quentin Roche	quentin.roche@example.com	t
21	Romain Blanchard	romain.blanchard@example.com	t
22	Sarah Chevalier	sarah.chevalier@example.com	t
23	Thomas Perrin	thomas.perrin@example.com	t
24	Ulysse Marchand	ulysse.marchand@example.com	t
25	Valérie Meunier	valerie.meunier@example.com	f
26	William Henry	william.henry@example.com	t
27	Zoé Colin	zoe.colin@example.com	t
28	Antoine Lacroix	antoine.lacroix@example.com	t
29	Béatrice Noel	beatrice.noel@example.com	t
30	Cédric Rolland	cedric.rolland@example.com	f
31	Delphine Roussel	delphine.roussel@example.com	t
32	Élodie Garnier	elodie.garnier@example.com	t
33	Florian Picard	florian.picard@example.com	t
34	Gaëlle Lambert	gaelle.lambert@example.com	t
35	Hugo Fernandez	hugo.fernandez@example.com	f
36	Inès Aubert	ines.aubert@example.com	t
37	Julien Caron	julien.caron@example.com	t
38	Karim Benali	karim.benali@example.com	t
39	Laura Masson	laura.masson@example.com	t
40	Mathieu Teixeira	mathieu.teixeira@example.com	f
41	Nathalie Hoarau	nathalie.hoarau@example.com	t
42	Olivier Cousin	olivier.cousin@example.com	t
43	Pascal Verdier	pascal.verdier@example.com	t
44	Rachid El Amrani	rachid.elamrani@example.com	t
45	Sophie Lemoine	sophie.lemoine@example.com	f
46	Thibault Moreau	thibault.moreau@example.com	t
47	Yann Leclerc	yann.leclerc@example.com	t
\.


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 220
-- Name: evenement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evenement_id_seq', 30, true);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 222
-- Name: inscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscription_id_seq', 61, true);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 224
-- Name: participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participant_id_seq', 47, true);


--
-- TOC entry 4829 (class 2606 OID 17652)
-- Name: evenement evenement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenement
    ADD CONSTRAINT evenement_pkey PRIMARY KEY (id);


--
-- TOC entry 4831 (class 2606 OID 17654)
-- Name: inscription inscription_evenement_id_participant_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_evenement_id_participant_id_key UNIQUE (evenement_id, participant_id);


--
-- TOC entry 4833 (class 2606 OID 17656)
-- Name: inscription inscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 17658)
-- Name: participant participant_courriel_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_courriel_key UNIQUE (courriel);


--
-- TOC entry 4837 (class 2606 OID 17660)
-- Name: participant participant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_pkey PRIMARY KEY (id);


--
-- TOC entry 4838 (class 2606 OID 17661)
-- Name: inscription inscription_evenement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_evenement_id_fkey FOREIGN KEY (evenement_id) REFERENCES public.evenement(id);


--
-- TOC entry 4839 (class 2606 OID 17666)
-- Name: inscription inscription_participant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.participant(id);


-- Completed on 2026-02-04 10:37:19

--
-- PostgreSQL database dump complete
--

\unrestrict ECUpbQemtAUF7sl21ZQZraFKdetoO1Fg4hZ0GrLEuedhHspbIdt5lK3WbAAs27V

