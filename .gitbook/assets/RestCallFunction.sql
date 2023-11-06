CREATE OR REPLACE FUNCTION py_pgrest(p_url text, p_method text DEFAULT 'POST'::text, p_data text DEFAULT ''::text, p_headers text DEFAULT '{"Content-Type": "application/json"}'::text)
 RETURNS text
 LANGUAGE plpython3u
AS $function$
    import requests, json
    try:
        r = requests.request(method=p_method, url=p_url, data=p_data, headers=json.loads(p_headers))
    except Exception as e:
        return e
    else:
        return r.text
$function$
;