--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Ubuntu 16.1-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.1 (Ubuntu 16.1-1.pgdg22.04+1)

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
-- Name: orders; Type: TABLE; Schema: public; Owner: gmasquelier
--

CREATE TABLE public.orders (
    order_number integer NOT NULL,
    user_uuid integer NOT NULL,
    order_total_cost_ht money NOT NULL,
    order_total_quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deliver_at timestamp without time zone,
    CONSTRAINT orders_order_total_cost_ht_check CHECK (((order_total_cost_ht)::numeric >= (0)::numeric)),
    CONSTRAINT orders_order_total_quantity_check CHECK ((order_total_quantity >= 0))
);


ALTER TABLE public.orders OWNER TO gmasquelier;

--
-- Name: orders_order_number_seq; Type: SEQUENCE; Schema: public; Owner: gmasquelier
--

CREATE SEQUENCE public.orders_order_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_number_seq OWNER TO gmasquelier;

--
-- Name: orders_order_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gmasquelier
--

ALTER SEQUENCE public.orders_order_number_seq OWNED BY public.orders.order_number;


--
-- Name: products; Type: TABLE; Schema: public; Owner: gmasquelier
--

CREATE TABLE public.products (
    product_uuid integer NOT NULL,
    product_name character varying(100) NOT NULL,
    product_description character varying(255),
    product_price money NOT NULL,
    product_quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    CONSTRAINT products_product_name_check CHECK (((product_name)::text <> ''::text)),
    CONSTRAINT products_product_price_check CHECK (((product_price)::numeric >= (0)::numeric)),
    CONSTRAINT products_product_quantity_check CHECK ((product_quantity >= 0))
);


ALTER TABLE public.products OWNER TO gmasquelier;

--
-- Name: products_orders; Type: TABLE; Schema: public; Owner: gmasquelier
--

CREATE TABLE public.products_orders (
    product_uuid integer NOT NULL,
    order_number integer NOT NULL
);


ALTER TABLE public.products_orders OWNER TO gmasquelier;

--
-- Name: products_product_uuid_seq; Type: SEQUENCE; Schema: public; Owner: gmasquelier
--

CREATE SEQUENCE public.products_product_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_uuid_seq OWNER TO gmasquelier;

--
-- Name: products_product_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gmasquelier
--

ALTER SEQUENCE public.products_product_uuid_seq OWNED BY public.products.product_uuid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: gmasquelier
--

CREATE TABLE public.users (
    user_uuid integer NOT NULL,
    user_pseudo character varying(50) NOT NULL,
    username character varying(30) NOT NULL,
    user_password character varying(80) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_user_password_check CHECK (((user_password)::text <> ''::text)),
    CONSTRAINT users_user_pseudo_check CHECK (((user_pseudo)::text <> ''::text)),
    CONSTRAINT users_username_check CHECK (((username)::text <> ''::text))
);


ALTER TABLE public.users OWNER TO gmasquelier;

--
-- Name: users_user_uuid_seq; Type: SEQUENCE; Schema: public; Owner: gmasquelier
--

CREATE SEQUENCE public.users_user_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_uuid_seq OWNER TO gmasquelier;

--
-- Name: users_user_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gmasquelier
--

ALTER SEQUENCE public.users_user_uuid_seq OWNED BY public.users.user_uuid;


--
-- Name: orders order_number; Type: DEFAULT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_number SET DEFAULT nextval('public.orders_order_number_seq'::regclass);


--
-- Name: products product_uuid; Type: DEFAULT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.products ALTER COLUMN product_uuid SET DEFAULT nextval('public.products_product_uuid_seq'::regclass);


