-- Ver los esquemas creados
SELECT schema_name FROM information_schema.schemata;



BEGIN;
DO $$ 
DECLARE venta_id INT;
BEGIN
    -- Insertar la venta
    INSERT INTO ventas.ventas (cliente_id) VALUES (1) RETURNING id INTO venta_id;

    -- Insertar el detalle de la venta (Producto 1: Laptop, 2 unidades)
    INSERT INTO ventas.detalle_ventas (venta_id, producto_id, cantidad, precio_unitario) 
    VALUES (venta_id, 1, 2, 1200.00);

    -- Insertar otro producto en la misma venta (Producto 2: Mouse, 1 unidad)
    INSERT INTO ventas.detalle_ventas (venta_id, producto_id, cantidad, precio_unitario) 
    VALUES (venta_id, 2, 1, 25.50);
END $$;
COMMIT;



BEGIN;

-- Insertar la venta y obtener el ID generado
WITH inserted_venta AS (
    INSERT INTO ventas.ventas (cliente_id) 
    VALUES (1) 
    RETURNING id
)
-- Insertar el detalle de la venta con el ID de la venta
INSERT INTO ventas.detalle_ventas (venta_id, producto_id, cantidad, precio_unitario) 
VALUES 
    ((SELECT id FROM inserted_venta), 1, 2, 1200.00),
    ((SELECT id FROM inserted_venta), 2, 1, 25.50);

COMMIT;


--Total de ventas por cliente
SELECT cliente_id, 
       (SELECT SUM(cantidad * precio_unitario) 
        FROM ventas.detalle_ventas dv 
        WHERE dv.venta_id = v.id) AS total_ventas
FROM ventas.ventas v
ORDER BY total_ventas DESC;


-- Producto más vendido
SELECT producto_id, 
       SUM(cantidad) AS total_vendido 
FROM ventas.detalle_ventas
WHERE producto_id IN (SELECT id FROM productos.productos)
GROUP BY producto_id
ORDER BY total_vendido DESC
LIMIT 1;


-- Clientes que han comprado al menos una vez
SELECT * FROM clientes.clientes 
WHERE id IN (SELECT cliente_id FROM ventas.ventas);


-- Productos que han sido vendidos
SELECT * FROM productos.productos
WHERE id IN (SELECT producto_id FROM ventas.detalle_ventas);


-- Última compra de cada cliente
SELECT cliente_id, MAX(fecha) AS ultima_compra
FROM ventas.ventas
GROUP BY cliente_id;

-- Indices
CREATE INDEX idx_nombre_cliente ON clientes.clientes(nombre);

EXPLAIN ANALYZE SELECT * FROM clientes.clientes WHERE nombre = 'Juan Pérez';


CREATE INDEX idx_email_cliente ON clientes.clientes(email);

EXPLAIN ANALYZE SELECT * FROM clientes.clientes WHERE email = 'juan@example.com';


CREATE INDEX idx_nombre_producto ON productos.productos(nombre);

EXPLAIN ANALYZE SELECT * FROM productos.productos WHERE nombre = 'Laptop';


CREATE INDEX idx_detalle_producto_venta ON ventas.detalle_ventas(producto_id, venta_id);

EXPLAIN ANALYZE SELECT * FROM ventas.detalle_ventas WHERE producto_id = 1 AND venta_id = 1;


CREATE INDEX idx_fecha_venta ON ventas.ventas(fecha);

EXPLAIN ANALYZE SELECT * FROM ventas.ventas WHERE fecha >= '2023-01-01' AND fecha <= '2023-12-31';



CREATE INDEX idx_nombre_direccion ON clientes(nombre, direccion_cliente);

CREATE INDEX idx_email_nombre ON clientes(email, nombre);

CREATE INDEX idx_email_direccion_cliente ON clientes(email, direccion_cliente);

CREATE INDEX idx_nombre_email_direccion ON clientes(nombre, email, direccion_cliente);

CREATE INDEX idx_nombre_email_reverse ON clientes(nombre DESC, email);

