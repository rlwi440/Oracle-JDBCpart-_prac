--==========================
-- CHUN 계정
--==========================

-- 학과테이블
select * from tb_department;

--학생테이블
select * from tb_student;

--과목테이블
select * from tb_class;

--교수테이블
select * from tb_professor;

--교수과목테이블
select * from tb_class_professor;

--점수등급테이블
select * from tb_grade;

-- 첫번째 문제 
/* 춘 기술대학교의 학과 이름과 계열을 표시하시오.
  * 단, 출력 헤더는 "학과 명", "계열"으로
  * 표시하도록 한다.
  */
select
department_name"학과명",category"계열"
from tb_department;
--2번 문제
/*
학과의 학과 정원을 다음과같은
형태로 화면에 출력한다.
*/
select department_name || '의 정원은 '  || capacity  ||'명 입니다.' as "학과별 정원"
from 
tb_department;
--3번 문제
/* "국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생을
  * 찾아달라는 요청이 들어왔다. 누구인가?
  * (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 
  * 조회해서 찾아 내도록 하자)
  */
select
    student_name
from
    tb_student
where
    absence_yn = 'Y'
and
    student_ssn like '_______2%'
and
    department_no = (select department_no from tb_department where department_name = '국어국문학과');


  -- 4번 문제
/* 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 개시하고자 한다.
  * 그 대상자들의 학번이 다음과 같을 때 대상자들을
  * 찾는 적절한 SQL 구문을 작성하시오.
  * A513079, A513090, A513091, A513110, A513119
  */
select
    student_name
from
    tb_student
where
    student_no in ( 
        'A513079'
        , 'A513090'
        , 'A513091'
        , 'A513110'
        , 'A513119'
    )
order by
    student_name DESC;

-- 5번 문제
/* 입학정원이 20명 이상 30명 이하인 
  * 학과들의 학과 이름과 계열을 출력하시오.
  */
select
    department_name,
    category
from
    tb_department
where
    capacity between 20 and 30;
    
-- 6번 문제
/* 춘 기술대학교는 총장을 제외하고 모든 교수들이
  * 소속 학과를 가지고 있다. 그럼 춘 기술대학교 총장의
  * 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
  */
select
    professor_name
from
    tb_professor
where
    department_no is null;
    
-- 7번 문제
/* 혹시 전산상의 착오로 학과가 지정되어 있지 않은
  * 학생이 있는지 확인하고자 한다.
  * 어떠한 SQL 문장을 사용하면 될 것인지
  * 작성하시오.
  */
select
    student_name
from 
    tb_student
where
    department_no is null;
    
-- 8번 문제
/* 수강신청을 하려고 한다. 선수과목 여부를
  * 확인해야 하는데, 선수과목이 존재하는
  * 과목들은 어떤 과목인지 과목번호를
  * 조회해보시오.
  */
select
    class_no
from
    tb_class
where
    preattending_class_no is not null;
    
-- 9번 문제
/* 춘 대학에는 어떤 계열(CATEGORY)들이
  * 있는지 조회해보시오.
  */
select distinct
    category
from
    tb_department
order by
    category ASC;
    
-- 10번 문제
/* 02학번 전주 거주자들의 모임을 만들려고 한다.
  * 휴학한 사람들은 제외한 재학중인
  * 학생들의 학번, 이름, 주민번호를 출력하는
  * 구문을 작성하시오.
  */
select
    student_no,
    student_name,
    student_ssn
from
    tb_student
  where
    student_no like 'A2%'
and
    student_address like '%전주%'
and
    absence_yn = 'N';

  select * from tb_department; 
  select*from tb_student;
 --1. 학과테이블에서 계열별 정원의 평균을 조회(정원 내림차순 정렬)
 select  category 계열 ,trunc(avg(capacity))"정원의평균"               --category 계열 
 from tb_department
 group by category
 order by "정원의평균" desc;
 
 
 --2.학생테이블에서  이름별 평균 조회 
select student_name 이름,trunc(avg(Department_no))  "혼자해보는연습"
from tb_student
group by student_name
order by  "혼자해보는연습" desc;


 
 --1. 학과테이블에서 계열별 정원의 평균을 조회(정원 오름차순 정렬)
 select  category 계열 ,trunc(avg(capacity))"정원의평균"
 from tb_department
 group by category
 order by "정원의평균" asc;

--2. 휴학생을 제외하고, 학과별로 학생수를 조회(학과별 인원수 내림차순)
select department_no 학과번호, count(*) 학생수
from tb_student
where absence_yn != 'Y'
group by department_no
order by 학생수 desc;

--2. 휴학생을 포함해서 학과별로 학생수를 조회(학과별 인원수 오름차순)
select department_no 학과번호, count(*) 학생수
from tb_student
where absence_yn = 'N'   --다니고 있다 . 
group by department_no
order by 학생수 desc;


--3. 과목별 지정된 교수가 2명이상이 과목번호와 교수인원수를 조회
select class_no 과목번호, count(professor_no) 교수인원수
from tb_class_professor
group by class_no
having count(professor_no)>=2;

--4. 학과별로 과목을 구분했을때, 과목구분이 "전공선택"에 한하여 과목수가 10개 이상인 행의 학과번호, 과목구분(class_type), 과목수를 조회(전공선택만 조회)
select department_no 학과번호,   class_type 과목구분,count(class_no) 과목수
from tb_class
where class_type = '전공선택'
group by department_no, class_type
having count(class_no) >=10
order by 3 desc;

  
  