--
-- Name: users user_uuid; Type: DEFAULT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.users ALTER COLUMN user_uuid SET DEFAULT nextval('public.users_user_uuid_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: gmasquelier
--

COPY public.orders (order_number, user_uuid, order_total_cost_ht, order_total_quantity, created_at, deliver_at) FROM stdin;
1	1	$842.25	4	2023-11-24 11:22:32.258355	\N
2	3	$123.00	2	2023-11-24 11:22:32.262304	\N
3	5	$239.25	1	2023-11-24 11:22:32.26582	\N
4	7	$149.21	3	2023-11-24 11:22:32.269364	\N
5	9	$346.25	2	2023-11-24 11:22:32.272885	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: gmasquelier
--

COPY public.products (product_uuid, product_name, product_description, product_price, product_quantity, created_at, updated_at) FROM stdin;
1	Lighter - Bbq	\N	$489.33	93	2023-11-24 11:22:32.181085	\N
2	Cake - Bande Of Fruit	Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.	$195.19	72	2023-11-24 11:22:32.184655	\N
3	Pastry - Key Limepoppy Seed Tea	Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	$991.21	2	2023-11-24 11:22:32.188268	\N
4	Mace Ground	Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.	$194.00	16	2023-11-24 11:22:32.191806	\N
5	Spring Roll Veg Mini	Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.	$473.83	10	2023-11-24 11:22:32.194489	\N
6	Pastry - French Mini Assorted	Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.	$319.36	21	2023-11-24 11:22:32.198003	\N
7	Lettuce - Lambs Mash	Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.	$578.23	22	2023-11-24 11:22:32.201616	\N
8	Juice - V8 Splash	Fusce consequat. Nulla nisl. Nunc nisl.	$284.98	19	2023-11-24 11:22:32.20515	\N
9	Milk - Skim	Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.	$637.89	67	2023-11-24 11:22:32.20877	\N
10	Fond - Chocolate	In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.	$850.20	70	2023-11-24 11:22:32.212332	\N
11	Celery	Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.	$784.35	87	2023-11-24 11:22:32.215584	\N
12	Wine - Magnotta, Merlot Sr Vqa	In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	$469.66	54	2023-11-24 11:22:32.219115	\N
13	Pheasants - Whole	Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.	$873.84	67	2023-11-24 11:22:32.222657	\N
14	Veal - Sweetbread	Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.	$213.09	58	2023-11-24 11:22:32.226839	\N
15	Wine - Periguita Fonseca	Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	$949.58	6	2023-11-24 11:22:32.238462	\N
16	Tilapia - Fillets	Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.	$636.66	85	2023-11-24 11:22:32.242282	\N
17	Veal - Inside Round / Top, Lean	\N	$651.80	45	2023-11-24 11:22:32.24494	\N
18	Fish - Bones	Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.	$465.76	57	2023-11-24 11:22:32.248403	\N
19	Green Tea Refresher	Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.	$828.75	47	2023-11-24 11:22:32.251889	\N
20	Bok Choy - Baby	Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.	$856.73	30	2023-11-24 11:22:32.255376	\N
\.


--
-- Data for Name: products_orders; Type: TABLE DATA; Schema: public; Owner: gmasquelier
--

COPY public.products_orders (product_uuid, order_number) FROM stdin;
8	1
5	1
16	1
20	1
6	2
11	2
3	3
1	4
20	4
13	4
16	5
19	5
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gmasquelier
--

COPY public.users (user_uuid, user_pseudo, username, user_password, created_at) FROM stdin;
1	Mélissandre	lagostini0	$2a$04$SeNROiidlERhKX8rYhiaju5xUF49Ix2B51YvsaGwZAiuA7jzOyEKu	2023-11-24 11:22:32.14508
2	Mélodie	msnailham1	$2a$04$ZS54bRJTafGF7E8DdGtErulQrZg4StUvWf0H8wCMAvzQ6/Ah9EPvO	2023-11-24 11:22:32.149014
3	Nadège	rwhitnell2	$2a$04$i8c3Oq5Xs3RUX.UJXxyZGOn3PIBt0ieLz4om69tZE2rjxMFi96wg2	2023-11-24 11:22:32.153667
4	Annotés	rmattheis3	$2a$04$yEAJJa6RK/.pYbikhRYbeuTRSfeR8BlHnUM1/7gU3aDi47/EEOxVG	2023-11-24 11:22:32.157085
5	Tú	owearne4	$2a$04$5s5NEUUkpOhEQ/.hGzup8.fNY7.hQ1czILxZqX5GZXlvHfw7FgSma	2023-11-24 11:22:32.160414
6	Irène	alouis5	$2a$04$CKVX2zjXiHpC60dMzvKMB.WIHbcAJgyaDrs7ejXvxYL58bHTgUX6i	2023-11-24 11:22:32.164207
7	Léana	cbenardet6	$2a$04$2whxmDF.0Hvfq1Wj.bjgiODCh64aT9oQMt5QJg0PukjnuWAY7zvAC	2023-11-24 11:22:32.167773
8	Anaé	lreek7	$2a$04$AjWue4xrGqerwi19tn6/Quj8uxgbY7riAQDeSnE7RRUsZZ8AP9lJC	2023-11-24 11:22:32.170662
9	Magdalène	oarnott8	$2a$04$P1yR9WaHi9UDIJRD3RuJRuw5cclyTkXSEqoAU3vLRFU5p7V/1AI/m	2023-11-24 11:22:32.174197
10	Aurélie	imcneill9	$2a$04$cM4RFpR8wNHXjTfJMRKDMeSH0V2lFFBQPZQryS3khenfoTkin0kvi	2023-11-24 11:22:32.177628
\.


--
-- Name: orders_order_number_seq; Type: SEQUENCE SET; Schema: public; Owner: gmasquelier
--

SELECT pg_catalog.setval('public.orders_order_number_seq', 2, true);


--
-- Name: products_product_uuid_seq; Type: SEQUENCE SET; Schema: public; Owner: gmasquelier
--

SELECT pg_catalog.setval('public.products_product_uuid_seq', 60, true);


--
-- Name: users_user_uuid_seq; Type: SEQUENCE SET; Schema: public; Owner: gmasquelier
--

SELECT pg_catalog.setval('public.users_user_uuid_seq', 30, true);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_number);


