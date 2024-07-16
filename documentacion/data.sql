DROP TABLE IF EXISTS detalle;
DROP TABLE IF EXISTS boleta;
DROP TABLE IF EXISTS pedidodetalle;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS mesa;
DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipo;
DROP TABLE IF EXISTS usuariosesion;

CREATE TABLE usuariosesion (
  rut INTEGER PRIMARY KEY,
  dv VARCHAR(1) NOT NULL,
  nombre VARCHAR(250) NOT NULL,
  apellido VARCHAR(250) NOT NULL,
  pass varchar(250) NOT NULL,
  rol VARCHAR(10) NOT NULL
);

INSERT INTO usuariosesion (rut, dv, nombre, apellido, pass, rol) VALUES
(12345345, 'k', 'niko', 'munos', '123', 'ROLE_ADMIN'),
(11765432, '5', 'basty', 'apellido2', '123','ROLE_USER'),
(17887656, '2', 'eli', 'apellido3', '123', 'ROLE_USER');

CREATE TABLE tipo (
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	tipo VARCHAR(15) NOT NULL
);

INSERT INTO tipo (tipo) VALUES
('Combo'),
('Producto'),
('Extra');

CREATE TABLE producto (
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	tipo INTEGER NOT NULL,
	precioneto INTEGER NOT NULL,
	iva INTEGER NOT NULL,
	preciototal INTEGER NOT NULL,
	descripcion VARCHAR(100),
	disponibilidad boolean NOT NULL,
	stock INTEGER NOT NULL default 0,
	FOREIGN KEY(tipo) REFERENCES tipo(id) ON DELETE NO ACTION

);

INSERT INTO producto (nombre, precioneto, disponibilidad, tipo, iva, preciototal, stock, descripcion) VALUES
('Brasileño', 2800, true, 2, 532, 3332,3,'desc'),
('Cafe', 700, true,2, 133,833,0,'desc'),
('Palta', 500, true, 3, 95,595,-1,'desc'),
('Jugo Piña', 1500, false, 2, 285,1785,0,'desc asd'),
('Tozino', 500, true, 3, 95,595,-1,'desc');

CREATE TABLE estado(
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(20),
	estado INTEGER NOT NULL DEFAULT 1
);

INSERT INTO estado (nombre) VALUES
('Disponible'),
('Ocupada'),
('Pedido Pendiente'),
('Pedido Entregado'),
('Pedido Finalizado');

CREATE TABLE mesa(
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(20),
	estado INTEGER NOT NULL,
	fechaestado DATETIME NOT NULL DEFAULT NOW(),
	fechainicio DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY(estado) REFERENCES estado(id) ON DELETE NO ACTION
);


INSERT INTO mesa (nombre, estado) VALUES
('mesa 1', 1),
('mesa 3', 3),
('mesa 4', 5),
('mesa 5', 4),
('mesa 2', 2);

CREATE TABLE pedido (
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	idmesa INTEGER NOT NULL,
	fechacreacion DATETIME NOT NULL DEFAULT NOW(),
	total INTEGER NOT NULL DEFAULT 0,
	propina INTEGER NOT NULL DEFAULT 0,
	descuento INTEGER NOT NULL DEFAULT 0,
	creada INTEGER NOT NULL,
	estado INTEGER NOT NULL DEFAULT 3,
	FOREIGN KEY(creada) REFERENCES usuariosesion(rut) ON DELETE NO ACTION,
	FOREIGN KEY(idmesa) REFERENCES mesa(id) ON DELETE NO ACTION,
	FOREIGN KEY(estado) REFERENCES estado(id) ON DELETE NO ACTION
) ENGINE=innodb;

INSERT INTO pedido (idmesa,creada) VALUES
(1,11765432),
(3,11765432),
(5,11765432);

CREATE TABLE boleta (
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	idpedido INTEGER NOT NULL,
	fechacreacion DATETIME NOT NULL DEFAULT NOW(),
	totalneto INTEGER NOT NULL,
	iva INTEGER NOT NULL,
	consumo INTEGER NOT NULL,
	descuento INTEGER NOT NULL DEFAULT 0,
	propina INTEGER NOT NULL DEFAULT 0,
	total INTEGER NOT NULL,
	creada INTEGER NOT NULL,
	FOREIGN KEY(creada) REFERENCES usuariosesion(rut) ON DELETE NO ACTION,
	FOREIGN KEY(idpedido) REFERENCES pedido(id) ON DELETE NO ACTION
	
);

INSERT INTO boleta (idpedido, totalneto, iva,consumo, creada) VALUES
(1, 5800, 580, 6300,12345345 ),
(2, 2200, 0, 2200,12345345),
(3, 4000, 400, 4400,12345345);

CREATE TABLE pedidodetalle(
	id INTEGER NOT NULL,
	idpedido INTEGER NOT NULL,
	idproducto INTEGER NOT NULL,
	precio INTEGER NOT NULL DEFAULT 0,
	detalle VARCHAR(100),
	idsubdetalle INTEGER,
	estado INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY (id,idpedido),
	FOREIGN KEY(idpedido) REFERENCES pedido(id) ON DELETE NO ACTION,
	FOREIGN KEY(idproducto) REFERENCES producto(id) ON DELETE NO ACTION,
	FOREIGN KEY(estado) REFERENCES estado(id) ON DELETE NO ACTION

);

INSERT INTO pedidodetalle (id,idpedido,idproducto,precio,detalle,idsubdetalle) VALUES
(1,1,1,3332,null,null),
(2,1,4,1785,null,null),
(3,1,5,595,'extra',1);
