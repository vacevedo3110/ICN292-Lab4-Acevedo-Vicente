-- ICN, Laboratorio 4, Vicente Acevedo
DROP DATABASE if exists austral;
Create database austral;           
USE austral;                      

CREATE TABLE autores (
id_autor INT auto_increment,
nombre VARCHAR (80) NOT NULL, 
pais VARCHAR(60), 
genero ENUM ('Cómic', 'Ensayo', 'Infantil', 'Novela', 'Poesía') NOT NULL,
Primary key (id_autor)
);

CREATE TABLE colecciones (
id_coleccion INT auto_increment,
titulo VARCHAR(120) NOT NULL,
fecha_publicacion DATE NOT NULL, 
PRIMARY key (id_coleccion)
);

CREATE table libros (
id_libro INT AUTO_increment,
id_autor INT NOT NULL, 
id_coleccion INT,
titulo VARCHAR(120) NOT NULL,
paginas INT, 
ejemplares_vendidos INT, 
anio INT,
primary key (id_libro),
FOreign key ( id_autor)
REFerences autores (id_autor),
foreign key (id_coleccion)
References colecciones ( id_coleccion)
);

CREATE table pagos (
id_pago INT auto_increment,
id_autor INT not null,
fecha_pago DATE NOT NULL, 
monto DECIMAL(10,2) NOT NULL, 
primary key (id_pago),
foreign key (id_autor)
REferences autores ( id_autor)
);

INSERT INTO autores (nombre, pais, genero) VALUES
('Elena Pizarro',     'Chile',          'Novela'),
('Harold Finch',      'Inglaterra',     'Ensayo'),
('Rodrigo Bahamonde', 'Chile',          'Poesía'),
('Valentina Correa',  'Argentina',      'Infantil'),
('Nora Keller',       'Estados Unidos', 'Novela'),
('Kenji Arakawa',     NULL,             'Cómic');

Insert into libros (id_autor, titulo, paginas, ejemplares_vendidos, anio) VALUES
(1, 'Cielo de Enero', 210, 1500, 2024), (1, 'Marea Baja', 185, 800, 2023),
(1, 'El Norte', 200, 2200, 2024), (2, 'Estrellas que Caen', 240, 3000, 2022), 
(2, 'Máquinas', 215, 450, 2024), (3, 'Luz Artificial', 300, 1200, 2024), (3, 'Ruido Blanco', 280, 600, 2023), (4, 'El Barrio de Lila', 190, 5000, 2024), (4, 'Antes del Amanecer', 205, 2700, 2024), ( 4, 'La Calle 8', 175, 900, 2023), (5, 'Flor de Hierro', 195, 4100, 2024), (5, 'Hora Dorada', 220, 1800, 2022); 
  
--   Final de construccion de tablas.
-- Ahora las consultas. 

-- Consulta 1:
Select nombre, genero
FROM autores
where pais <> 'Chile' or pais IS NULL
ORDER by nombre; 

-- CONSULTA 2: 
SELECT titulo, paginas
from libros
where paginas between 190 and 220
order by paginas; 

-- Consulta 3:
Select count(*) AS total_libros, 
SUM(ejemplares_vendidos) AS total_ejemplares,
AVG(paginas) AS promedio_paginas, 
min(anio) AS anio_mas_antiguo,
max(ejemplares_vendidos) AS max_ejemplares_vendidos
FROM libros; 

-- Consulta 4:
Select  Distinct genero 
from autores
order by genero; 

-- Consulta 5:
SELECT a.nombre, COUNT(*) AS libros_2024
FROM   autores a
JOIN   libros l ON a.id_autor = l.id_autor
WHERE  l.anio = 2024
GROUP BY a.id_autor, a.nombre
HAVING COUNT(*) > 1
ORDER BY a.nombre;

-- Consulta 6:
Select titulo, ejemplares_vendidos
from libros
where anio =2024 and ejemplares_vendidos> 2000
order by ejemplares_vendidos DESC limit 3; 



-- Consulta 7: 
Insert into libros (id_autor, titulo, paginas, ejemplares_vendidos, anio) 
VALUES( 3, 'Papel Mojado', 260, 50, 2024);

Select * from libros where titulo = 'Papel Mojado';
Delete from libros where titulo = 'Papel Mojado';
Select * from libros where titulo = 'Papel Mojado';

-- Consulta 8:
SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';

UPDATE libros
SET    ejemplares_vendidos = ejemplares_vendidos + 100
WHERE  titulo = 'Cielo de Enero';

SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';



-- Consulta 9: 
INSERT INTO colecciones (titulo, fecha_publicacion) VALUES
('Narrativa Austral',   '2022-03-15'),   
('Pensamiento y Verso', '2022-09-01'),   
('Austral Infantil',    '2023-04-23');   

UPDATE libros SET id_coleccion = 1 WHERE id_autor = 1 OR id_autor = 5; 
UPDATE libros SET id_coleccion = 2 WHERE id_autor = 2 OR id_autor = 3; 
UPDATE libros SET id_coleccion = 3 WHERE id_autor = 4;                 

SELECT l.titulo            AS libro,
       c.titulo            AS coleccion,
       c.fecha_publicacion AS fecha_coleccion
FROM   libros l
JOIN   colecciones c ON l.id_coleccion = c.id_coleccion
ORDER BY c.fecha_publicacion, l.titulo;



 -- Consulta 10: 
 INSERT INTO pagos (id_autor, fecha_pago, monto) VALUES
(4, '2026-03-31', 850000.00),
(1, '2026-04-15', 420500.50),
(4, '2026-06-30', 610250.75),
(5, '2026-07-10', 735000.00);

-- 10a: cada pago con autor, fecha y monto
SELECT a.nombre AS autor, p.fecha_pago, p.monto
FROM   pagos p
JOIN   autores a ON p.id_autor = a.id_autor
ORDER BY p.fecha_pago;





