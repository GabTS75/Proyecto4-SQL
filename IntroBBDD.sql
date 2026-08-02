-- Proyecto 4: SQL — Base de Datos DEMO de "Airlines"
-- ==================================================

-- 1. Escribe una consulta que recupere los Vuelos (flights) y su identificador
-- que figuren con status On Time.

-- Desarrollo:

SELECT
    flight_id,
    route_no,
    status
FROM
    Flights
WHERE
    status = 'On Time';

-- NOTA:
-- agregué la columna route_no siguiendo tu sugerencia.
-- comillas simples para comparar cadenas de texto (literales).
-- ==================================================

-- 2. Escribe una consulta que extraiga todas las columnas de la tabla bookings
-- y refleje todas las reservas que han supuesto una cantidad total mayor a
-- 1.000.000 (Unidades monetarias). ¡Ojo! 6 ceros (no hay info).

-- Desarrollo:

SELECT
    *
FROM
    Bookings
WHERE
    total_amount > 1000000;

-- NOTA:
-- Los números en SQL se escriben sin comillas y sin puntos para miles.
-- ==================================================

-- 3. Escribe una consulta que extraiga todas las columnas de los datos de los
-- modelos de aviones disponibles (aircraft_data). Puede que os aparezca en
-- alguna actualización como “aircrafts_data”, revisad las tablas y elegid la
-- que corresponda.

-- Desarrollo:

SELECT
    *
FROM
    Airplanes_data;

-- NOTA:
-- Uso el (*) para seleccionar todas las columnas como pide el enunciado.
-- ==================================================

-- 4. Con el resultado anterior visualizado previamente, escribe una consulta
-- que extraiga los identificadores de vuelo que han volado con un Boeing 737.
-- (Código Modelo Avión = 733).

-- Desarrollo:

SELECT
    f.flight_id,
    r.airplane_code
FROM
    Flights f
    JOIN Routes r ON f.route_no = r.route_no
WHERE
    r.airplane_code = '733';

-- NOTA:
-- agregué la columna airplane_code para mostra el dato '733' (que no encuentra).
-- Alternativa con Subconsulta (IN):
-- SELECT 
--     flight_id 
-- FROM 
--     Flights
-- WHERE 
--     route_no IN (
--         SELECT 
--             route_no 
--         FROM 
--             Routes
--         WHERE 
--             airplane_code = '789' -- (si encontramos)
--     );
-- ==================================================

-- 5. Escribe una consulta que te muestre la información detallada de los
-- tickets que han comprado las personas que se llaman Irina.

-- Desarrollo:

SELECT
    *
FROM
    Tickets
WHERE
    passenger_name ILIKE '%Irina%';

-- NOTA:
-- Usando ILIKE '%Irina%' buscamos la palabra "Irina" dentro del nombre del
-- pasajero, sin considerar si está al inicio, en medio o al final (los %) e
-- ignorando mayúsculas y minúsculas con ILIKE.
-- ==================================================

-- 6. Mostrar las ciudades con más de un aeropuerto.

-- Desarrollo:

SELECT
    city,
    COUNT(airport_code) AS total_aeropuertos
FROM
    Airports_data
GROUP BY
    city
HAVING
    COUNT(airport_code) > 1;

-- NOTA:
-- Usando GROUP BY city, logro agrupar todos los registros que pertenecen a
-- la misma ciudad.
-- El COUNT(airport_code), cuenta los aeropuertos en cada grupo.
-- Y con el HAVING, filtro los grupos después de agruparlos (a diferencia
-- de WHERE, que filtra filas individuales antes de agrupar).
-- ==================================================

-- 7. Mostrar el número de vuelos por modelo de avión.

-- Desarrollo:

SELECT
    a.model,
    COUNT(f.flight_id) AS total_vuelos
FROM
    Flights f
    JOIN Routes r ON f.route_no = r.route_no
    JOIN Airplanes_data a ON r.airplane_code = a.airplane_code
GROUP BY
    a.model;

-- NOTA:
-- Para unir las 3 tablas que necesito con JOIN
-- FROM TablaA a
-- JOIN TablaB b ON a.clave_comun = b.clave_comun
-- JOIN TablaC c ON b.otra_clave_comun = c.otra_clave_comun
-- ==================================================

-- 8. Reservas con más de un billete (varios pasajeros).

-- Desarrollo:

SELECT
    book_ref,
    COUNT(ticket_no) AS total_tickets
FROM
    Tickets
GROUP BY
    book_ref
HAVING
    COUNT(ticket_no) > 1
ORDER BY
    total_tickets DESC;

-- NOTA:
-- Similar al ejercicio 6, además agrago ORDER BY para visualizar de mayor
-- a menor, usando DESC (ascendente "ASC" es el valor por defecto)
-- ==================================================

-- 9. Vuelos con retraso de salida superior a una hora.

-- Desarrollo:

SELECT
    flight_id,
    route_no,
    scheduled_departure,
    scheduled_arrival,
    actual_departure,
    actual_arrival
FROM
    Flights
WHERE
    actual_departure - scheduled_departure > INTERVAL '1 hour';

-- NOTA:
-- En PostgreSQL (y en SQL estándar), para que la base de datos sepa que
-- '1 hour' es un lapso de tiempo y no un texto plano, debemos escribir
-- antes la palabra clave INTERVAL.