EXPLAIN ANALYZE SELECT * FROM clientes WHERE nombre = 'Juan Pérez' AND direccion_cliente = 'Calle Falsa 123';



SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'clientes';

EXPLAIN ANALYZE SELECT * FROM clientes WHERE nombre = 'Juan Pérez';

EXPLAIN ANALYZE 
SELECT c.nombre, p.nombre, dv.cantidad
FROM clientes.clientes c
INNER JOIN ventas.ventas v ON c.id = v.cliente_id
INNER JOIN ventas.detalle_ventas dv ON v.id = dv.venta_id
INNER JOIN productos.productos p ON dv.producto_id = p.id;

EXPLAIN ANALYZE 
SELECT c.nombre, p.nombre, dv.cantidad
FROM clientes.clientes c
LEFT JOIN ventas.ventas v ON c.id = v.cliente_id
LEFT JOIN ventas.detalle_ventas dv ON v.id = dv.venta_id
LEFT JOIN productos.productos p ON dv.producto_id = p.id;

EXPLAIN ANALYZE 
SELECT c.nombre, p.nombre, dv.cantidad
FROM clientes.clientes c
RIGHT JOIN ventas.ventas v ON c.id = v.cliente_id
RIGHT JOIN ventas.detalle_ventas dv ON v.id = dv.venta_id
RIGHT JOIN productos.productos p ON dv.producto_id = p.id;

EXPLAIN ANALYZE 
SELECT c.nombre, v.id AS venta_id
FROM clientes.clientes c
FULL OUTER JOIN ventas.ventas v ON c.id = v.cliente_id;

EXPLAIN ANALYZE 
SELECT c.nombre, p.nombre, dv.cantidad
FROM clientes.clientes c
LEFT JOIN ventas.ventas v ON c.id = v.cliente_id
RIGHT JOIN productos.productos p ON v.id = p.id
INNER JOIN ventas.detalle_ventas dv ON p.id = dv.producto_id;

--Vistas

CREATE OR REPLACE VIEW ventas.ventas_por_cliente AS
SELECT 
  c.nombre AS nombre_cliente, 
  SUM(dv.cantidad * p.precio) AS total_ventas
FROM clientes.clientes c
INNER JOIN ventas.ventas v ON c.id = v.cliente_id
INNER JOIN ventas.detalle_ventas dv ON v.id = dv.venta_id
INNER JOIN productos.productos p ON dv.producto_id = p.id
GROUP BY c.nombre;

-- Ver todos los datos de la vista
SELECT * FROM ventas.ventas_por_cliente;

-- Ver sólo los clientes con total de ventas mayores a $100 (verifica que el HAVING funcione)
SELECT * 
FROM ventas.ventas_por_cliente
ORDER BY total_ventas DESC;


CREATE OR REPLACE FUNCTION productos.insertar_producto(nombre_producto VARCHAR, precio NUMERIC)
RETURNS VOID AS $$
BEGIN
  INSERT INTO productos.productos(nombre, precio)
  VALUES (nombre_producto, precio);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM ventas.ventas_por_cliente;

CREATE OR REPLACE VIEW ventas.ventas_por_cliente AS
SELECT 
  c.nombre AS nombre_cliente, 
  SUM(dv.cantidad * p.precio) AS total_ventas
FROM clientes.clientes c
INNER JOIN ventas.ventas v ON c.id = v.cliente_id
INNER JOIN ventas.detalle_ventas dv ON v.id = dv.venta_id
INNER JOIN productos.productos p ON dv.producto_id = p.id
GROUP BY c.nombre
HAVING SUM(dv.cantidad * p.precio) > 100;

CREATE OR REPLACE FUNCTION clientes.insertar_cliente(
  nombre_cliente VARCHAR DEFAULT 'Desconocido', 
  direccion_cliente VARCHAR DEFAULT 'No especificada'
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO clientes.clientes(nombre, direccion)
  VALUES (nombre_cliente, direccion_cliente);
END;
$$ LANGUAGE plpgsql;



