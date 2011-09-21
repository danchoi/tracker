--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: choi; Tablespace: 
--

CREATE TABLE tasks (
    task_id integer NOT NULL,
    title character varying,
    notes text,
    context character varying,
    priority character varying,
    parent_id integer,
    created_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone,
    due_at timestamp without time zone,
    "position" integer
);


ALTER TABLE public.tasks OWNER TO choi;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE; Schema: public; Owner: choi
--

CREATE SEQUENCE tasks_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tasks_task_id_seq OWNER TO choi;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: choi
--

ALTER SEQUENCE tasks_task_id_seq OWNED BY tasks.task_id;


--
-- Name: tasks_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: choi
--

SELECT pg_catalog.setval('tasks_task_id_seq', 6, true);


--
-- Name: task_id; Type: DEFAULT; Schema: public; Owner: choi
--

ALTER TABLE tasks ALTER COLUMN task_id SET DEFAULT nextval('tasks_task_id_seq'::regclass);


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: choi
--

COPY tasks (task_id, title, notes, context, priority, parent_id, created_at, completed_at, due_at, "position") FROM stdin;
5	Make Vim interface	\N	home	medium	3	2011-08-13 10:54:40.915457	\N	\N	0
4	Study postgresql 'with recursive' queries	\N	home	medium	3	2011-08-13 10:54:40.914084	\N	\N	1
2	Call CTO of Alydar	\N	home	high	\N	2011-08-13 10:54:40.90994	\N	2011-08-13 00:00:00	0
6	find good example	\N	\N	\N	4	2011-08-13 12:12:42.933323	\N	\N	0
3	Do Tracker project	\N	home	medium	\N	2011-08-13 10:54:40.912482	\N	\N	1
1	call with CTO at Alydar	\N	home	\N	\N	2011-08-13 10:40:03.725077	\N	\N	2
\.


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: choi; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

