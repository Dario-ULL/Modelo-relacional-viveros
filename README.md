# Modelo-relacional-viveros

## 1. Entidades:

     - Vivero (codigo_vivero, nombre, latitud, longitud);
     - Empleado (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad);
     - Pedido (codigo_pedido, fecha, codigo_empleado, codigo_cliente);
     - Cliente_fidelizado (codigo_cliente, nombre, primer_apellido, segundo_apellido, bonificacion, telefono, fecha_registro, compra_total, fecha);
     - Zona ((codigo_vivero, codigo_zona), nombre, latitud, longitud, productividad);
     - Producto (codigo_producto, nombre, precio, descripción);
     - Historico_puesto (codigo_empleado, codigo_vivero, fecha);

## 2. Relaciones: 

### 1. Relacion Debil
     - vivero-zona ((codigo_vivero, codigo_zona), nombre, latitud, longitud, productividad);
La entidad Zona es débil por lo que la tabla del mismo se genera usando como clave primaria codigo_vivero(FK) de Vivero y codigo_zona.

### 2. Relaciones 1:N

     - vivero-empleado [Empleado] (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad, codigo_vivero(FK));
La relacion vivero-empleado propaga el atributo codigo_vivero(FK) a la relacion empleado. También debería propagarse historico_puesto pero debido a que es un atributo multivaluado se crea una nueva tabla específica.

     - zona-empleado [Empleado] (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad, codigo_vivero(FK), (codigo_vivero, codigo_zona)(FK), tarea);
La relacion zona-empleado propaga los atributos (codigo_vivero, codigo_zona)(FK) y tarea a la relacion empleado.

     - empleado-pedido [Pedido] (codigo_pedido, fecha, codigo_empleado(FK));
La relacion empleado-pedido propaga el atributo codigo_empeado(FK) a la relacion pedido.

     - cliente_fidelizado-pedido [Pedido] (codigo_pedido, fecha, codigo_cliente(FK));
La relacion cliente_fidelizado-pedido propaga el atributo codigo_cliente(FK) a la relacion pedido.

### 3. Relaciones N:M (Tabla)
     - producto_pedido (codigo_producto, codigo_pedido);
La relacion producto_pedido usa las dos claves primarias de producto y de pedido.

     - zona_producto (codigo_zona, codigo_vivero, codigo_producto, stock);
La relacion zona_producto usa las dos claves primarias de zona y de producto ademas del atributo stock.