--
-- Name: products_orders products_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.products_orders
    ADD CONSTRAINT products_orders_pkey PRIMARY KEY (product_uuid, order_number);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_uuid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_uuid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: username_idx; Type: INDEX; Schema: public; Owner: gmasquelier
--

CREATE UNIQUE INDEX username_idx ON public.users USING btree (username);


--
-- Name: username_password_idx; Type: INDEX; Schema: public; Owner: gmasquelier
--

CREATE UNIQUE INDEX username_password_idx ON public.users USING btree (username, user_password);


--
-- Name: orders fk_orders_users; Type: FK CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_users FOREIGN KEY (user_uuid) REFERENCES public.users(user_uuid) ON DELETE RESTRICT;


--
-- Name: products_orders fk_products_orders_orders; Type: FK CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.products_orders
    ADD CONSTRAINT fk_products_orders_orders FOREIGN KEY (order_number) REFERENCES public.orders(order_number) ON DELETE RESTRICT;


--
-- Name: products_orders fk_products_orders_products; Type: FK CONSTRAINT; Schema: public; Owner: gmasquelier
--

ALTER TABLE ONLY public.products_orders
    ADD CONSTRAINT fk_products_orders_products FOREIGN KEY (product_uuid) REFERENCES public.products(product_uuid) ON DELETE RESTRICT;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: gmasquelier
--

GRANT SELECT ON TABLE public.orders TO store_auth;
GRANT SELECT ON TABLE public.orders TO store_products;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO store_orders;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO store_manager;
GRANT SELECT ON TABLE public.orders TO store_manager_users;
GRANT SELECT ON TABLE public.orders TO store_manager_products;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO store_manager_orders;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: gmasquelier
--

GRANT SELECT ON TABLE public.products TO store_auth;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products TO store_products;
GRANT SELECT ON TABLE public.products TO store_orders;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products TO store_manager;
GRANT SELECT ON TABLE public.products TO store_manager_users;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products TO store_manager_products;
GRANT SELECT ON TABLE public.products TO store_manager_orders;


--
-- Name: TABLE products_orders; Type: ACL; Schema: public; Owner: gmasquelier
--

GRANT SELECT ON TABLE public.products_orders TO store_auth;
GRANT SELECT ON TABLE public.products_orders TO store_products;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products_orders TO store_orders;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products_orders TO store_manager;
GRANT SELECT ON TABLE public.products_orders TO store_manager_users;
GRANT SELECT ON TABLE public.products_orders TO store_manager_products;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products_orders TO store_manager_orders;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: gmasquelier
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO store_auth;
GRANT SELECT ON TABLE public.users TO store_products;
GRANT SELECT ON TABLE public.users TO store_orders;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO store_manager;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO store_manager_users;
GRANT SELECT ON TABLE public.users TO store_manager_products;
GRANT SELECT ON TABLE public.users TO store_manager_orders;


--
-- PostgreSQL database dump complete
--

