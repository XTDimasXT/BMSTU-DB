CREATE OR REPLACE FUNCTION find_procedures_with_string(search_string TEXT) RETURNS TABLE (procedure_name TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT routine_name
    FROM information_schema.routines
    WHERE routine_type = 'PROCEDURE' OR routine_type = 'FUNCTION'
    AND routine_body LIKE 'SQL'
    AND routine_definition LIKE '%' || search_string || '%'
    AND routine_definition NOT LIKE '%OR REPLACE%'
    AND routine_schema = 'public';
END;
$$ LANGUAGE plpgsql;


-- Тесты

SELECT * FROM find_procedures_with_string('SELECT');
SELECT * FROM find_procedures_with_string('UPDATE');
SELECT * FROM find_procedures_with_string('INSERT INTO');