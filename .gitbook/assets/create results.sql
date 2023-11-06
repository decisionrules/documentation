-- Table: public.results

-- DROP TABLE IF EXISTS public.results;

CREATE TABLE IF NOT EXISTS public.results
(
    finalprice double precision,
    crudeprice double precision,
    message character varying(100) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.results
    OWNER to postgres;