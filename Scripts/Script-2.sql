-- Mostrar todas las tablas en ambos esquemas
SELECT schemaname, tablename FROM pg_tables WHERE schemaname IN ('ventas', 'clientes');

-- Verificar clientes y direcciones
SELECT * FROM clientes.clientes;
SELECT * FROM clientes.direcciones;

-- Verificar productos y pedidos
SELECT * FROM ventas.productos;
SELECT * FROM ventas.pedidos;

-- Verificar detalles de pedidos y subtotal calculado
SELECT * FROM ventas.detalle_pedidos;

-- Contar la cantidad de pedidos de cada cliente
SELECT cliente_id, COUNT(*) AS total_pedidos FROM ventas.pedidos GROUP BY cliente_id;