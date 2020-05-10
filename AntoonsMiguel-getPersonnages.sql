/*La Procédure*/

ALTER PROCEDURE "dba"."proc_getPersonnages"(in genre long varchar)
Result(ID char(3), nom varchar(30), prenom varchar(30), description long varchar, image long varchar)
BEGIN

    declare input1 char(3);
    declare input2 char(3);
    declare input3 char(3);
    declare input4 char(3);
    declare input5 char(3);


    set input1 = (select row_value from sa_split_list(genre) where line_num = 1);
    set input2 = (select row_value from sa_split_list(genre) where line_num = 2);
    set input3 = (select row_value from sa_split_list(genre) where line_num = 3);
    set input4 = (select row_value from sa_split_list(genre) where line_num = 4);
    set input5 = (select row_value from sa_split_list(genre) where line_num = 5);

    select pers.IdPersonnage as ID, pers.Nom as nom, pers.Prenom as prenom, pers.Description as description, pers.Image as image
        from dba.Personnages as pers
        join dba.Genres as genr on pers.IdGenre = genr.IdGenre
        where  pers.IdGenre = input1 or pers.IdGenre = input2 or pers.IdGenre = input3 or pers.IdGenre = input4 or pers.IdGenre = input5
        order by rand();
end

/*Le Web Service*/

CREATE SERVICE "serv_getPersonnages"
TYPE 'JSON'
AUTHORIZATION OFF
USER "DBA"
URL ON
METHODS 'GET'
AS call dba.proc_Personnages(:genre);
