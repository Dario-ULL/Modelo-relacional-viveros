/* Crear la base de datos */
CREATE DATABASE viveros;
\c viveros;

CREATE TABLE Vivero (
    codigo_vivero SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    latitud DECIMAL(9,6) NOT NULL CHECK (latitud BETWEEN -90 AND 90),
    longitud DECIMAL(9,6) NOT NULL CHECK (longitud BETWEEN -180 AND 180)
);

CREATE TABLE Empleado (
    codigo_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    dni VARCHAR(10) UNIQUE NOT NULL,
    codigo_vivero INT,
    FOREIGN KEY (codigo_vivero) REFERENCES Vivero(codigo_vivero) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabla auxiliar para el historico de puesto (atributo multivaluado)
CREATE TABLE Historico_puesto (
    codigo_empleado INT, 
    codigo_vivero INT,
    fecha DATE NOT NULL,
    PRIMARY KEY (codigo_vivero, codigo_empleado),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado) ON DELETE SET NULL ON UPDATE CASCADE
    FOREIGN KEY (codigo_vivero) REFERENCES Vivero(codigo_vivero) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Zona (
    codigo_vivero INT,
    codigo_zona SERIAL,
    nombre VARCHAR(100) NOT NULL,
    latitud DECIMAL(9,6) NOT NULL CHECK (latitud BETWEEN -90 AND 90),
    longitud DECIMAL(9,6) NOT NULL CHECK (longitud BETWEEN -180 AND 180),
    PRIMARY KEY (codigo_vivero, codigo_zona),
    FOREIGN KEY (codigo_vivero) REFERENCES Vivero(codigo_vivero) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Producto (
    codigo_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    descripcion TEXT
);

CREATE TABLE Cliente_fidelizado (
    codigo_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro DATE NOT NULL,
    bonificacion DECIMAL(5,2) DEFAULT 0.0
);

-- Crear la función que calcula la bonificación
CREATE OR REPLACE FUNCTION calcular_bonificacion()
RETURNS TRIGGER AS $$
BEGIN
    NEW.bonificacion := LEAST(
        FLOOR(EXTRACT(YEAR FROM AGE(CURRENT_DATE, NEW.fecha_registro)) / 5) * 5,
        30
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que llama a la función antes de cada inserción o actualización
CREATE TRIGGER trigger_calcular_bonificacion
BEFORE INSERT OR UPDATE ON Cliente_fidelizado
FOR EACH ROW
EXECUTE FUNCTION calcular_bonificacion();

CREATE TABLE Pedido (
    codigo_pedido SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    codigo_empleado INT,
    codigo_cliente INT,
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (codigo_cliente) REFERENCES Cliente_fidelizado(codigo_cliente) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Pedido_Producto (
    codigo_pedido INT,
    codigo_producto INT,
    FOREIGN KEY (codigo_pedido) REFERENCES Pedido(codigo_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (codigo_pedido, codigo_producto)
);

CREATE TABLE Zona_Producto (
    codigo_vivero INT,
    codigo_zona INT,
    codigo_producto INT,
    stock INT NOT NULL CHECK (stock >= 0),
    FOREIGN KEY (codigo_vivero, codigo_zona) REFERENCES Zona(codigo_vivero, codigo_zona) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (codigo_vivero, codigo_zona, codigo_producto)
);

CREATE TABLE Empleado_Zona (
    codigo_vivero INT,
    codigo_empleado INT,
    codigo_zona INT,
    PRIMARY KEY (codigo_empleado, codigo_zona),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo_vivero, codigo_zona) REFERENCES Zona(codigo_vivero, codigo_zona) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE OR REPLACE FUNCTION verificar_empleado_pertenece_a_vivero()
RETURNS TRIGGER AS $$
DECLARE
    empleado_vivero INT;
    zona_vivero INT;
BEGIN
    -- Obtener el código de vivero asociado al empleado
    SELECT codigo_vivero INTO empleado_vivero 
    FROM Empleado 
    WHERE codigo_empleado = NEW.codigo_empleado;
    -- Obtener el código de vivero asociado a la zona
    SELECT codigo_vivero INTO zona_vivero 
    FROM Zona 
    WHERE codigo_zona = NEW.codigo_zona;
    -- Comprobar que el vivero del empleado y de la zona sean iguales
    IF empleado_vivero IS DISTINCT FROM zona_vivero THEN
        RAISE EXCEPTION 'El empleado no pertenece al vivero de la zona especificada.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_empleado_vivero
BEFORE INSERT ON Empleado_Zona
FOR EACH ROW
EXECUTE FUNCTION verificar_empleado_pertenece_a_vivero();
