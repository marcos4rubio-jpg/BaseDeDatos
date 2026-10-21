-- AQUÍ SOLO ESTÁN LAS CONSULTAS QUE EJECUTAMOS PARA CONSTRUIR EL EXCEL.
-- MIRA EN EL AV EL EXCEL CON LOS RESULTADOS DE ESTAS CONSUTLAS Y LAS EXPLICACIONES.

SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos;


SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos
WHERE	pedidos.id_cliente = clientes.id_cliente;


SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos
WHERE	pedidos.id_cliente = clientes.id_cliente  AND	nombre LIKE '%Ana Torres%';


-- ej 2:

SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos
WHERE	pedidos.id_pedido = clientes.id_cliente;


-- ej 3: 
SELECT	
     productos.id_producto, productos.nombre,
	 detalle_pedido.id_detalle,detalle_pedido.id_pedido, detalle_pedido.id_producto, detalle_pedido.cantidad
FROM 	productos p ,detalle_pedido dp
WHERE detalle_pedido.id_producto = productos.id_producto;

-- version resumida 1:

SELECT	
     p.id_producto, p.nombre,
	 dp.id_detalle,dp.id_pedido, dp.id_producto, dp.cantidad
FROM 	productos AS p ,detalle_pedido AS dp
WHERE dp.id_producto = p.id_producto;


-- EJ 4
SELECT 
	c.id_cliente,c.nombre,dp.id_producto,dp.cantidad
    
FROM clientes as c, detalle_pedido as dp, pedidos as p
WHERE p.id_pedido = dp.id_pedido AND p.id_cliente = c.id_cliente;

-- ej 5
-- version cutre
select pr.nombre, pr.id_producto, pe.fecha_pedido
from pedidos as pe, productos as pr, detalle_pedido as dp
where pe.id_pedido = dp.id_pedido and pr.id_producto =dp.id_producto;

-- version pro 1 (hay varias, cada una mejor que la anterior)
select * 
from 
	pedidos pe 
		join 
    detalle_pedido dp on pe.id_pedido = dp.id_pedido
		join 
	productos pr on dp.id_producto = pr.id_producto;

-- version pro 2
select * 
from 
	pedidos pe 
		join 
    detalle_pedido dp using(id_pedido) -- solo si la columna se llama igual en las dos tablas
		join 
	productos pr using(id_producto);

-- saca el listado de productos (nombre e id) y el nombre de los clientes que los han comprado.

-- 1) que necesito?
-- clientes.nombre
-- productos.nombre
-- necesito para unir: 
-- productos -> detalle_pedido -> pedidos -> clientes

-- 2) que columnas unen?
-- productos -> detalle_pedido (id_producto)
-- detalle_pedido -> pedidos (id_pedido)
-- pedidos -> clientes (id_cliente)

-- tip: el fallo comun es poner como condicion id_pedido = id_producto (que noo tiene sentido pero funciona)

select productos.nombre,productos.id_producto,clientes.nombre
from productos
	join detalle_pedido using(id_producto)
	join pedidos using(id_pedido)
	join clientes using(id_cliente);
    
    
    -- saca los productos(nombre) que se encuentren en un estado de pedido cancelado
    
    select productos.nombre, pedidos.estado
    from productos
		join detalle_pedido using(id_producto)
        join pedidos using(id_pedido)
        where estado like '%cancelado%';
        
-- cuantos clientes han hecho algun pedido de cada categoria
 select categoria,count(id_cliente)
    from productos
		join detalle_pedido using(id_producto)
        join pedidos using(id_pedido)
        join clientes using(id_cliente)
        group by categoria;                -- este cuenta los clienres repetidos
        
        
 select categoria,count(distinct id_cliente)
    from productos
		join detalle_pedido using(id_producto)
        join pedidos using(id_pedido)
        join clientes using(id_cliente)
        group by categoria;       


		
    





