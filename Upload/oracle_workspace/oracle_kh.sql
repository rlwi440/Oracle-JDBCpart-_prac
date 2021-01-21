--=============================
--kh 계정
--=============================
show user;


--table sample 생성
create  table sample(
    id number
);


--현재 계정의 소유 테이블 목록 조회
select * from tab;

--사원테이블
select * from employee; 
--부서테이블
select * from department;           --부서테이블   L3 체크 
--직급테이블
select * from job;
--지역테이블
select * from location;
--국가테이블
select * from nation;
--급여등급테이블
select * from sal_grade;


--table entity relation 
--데이터를 보관하는 객체 

--열 column field  attribute  세로,데이터가 담길 형식
--행 row record  tuple 가로, 실제 데이터 가 담긴 
--도메인 domain하나의 컬럼에 취할수 있는값의 그룹(범위)


--테이블 명세
--컬럼명    널여부    자료형 
--단어 구문  emp_id  EMP_ID
describe employee;
desc employee;



--===================================
--DATA  TYPE

--===================================
--컬럼에 지정해서 값을 제한적으로 허용.
-- 1.문자형    varchar2| char
--2.숫자형     number
--3.날짜시간형 date
--4.LOB

-----------------------------------------
--문자형
-----------------------------------------
--고정형 char(byte):최대 2000byte 
-- char(10) 'korea' 영소문자 글자당 1byte 이므로 실제 크기 는 5byte  고정형 10byte 저장됨
--'한글'  한글은 글자당 3byte (11g XE  )이므로 실제크기 6byte .고정형 10byte 저장됨.
--가변형 varchar2(byte) 최대 4000byte
--varchar2(10) 'korea' 영소문자는 글자당 1byte이므로 실제크기 5bye. 가변형 10byte 로 저장됨.
--'안녕' 한글은 글자당 3byte(11g XE)이므로 실제크기 6byte.가변형 6byte 로 저장됨
--고정형 가변형 모두 지정한 크기 이상의 값은 추가할수 없다.

--가변형 long :최대 2GB
-- LOB타입(Large object) 중의 CLOB(character LOB)단일컬럼 최대 4GB까지 지원 
create table tb_datatype(
--컬럼명 자료형 널여부 기본값
a char(10),
b varchar2(10)
);

--테이블 조회
select *    -- * 모든걸럼 
from  tb_datatype; -- 테이블명 

--데이터추가 : 한행을 추가 
insert  into tb_datatype
values('hello','hello');

insert  into tb_datatype
values('안녕','안녕');


insert  into tb_datatype
values('에브리바디','안녕'); --ORA-12899: value too large for column "KH"."TB_DATATYPE"."A" (actual: 15, maximum: 10)  KH 사용자  TB_DATATYPE  A

--데이터가 변경 (insert,update,delete)되는경우, 메모리상에서 먼저 처리된다.
--commit 을 통해 실제 database에 적용해야한다.
commit;


--lengthb(컬럼명):number-저장된 데이터의 실제크기를 리턴
select a, length(a),b,length(b)
from tb_datatype;


------------------------------------------------------------
-- 숫자형
------------------------------------------------------------
-- 정수, 실수를 구분치 않는다.
-- number(p, s)
-- p : 표현가능한 전체 자리수
-- s : p 중 소수점이하 자리수
/*
값 1234.567 
--------------------------------
number              1234.567
number(7)           1235        --반올림 
number(7,1)         1234.6      --반올림 
number(7,-2)        1200        --반올림
*/

create table tb_datatype_number (
    a number,
    b number(7),
    c number(7,1),
    d number(7,-2)
);

select * from tb_datatype_number;

insert into tb_datatype_number 
values(1234.567, 1234.567, 1234.567, 1234.567);
--지정한 크기보다 큰 숫자는 ORA-01438: value larger than specified precision allowed for this column 유발
insert into tb_datatype_number 
values(1234567890.123, 1234567.567, 12345678.5678, 1234.567);

