-- Tabla de productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0)
);

-- Tabla de clientes
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255)
);

-- Tabla de ventas (una venta puede incluir varios productos)
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL REFERENCES clientes(cliente_id),
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla detalle_ventas para relacionar ventas con productos
CREATE TABLE detalle_ventas (
    detalle_id SERIAL PRIMARY KEY,
    venta_id INT NOT NULL REFERENCES ventas(venta_id) ON DELETE CASCADE,
    producto_id INT NOT NULL REFERENCES productos(producto_id),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0)
);

-- Insertar productos
INSERT INTO productos (nombre, precio) VALUES 
('Portatil Asus', 1200000), 
('Mouse Genius', 25990), 
('Teclado Mecánico Corsair', 45990);

-- Insertar clientes
INSERT INTO clientes (nombre, direccion) VALUES 
('Harold Bolaños', 'Calle 123, Ciudad A'),
('Stefania Cordoba', 'Avenida 456, Ciudad B');

-- Insertar ventas (transacciones de compra)
INSERT INTO ventas (cliente_id) VALUES 
(1), -- Venta 1: Cliente Harold Bolaños
(2); -- Venta 2: Cliente 'Stefania Cordoba

-- Insertar detalles de ventas (productos vendidos en cada venta)
INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, subtotal) VALUES 
(1, 1, 1, (SELECT precio FROM productos WHERE producto_id = 1) * 1), -- Harold Bolaños compra 1 Portatil Asus
(1, 2, 2, (SELECT precio FROM productos WHERE producto_id = 2) * 2),  -- Harold Bolaños compra 2 Mouse Genius
(2, 3, 1, (SELECT precio FROM productos WHERE producto_id = 3) * 1);  -- 'Stefania Cordoba compra 1 Teclado Mecánico
