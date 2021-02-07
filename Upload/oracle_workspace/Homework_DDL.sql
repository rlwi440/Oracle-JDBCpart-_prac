/*
1. 계열 정보를 저장한 카테고리 테이블을 만들려고 핚다. 다음과 같은 테이블을
작성하시오.
테이블 이름
TB_CATEGORY
컬럼
NAME, VARCHAR2(10)
USE_YN, CHAR(1), 기본값은 Y 가 들어가도록
*/
create table TB_CATEGORY(
name varchar2(10),
use_yn char(1) default 'Y'
);
 /*
 2. 과목 구분을 저장핛 테이블을 만들려고 핚다. 다음과 같은 테이블을 작성하시오.
테이블이름
TB_CLASS_TYPE
컬럼
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)
*/
create table tb_class_type(
no varchar2(5),
name varchar2(10),
constraint pk_tb_class_type_no primary key(no)
);
/*
서브 명령어
-add 컬럼,제약조건 추가
-modify 컬럼(자료형,기본값)변경(제약조건 변경불가)
-rename 컬럼명, 제약조건명 변경
-drop 컬럼, 제약조건 삭제
*/

/*
3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
(KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이를 지정하고자 한다면 이름은 본인이
알아서 적당핚 이름을 사용한다.)
*/
alter table tb_category add constraint pk_tb_category_name primary key(name);

/*
4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
*/
alter table tb_class_type modify name varchar(10) not null; --NAME , VARCHAR2(10)

/*
5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
NAME 인 것은 마찪가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
*/
alter table TB_CLASS_TYPE modify no varchar2(10); 
alter table TB_CATEGORY modify name varchar2(20);
alter table TB_CLASS_TYPE modify name varchar2(20);


/*
6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외핚 테이블 이름이 앞에
붙은 형태로 변경핚다.
(ex. CATEGORY_NAME)
*/
alter table  tb_category rename column name to category_name;
alter table tb_class_type rename column name to class_type_no;
alter table tb_class_type rename column name to class_type_name;

/*
7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이
변경하시오.
Primary Key 의 이름은 PK_ + 컬럼이름으로 지정하시오. (ex. PK_CATEGORY_NAME )
*/
alter table TB_CATEGORY rename constraint pk_tb_category_name to PK_CATEGORY_NAME;
alter table TB_CLASS_TYPE rename constraint pk_tb_class_type_no to PK_CLASS_TYPE_NO;

/*
8. 다음과 같은 INSERT 문을 수행한다.
*/
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

/*
9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모
값으로 참조하도록 FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은
FK_테이블이름_컬럼이름으로 지정핚다. (ex. FK_DEPARTMENT_CATEGORY )
*/
alter table TB_DEPARTMENT add constraint FK_DEPARTMENT_CATEGORY foreign key(category) references TB_CATEGORY(CATEGORY_NAME);
--references 다른테이블

/*
10. 춘 기술대학교 학생들의 정보맊이 포함되어 있는 학생일반정보 VIEW 를 만들고자 핚다.
아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오.
뷰 이름
VW_학생일반정보
컬럼
학번
학생이름
주소
*/

create view VM_학생일반정보
as
select student_no 학번,
           student_name 학생이름,
           student_address 주소 
    from tb_student;
/*
11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행핚다.
이를 위해 사용한  학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 맊드시오.
이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT
만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
뷰 이름
VW_지도면담
컬럼
학생이름
학과이름
지도교수이름
*/
create view VW_지도면담
as
select s.student_name 학생이름, 
       (select department_name from tb_department where department_no = s.department_no) 학과이름,
       p.professor_name 담당교수이름
from tb_student s join tb_professor p
on s.department_no = p.department_no
where s.coach_professor_no is not null
order by 2;

/*
12. 모든 학과의 학과별 학생 수를 확인핛 수 있도록 적절한 VIEW 를 작성해 보자.
뷰 이름
VW_학과별학생수
컬럼
DEPARTMENT_NAME
STUDENT_COUNT
*/
create view VW_학과별학생수
as
select (select department_name from tb_department where department_no = s.department_no) DEPARTMENT_NAME,
        count(*) STUDENT_COUNT
from tb_student s
group by department_no;

/*
13. 위에서 생성핚 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인
이름으로 변경하는 SQL 문을 작성하시오.
*/
select *
from  VM_학생일반정보

update VW_학생일반정보 set 학생이름 = '배기원'       --본인이름 '배기원'
where 학번 = 'A213046';

/*14. 13 번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를
어떻게 생성해야 하는지 작성하시오.
*/

create view VM_학생일반정보
as 
select student_no 학번,
          stuent_name 학생이름,
          student_address 주소
    from tb_student
    with read only;     --기본 테이블의 어떤 컬럼에 대해서도 뷰를 통한 내용 수정을 불가능하게 만드는 옵션이다.
    
/*
    15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려
문제가 되고 있다. 최근 3 년을 기준으로 수강인원이 가장 맋았던 3 과목을 찾는 구문을
작성해보시오.
과목번호 과목이름 누적수강생수(명)
---------- ------------------------------ ----------------
C1753800 서어방언학 29
C1753400 서어문체롞 23
C2454000 원예작물번식학특론 22
*/
select *
from (
        select c.class_name, count(*)
        from tb_grade g join tb_class c on g.class_no = c.class_no
        where substr(term_no,1,4) in (
                                                        select *
                                                        from ( select distinct(substr(term_no,1,4))      
                                                                    from tb_grade
                                                                    order by 1 desc)
                                                        where rownum between 1 and 3)        --rownum :테이블 레코드 추가시 1부터 1씩증가하면서 부여된 일련번호,부여된 번호는 변경불가
                                                         group by c.class_name
                                                        order by 2 desc)
                                                        where rownum between 1 and 3;