/*
        
        : 예) 
        
        ------------------------------------------------------------
        입력값                    선언                  저장값
        ------------------------------------------------------------
        765432.1234           NUMBER                765432.1234
        765432.1234           NUMBER(*,3)           765432.123  
        765432.6234           NUMBER(7)             765433
        765432.6834           NUMBER(9,1)           765432.7
        765432.6834           NUMBER(7,-2)          765400
        765432.6834           NUMBER(5)             ERROR 발생
        1.234                 NUMBER(4,5)           ERROR 발생
        0.01234               NUMBER(4,5)           0.01234
        0.001234              NUMBER(3,5)           0.00123
        0.005678              NUMBER(2,5)           ERROR 발생
        0.0005678             NUMBER(2,5)           0.00057
        ------------------------------------------------------------

*/
commit; -- 저장시점

rollback;       --마지막 commit시점 

--지정한 크기보다 큰숫자

------------------------------------------------------------
-- 날짜시간형
------------------------------------------------------------
-- date 년월일시분초
-- timestamp 년월일시분초 밀리초 지역대

create table tb_datatype_date (
    a date,
    b timestamp
);

--to_char 날짜/숫자를 문자열로 표현
select to_char(a, 'yyyy/mm/dd hh24:mi:ss'), b
from tb_datatype_date;

insert into tb_datatype_date
values (sysdate, systimestamp);


--날짜형 +- 숫자(1=하루) = 날짜형
select to_char(a, 'yyyy/mm/dd hh24:mi:ss'), 
            to_char(a - 1, 'yyyy/mm/dd hh24:mi:ss'), 
            b
from tb_datatype_date;

--날짜형 - 날짜형 = 숫자(1=하루)
select sysdate - a --0.009일 차
from tb_datatype_date;

--to_date 문자열을 날짜형으로 변환 함수
select to_date('2021/01/23') - a
from tb_datatype_date;

--dual 가상테이블
select (sysdate + 1) - sysdate
from dual;

--============================
--DQL
--============================
-- Data Query  Language데이터 조회(검색)을 위한언어
--select문
--쿼리 조회결과를 ResultSet(결과집합)라고 하며, 0행 이상을 포함한다.
--from절에 조회하고자 하는테이블 명시
--where절에 의해 득정행을 filtering  가능.
--select절에 의해   컬럼을 filtering  또는 추가가능
--order by절에 의해서 행을 정렬할 수있다 .

/*
구조 

select 컬럼명 (5) 필수
from 테이블명(1)필수 
where 조건절(2)선택
group by 그룹기준 컬럼(3)
having 그룹조건절 (4)
order by 정렬기준컬럼(6)
*/

select *
from employee 
where dept_code= 'D9'--데이터는 대소문자 구분
order by emp_name asc; --오름차순

--1.job테이블에서 job_name 컬럼정보만 출력 
select  job_name
from job;

--2.department 테이블에서 모든컬럼을출력 
select * from department;     

--3.employee테이블에서 이름,이메일 전화번호,입사일을 출력
select  EMP_name,email,phone,hire_date
from employee;

--4.employee테이블에서 급여가 2,500,000원 이상이 사원의 이름과급여를 출력 
select emp_name,salary
from employee
where salary >= 2500000; 

--5.employee 테이블에서 급여가 3,500,000원 이상이면서, 직급코드가 'J3'인 사원을조회
select *
from employee
where salary>=3500000 and job_code ='J3';

--6.employe테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력
select emp_name
from employee
where quit_yn ='N'
order by emp_name asc;

-- 7. employee 테이블에서 현재 근무중인 사원을 이름 내림차순으로 정렬해서 출력
select emp_name
from employee
where quit_yn ='N'
order by emp_name desc;


--8. employee 테이블에서  급여가  1,500,000원 이상이 사원의 이름과 급여를 출력 
select emp_name,salary
from employee
where  salary >= 1500000;

--9 employee 테이블에서 급여가 1,500,000원 이상이 사원의 주민번호와 급여를 출력
select emp_no,salary
from employee
where salary>=1500000;

commit;

--(&&||이 아닌 and or 만 사용가능)



