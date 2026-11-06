select *
from alumnos
join matriculas using(id_alumno)
join cursos using(id_curso);

select *
from alumnos
join matriculas using(id_alumno)
join cursos using(id_curso);


-- vamos a obtener el listado de alumnos y matriculaciones dejando huecos.
select * 
from alumnos 
a left join matriculas m on a.id_alumno = m.id_alumno;

select * 
from alumnos 
a right join matriculas m on a.id_alumno = m.id_alumno;


select * 
from matriculas m right join alumnos a on m.id_alumno = a.id_alumno;


-- vamos con 3 tablas 
select *
from matriculas m left join alumnos a on m.id_alumno = a.id_alumno
left join cursos c on c.id_curso = m.id_curso;

select *
from matriculas m left join alumnos a on m.id_alumno = a.id_alumno      -- los left son individuales 
 join cursos c on c.id_curso = m.id_curso;


select *
from matriculas m left join alumnos a on m.id_alumno = a.id_alumno
right join cursos c on c.id_curso = m.id_curso;


-- saca el listado de matricuas en cursos inexistentes
select * 
from matriculas m left join cursos c on m.id_curso = c.id_curso
where c.id_curso is null;

-- saca el listado de cursos sin matriculas
select * 
from cursos c left join matriculas m on c.id_curso = m.id_curso
where m.id_matricula is null;

-- alumnos matriculasdos en cursos inexistentes
select *
from alumnos a right join matriculas m on a.id_alumno = m.id_alumno
left join cursos c on c.id_curso = m.id_curso
where c.id_curso is null ;

-- matriculas de alumnos inexistentes
select * 
from matriculas m left join alumnos a on m.id_alumno = a.id_alumno
where a.id_alumno is null;







