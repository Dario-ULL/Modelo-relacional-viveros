# Modelo-relacional-viveros

## 1. Entidades:

     - vivero (codigo_vivero, nombre, latitud, longitud);
     - empleado (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad);
     - pedido (codigo_pedido, fecha, codigo_empleado, codigo_cliente);
     - cliente_fidelizado (codigo_cliente, nombre, primer_apellido, segundo_apellido, bonificacion, telefono, fecha_registro, compra_total, fecha);
     - zona (codigo_zona, nombre, latitud, longitud, productividad);
     - producto (codigo_producto, nombre, precio, descripción);
     - historico_puesto (codigo_empleado, codigo_vivero, fecha);

## 2. Relaciones: 

### 1. Relacion Debil
     - vivero-zona (codigo_vivero, codigo_zona, nombre, latitud, longitud, productividad);

### 2. Relaciones 1:N

     - vivero-empleado [Empleado] (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad, \_codigo_vivero(FK)\_, \_historico_puesto\_);
La relacion vivero-empleado propaga los atributos codigo_vivero(FK) e historico_puesto a la relacion empleado.

     - zona-empleado [Empleado] (codigo_empleado, \_codigo_zona(FK)\_, \_codigo_vivero\_);
La relacion zona-empleado propaga los atributos codigo_zona(FK) y tarea a la relacion empleado.

     - empleado-pedido [Pedido] (codigo_pedido, fecha, \_codigo_empleado(FK)\_);
La relacion empleado-pedido propaga los atributos codigo_empeado(FK) a la relacion pedido.

     - cliente_fidelizado-pedido [Pedido] (codigo_pedido, fecha, \_codigo_cliente(FK)\_);
La relacion cliente_fidelizado-pedido propaga los atributos _codigo_cliente(FK) a la relacion pedido.

### 3. Relaciones N:M (Tabla)
     - producto_pedido (codigo_producto, codigo_pedido);
La relacion producto_pedido usa las dos claves primarias de producto y de pedido.

     - zona_producto (codigo_zona, codigo_vivero, codigo_producto, stock);
La relacion zona_producto usa las dos claves primarias de zona y de producto ademas del atributo stock.

