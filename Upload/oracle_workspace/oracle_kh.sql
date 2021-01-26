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
select to_date('2021/01/23') - a       --문자열을 날짜형으로 변환 함수 
from tb_datatype_date;

--dual 가상테이블
select (sysdate + 1) - sysdate          --sysdate 현재날짜 
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
from employee       -- from절에조회하고자 하는테이블 명시 
where salary >= 2500000; 

--5.employee 테이블에서 급여가 3,500,000원 이상이면서, 직급코드가 'J3'인 사원을조회
--(&&||이 아닌 and or 만 사용가능)

select *
from employee     
where salary>=3500000 and job_code ='J3';

--6.employe테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력
select emp_name
from employee
where quit_yn ='N'
order by emp_name asc;      --ascending (기본값)

-- 7. employee 테이블에서 현재 근무중인 사원을 이름 내림차순으로 정렬해서 출력
select emp_name
from employee
where quit_yn ='N'
order by emp_name desc;     --descending


--8. employee 테이블에서  급여가  1,500,000원 이상이 사원의 이름과 급여를 출력 
select emp_name,salary
from employee
where  salary >= 1500000;

--9 employee 테이블에서 급여가 1,500,000원 이상이 사원의 주민번호와 급여를 출력
select emp_no,salary
from employee
where salary>=1500000;

--10,  employee 테이블에서  이메일 주민등록번호 출력 
select emp_no,email,phone 
from employee;
--11 department 테이블에서   
select dept_id,dept_title
from department;

commit;



----------------------
--SELECT
----------------------
--table의 존재하는 컬럼
--가상컬럼 (산술연산) 
-- 임의의 literal
--각 컬럼은 별칭(alias)를  가질수 있다. as와 "(쌍따옴표)는생략가능
--별칭에 공백,특수문자가 있거나 숫자로 시작하는경우 쌍따옴표 필수,
select emp_name as "사원명",
    phone "전화번호",
    salary 급여  ,
    salary*12 "연 봉" ,
    123
from employee;

--실급여: salary + (salary*bonus)
--nvl     salary +(salary * nvl(bonus,0))
select emp_name,
       salary,
       bonus,
       salary +(salary * nvl(bonus,0)) 실급여     
       from employee;
    
--null값과는 산술연산 할수없다. 그 결과는 무조건 null이다.
--null%1(x)나머지연산자는 사용불가
select null +1 ,
            null-1,
            null*1,
            null/1
from dual; --1행 가상테이블

--nvl(col, null 일때 값 )null처리 함수 
--col의 값이 null이 아니면,col값 리턴
--col의 값이 null 이면 (null일때 값)을 리턴
select bonus,
    nvl(bonus,0) null처리후
from employee;

--distinct 중복제거용 키워드
--select  절에 단 한번 사용가능하다.
select distinct job_code        
from employee;

--여러컬럼 사용시 컬럼을 묶어서 고유한값으로 취급한다.
select distinct job_code,dept_code
from employee;

--문자 연결연산자 ||
--+ 는 산술연산만 가능하다.
select '안녕'||'하세요'||123||sysdate
from dual;

select  emp_name||'('||phone||')'
from employee;


-------------------------
--where
-------------------------
--테이블의 모든 행중 결과집합에 포함된 행을 필터링한다.
--특정행에 대해 true(포함)|false(제외)결과를 리턴한다.

/*
    =    같은가 
    !=   ^= <> 다른가
    > < >= <= 
    betweeen ..and..         범위연산자
    like not like               문자패턴연산
    is null ,is not null         null여부 
    in, not in                   값목록에 포함여부 

    and 
    or      같다면
    not     제시한 조건반전
*/
-- 부서코드가 D6가 아닌 사원조회
select*
from employee       --테이블 
where dept_code !='D6';      --조건 'D6' 코드

select emp_name,salary
from employee
where salary >=2000000;         --세자리 마다 , 하면 문자열 

-- 날짜형 크기비교 가능 
select emp_name,hire_date
 from employee
 where  hire_date<'2000/01/01';     --날짜 형식의 문자열은 자동으로 날짜형으로 형변환
 
 --20년이상 근무한 사원조회:날짜형 -날짜형=숫자(1=하루)
 --날짜형 -숫자(1=하루)=날짜형
 select emp_name,hire_date
 from employee
 where sysdate- hire_date>=20*365;          --sysdate 현재날짜 

--부서코드가D6이거나  D9인 조회
select emp_name,dept_code
from employee
where dept_code= 'D6'or dept_code='D9';

--범위 연산
--급여가 200만원 이상 400만원 이하 사원 조회 (사원명 급여)
select emp_name,salary
from  employee
where salary between 2000000 and 4000000;

--  입사일이 1990/01/01 ~ 2001/01/01 인  사원조회(사원명,입사일)
select emp_name,hire_Date
from employee
where hire_Date >'1990/0101' and '2001/01/01'< hire_Date;
--between  and  사용 
select emp_name, hire_date
from employee
where hire_date between to_date('1990/01/01') and to_date('2001/01/01');


--like ,not like 
--문자열  패턴 비교 연산 
--wild card : 패턴의미를 가지는 특수문자 
-- 아무문자 1개 
--%아무문자 0개 이상 
select emp_name
from employee
where emp_name like '전%' ;  --전으로 시작,0개이상의 문자가 존재하는가
--파전(x)

select emp_name
from employee
where emp_name like '전__';
--전형동,전전전(0)
--전,전진,파전,전당포아저씨(x)

--이름에 가운데 글자가 '옹'인 사원 조회, 단, 이름은 3글자
select emp_name
from employee
where emp_name like '_옹_';

--이름에 '이'가 들어가는 사원 조회.
select emp_name
from employee
where emp_name like '%이%';

--email컬럼값의 '_'   이전 글자가 3글자인 이메일을조회
select email 
from employee
--where email like'___%';
where email like '___\_%'escape '\'; --escape문자등록.데이터에 존재하지 않을것.

--in, not in 값목록에 포함여부
--부석코드가 D6또는 D8인 사원조회
select emp_name,dept_code
from employee
where  dept_code='D6'or dept_code='D8'; 

select emp_name,dept_code
from employee
where  dept_code in ('D6','D8');     --개수제한없이 값나열       in 포함여부 



select emp_name,dept_code
from employee
where  dept_code not in ('D6','D8');     --개수제한없이 값나열       not in 포함여부 조회 


select emp_name,dept_code
from employee
where  dept_code !='D6' and  dept_code !='D8';      --D6와 D8이 다르다면 or 같다면 차이점


--is null, is not null :null 비교연산
--인턴사원 조회 
--null값은 산술연산, 비교연산 불가능 하다
select emp_name,dept_code
from employee
--where dept_code=null;
where dept_code is null;        --비교연산 is null 조회

select emp_name,dept_code
from employee
--where dept_code=null;
where dept_code is  not null;       --is not null 조회 null이 아닌사원

--D6,D8부서원이 아닌 사원조회(인터사원 포함)
select emp_name,dept_code
from employee
where  dept_code not in ('D6','D8') or dept_code is null ; --is null  조회  18행 조회

--nvl 버전 
select emp_name, nvl(dept_code,'인턴') dept_code
from employee 
where nvl  (dept_code,'D0') not in ('D6','D8');         --nvl (dept_code,'D0')


---------------------------------
--ORDER BY
---------------------------------
--selcet 구문중 가장 마지막에 처리 .
--지정한 컬럼기준으로 결과집합을 정렬해서 보여준다.
--number 0<10 
--string ㄱ<ㅎ ,a<z
--date  과거<미래
--null값 위치를 결정가능 :nulls  first|| nulls last
--asc   오름차순(기본값)
--desc 내림차순
-- 복수개의 컬럼차례로 정렬가능

select emp_id,emp_name,dept_code,job_code,salary,hire_date
from employee
order  by salary  desc;     --asc는 생략가능,desc nulls last  밑으로보낼수있다.

--alias 사용가능

select emp_id 사번,
        emp_name 사원명
    from employee
    order by 사원명;         --order by  테이블정렬 조회
    
--1부터 시작하는 컬럼순서 사용가능
 select *
 from employee
 order by 9 desc;           --order by  테이블정렬 조회
    
    
--=========================
--BUILT-IN-FUNCTION
--=========================

--일련의 실행코드 작성해두고 호출해서 사용함.
--반드시 하나의 리턴값을 가짐.

--1.단일행 함수 :각 행마다 반복 호출되어서 호출된 수만큼 결과를 리턴함
--a.문자처리함수 
--b.숫자처리 함수 
--c.날짜처리 함수
--d.형변환 함수
--ㄷ.기타함수
--2.그룹함수:여러행을 그룹핑한후, 그룹당 하나의 결과를 리턴함.
---------------------------------------
--단일행함수
---------------------------------------

--************************************************************
--a 문자처리함수
--************************************************************

--length(col):number
--문자열의 길이를 리턴
select emp_name,length(emp_name)
from employee;

--where절에서도 사용가능 
select emp_name,email
from employee
where length(email)<15;

--length(col)
--값의byte 수 리턴

select emp_name,lengthb(emp_name),
email,lengthb(email)
from employee;

--insert (string,searh[,position[,occurence]])
--string 에서 search 가 위치한 index 를반환.
--oracle에서는 1-based index ,1부터 시작
--occurence 출현순서
            
select instr('kh정보교육원 국가정보원', '정보'),  --3
            instr('kh정보교육원 국가정보원', '안녕'),    --0 값없음
            instr('kh정보교육원 국가정보원', '정보', 5),  --11
            instr('kh정보교육원 국가정보원 정보문화사', '정보', 1, 3), --15
            instr('kh정보교육원 국가정보원', '정보', -1) --11 startPostion이 음수면 뒤에서부터 검색
from dual;

--email 컬럼값중 '@'의 위치는 ? (이메일,인덱스)
select  email , --테이블 
    instr(email,'@')
    from employee;      
    
--substr(string,startindex[,length])            --[] 생략의 의미
--string 에서 startindex부터length 개수 만큼 잘라내어 리턴
--length 생략시에는 문자열 끝까지 반환

select substr('show me the money',6,2), --me
    substr('show me the money',6),--me the money
    substr('show me the money',-5,3)--mon
        from dual;
        
--@실습문제 :사원명에서 성(1글자로 가정) 만 중복없이 사전순으로 출력
select distinct substr(emp_name,1,1) "성 "     --별칭명 
from employee
order by "성";


-- lpad|rpad(string, byte[, padding_char])
-- byte수의 공간에 string을 대입하고, 남은 공간은 padding_char를 (왼쪽|오른쪽) 채울것.
-- padding char는 생략시 공백문자.

select lpad(email, 20, '#'),
            rpad(email, 20, '#'),
            '[' || lpad(email, 20) || ']',      --
            '[' || rpad(email, 20) || ']'
from employee;


--@실습문제: 남자사원만 사번, 사원명, 주민번호, 연봉 조회
--주민번호 뒤  6자리는 ****** 숨김처리할 것.
select emp_id,
            emp_name,
            substr(emp_no, 1, 8) || '******' emp_no,
            rpad(substr(emp_no, 1, 8), 14, '*') emp_no,
            (salary + (salary * nvl(bonus, 0))) * 12 annul_pay
from employee
where substr(emp_no, 8, 1) in ('1', '3');

--************************************************************
--b .문자처리함수
--************************************************************

--mod (피젯수,젯수)
--나머지 함수, 나머지 연산자%가 없다.

select mod(10,2)
, mod(10,3),
mod(10,4)
from dual;


--입사년도가 짝수인 사원 조회
select emp_name, 
            extract(year from hire_date) year --날짜함수 년도추출
from employee
--where mod(year, 2) = 0 -- ORA-00904: "YEAR": invalid identifier
where mod(extract(year from hire_date),2)=0         -- 입력된 날짜에서 추출하고자 하는 연도,월,시간,분 초 등을 반환하는 함수
order by year;


--ceil(number)
--소수점기준으로 올림
select ceil(123.456),
    ceil(123.456*100)/100 --부도소수점
from dual;

--floor (number)
--소수점기준으로버림
select floor(456.789),
    floor(456.789*10)/10
from dual;

--round(number[,position])
--position 기준(기본값 0, 소수점기준)으로 반올림처리
select round(234.567),
round (234.567,2),
    round(235.567,-1)
from dual;

--trunc(number,[,position])
--버림
select trunc(123.567),
    trunc(123.567,2) ,-- 소수점 둘째자리 까지 남기면됩니다.
    trunc (1234.56 ,1)
from dual;


--****************************************************
-- c. 날짜처리함수
--****************************************************
--날짜형 + 숫자 = 날짜형
--날짜형 - 날짜형 = 숫자


--add_months(date, number)
--date기준으로 몇달(number) 전후의 날짜형을 리턴
select sysdate,
            sysdate + 5,
            add_months(sysdate, 1),
            add_months(sysdate, -1),
            add_months(sysdate + 5, 1)      --말일 표시??
from dual;

--months_between(미래,과거)
--두날짜형의 개월수 차이를 리턴한다.
select sysdate,
       to_date ('2021/07/08'),--날짜형 변환함수
     trunc(months_between(to_date('2021/07/08'),sysdate),1) diff
from dual;

--이름 입사일,군무개월수(n개월),근무개월수(n년 m개월)조회

select emp_name,
            hire_date,
            trunc(months_between(sysdate, hire_date)) || '개월' 근무개월수,
            trunc(months_between(sysdate, hire_date) / 12) || '년 ' ||
            trunc(mod(months_between(sysdate, hire_date), 12)) || '개월' 근무개월수
from employee;

select emp_name,
            hire_date,
            trunc(months_between(sysdate,hire_date)) || '개월' 근무개월수,
            trunc(months_betww

--extract(year | month | day | hour | minute | second  from date) : number
--날짜형 데이터에서 특정필드만 숫자형으로 리턴.
select extract(year from sysdate) yyyy,
            extract(month from sysdate) mm, --1~12월
            extract(day from sysdate) dd,
            extract(hour from cast(sysdate as timestamp)) hh,
            extract(hour from cast(sysdate as timestamp)) mi,
            extract(minute from cast(sysdate as timestamp))ss
        from dual;


--trunc(date)
--시분초 정보를 제외한 년월일 정보만 리턴
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') date1,
            to_char(trunc(sysdate), 'yyyy/mm/dd hh24:mi:ss') date2
from dual;



--****************************************************
-- d. 형변환 함수
--****************************************************
/*
        to_char      to_date
            ---->     ---->
    number    string        date
       <-----   < ----    
        to_number   to_char
        
*/

--to_char(date|number[,format])

select  to_char(sysdate, 'yyyy/mm/dd(day) hh24:mi:ss am' )now,  --2021년 /mm /dd(day) hh24:mi:ss am
          to_char(sysdate, 'fmyyyy/mm/dd(day) hh24:mi:ss am' )now,      --형식문잘호 인한 앞글자 0을 제거
          to_char(sysdate,'yyyy"년" mm"월" dd"일"')now                --한글은 쌍따옴표
          from dual;
          select to_char(1234567, 'fmL9,999,999,999')won,
          to_char(1234567, 'fmL9,999')won,--자릿수 가 모자라 오류
          to_char(123.4, '9000.00'), --빈자리는 0처리
          to_char(123.4, '0000.00'), --빈자리는 0처리
          to_char(123.4,'9999.99')--소수점이상의 빈자리는 공란, 소수점이빈자리는 0처리
from dual;

--이름,급여,입사일(1990-9-3(화))을 조회 
select emp_name,to_char(salary,'fm 999,999,999')급여 ,       --fm 공백제거구간
to_char(hire_date,'yyyy/mm/dd(dy)') --(dy) 요일 조회 
from employee;

--to_number (String ,format)
select
to_number( '1,234,567' , '9,999,999') +100,
to_number('￦3,000' , 'L9,999')+100
from dual;

--자동형변환 지원
select '1000'+100,
            '99'+'1',
            '99'||'1'
            from dual;
            
            
--to date(string,format)
--string이 작성된 형식문자 format으로 전달
select to_date('2020/09/09','yyyy/mm/dd')+1
from dual;

--'2021/07/08 21:50:00 를 2시간의짜 정보를 

select to_char(to_date('2021/07/08 21:50:00', 'yyyy/mm/dd hh24:mi:ss')+(2/24), 'yyyy/mm/dd hh24:mi:ss') "날짜정보"
-- (2/24) 2시간
from dual;
--현재시각 기준 1일 2시간 3분 4초후의 날짜 정보를 yyyy/mm/dd hh24:mi:ss형식으로 출력
--1시간 : 1 / 24
--1분 : 1 / (24 * 60)
--1초 : 1 / (24 * 60 * 60)
select to_char(
                sysdate + 1  + (2 / 24) + (3 / (24 * 60) ) + (4 / (24 * 60 * 60)), 
                'yyyy/mm/dd hh24:mi:ss'
            ) result
from dual;

--현재시각 기준 1일 3시간 3분 12초후의 날짜 정보를 yyyy/mm/dd hh24:mi:ss형식으로 출력
select to_char(
                sysdate + 1  + (3 / 24) + (4 / (24 * 60) ) + (12 / (24 * 60 * 60)), 
                'yyyy/mm/dd hh24:mi:ss'
            ) result
from dual;

--기간타임
--interval year to month :년월기간
--interval date to second: 일시분초 기간
-- 1년 2걔월 3일 4시간 5분 6초후 조회
select to_char( add_months(sysdate,14)+3+(4/24)+(5/24/60)+(6/24/60/60),
'yyyy/mm/dd hh24:mi:ss') result
from dual;




select to_char(
                sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'),
                'yyyy/mm/dd hh24:mi:ss'
            ) result
from dual;
--2년 3걔월 5일 5시간 5분 6초후 조회
select to_char(
sysdate+ to_yminterval('02-03')+to_dsinterval('005 04:05:06'),
    'yyyy/mm/dd hh24:mi:ss') result
    from dual;
-- 1년 2걔월 5일 4시간 5분 6초후 조회

--numtodsinterval(diff, unit)
--numtoyminterval(diff, unit)
--diff : 날짜차이
--unit : year | month | day | hour | minute | second
select extract( day from
            numtodsinterval( 
                to_date('20210708', 'yyyymmdd') - sysdate,
                'day'
            )) diff
from dual;



--****************************************************
-- e.기타함수
--****************************************************

--null 처리함수
--nvl(col,nullvalue)
--nvl2(col,notnullvalue,nullvalue)
--col값이 null이 아니면 두번째인자를 리턴, null이면 세번째 인자를 리턴
select emp_name,
            bonus,
            nvl(bonus, 0) nvl1,
            nvl2(bonus, '있음', '없음') nvl2
from employee;


--선택함수1
--decode(expr, 값1, 결과값1, 값2, 결과값2, .....[, 기본값])
select emp_name,
            emp_no,
            decode(substr(emp_no, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여') gender,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
from employee;

--직급코드에 따라서 J1-대표 , J2/J3-임원 나머지는 평사원으로 출력 (사원명,직급코드 직위)
select  emp_name 사원명,
            job_code 직급코드,
             decode(job_code, 'J1','대표','J2','임원','J3','임원','평사원')
             from employee;
             

--where절에도 사용가능
--여사원만 조회
select emp_name, 
            emp_no,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
from employee
where  decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') = '여';     --여사원만 조회 


select emp_name, 
            emp_no,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
from employee
where  decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') = '남';     --남사원만 조회 

--case
/*
type1(decode와 유사)

case 표현식
    when 값1 then 결과1
    when 값2 then 결과2
    ....
    [else 기본값]
    end 
    
    
type2

case 
when 조건식 1 then 결과 1
when 조건식 2 then 결과 2
.....
[else 기본값]
end


*/
select emp_no,
            case substr(emp_no, 8, 1)
                when '1' then '남'
                when '3' then '남'
                else '여'
                end gender,
            case
                when substr(emp_no, 8, 1) in ('1', '3') then '남'
                else '여'
                end gender,
            job_code,
            case job_code
                when 'J1' then '대표'
                when 'J2' then '임원'
                when 'J3' then '임원'
                else '평사원'
                end job,
            case 
                when job_code = 'J1' then '대표'
                when job_code in ('J2', 'J3') then '임원'
                else '평사원'
                end job            
from employee;

select job_code,
            case job_code
            when 'J1' then '대표'
            when 'J2' then '임원'
            when 'J3' then '임원'
            else'평사원'
            end job_code
from employee;


select emp_name 이름,
       job_code 직급코드,
       case 
          when job_code ='J1' then '대표'
          when job_code in ('J2','J3') then '임원'
          else '평사원'
          end 직위
from employee;

-------------------------
--GROUP FUNCTION
-------------------------
--여러행 을 그룹핑하고, 그룹당 하나의 결과를 리턴하는 함수
--모든행을 하나의 그룹또는 group by를 통해서 세부그룹이 지정이 가능하다 

--sum(col)
select  sum(salary)
,sum(bonus),  --null 인 컬럼은 제외하고 누계처리 
sum(salary+(salary*nvl(bonus,0))) 
--가공된 컬럼도 그룹함수 가능
from employee;
--select emp_name,  sum(salary) from employee;
--ORA-00937: not a single-group group function
--그룹함수의 결과와 일반컬럼을 동시에 조회 할수 없다.

--avg(col)
--평균

select round(avg(salary),1)avg,     --차이점 알기
to_char(
round (avg(salary),1),'FML9,999,999,999')avg
from employee;

--부서코드가 D5인 부서원의 평균급여 조회 
 select to_char(round(avg(salary), 1), 'fmL999,999,999,999') avg
from employee
where dept_code = 'D5';


--부서코드가 D1인 부서원의 평균급여 조회 
 select to_char(round(avg(salary), 1), 'fmL999,999,999,999') avg
from employee
where dept_code = 'D1';

--남자사원의 평균급여 조회 
select to_char(round(avg(salary), 1), 'fmL999,999,999,999') avg --남자 사원 급여조회 
from employee
where substr(emp_no, 8, 1) in ('1', '3');
--여자사원의 평균급여 조회
select to_char(round(avg(salary), 1), 'fmL999,999,999,999') avg     --여자사원 급여 조회 
from employee
where substr(emp_no, 8, 1) in ('2', '4');

--count(col)
--null이 아닌 컬럼의개수

select count(*),
        count(bonus),--9 bonus 컬럼이 null이 아닌 행의수 
        count(dept_code)
from employee;


--보너스 받는사원수 조회
select count(*)
from employee 
where bonus is not null;            

select sum( case
                when  bonus is not null then 1
        --        when bonus is null then 0     null여부 조회
                end
                )bonusman
from employee;

--사원이 속한 부서 총수 (중복없음)
select count(distinct dept_code)
from employee;


--max(col)|min(col)
--숫자.날짜(과거->미래),문자(ㄱ->ㅎ)
select max(salary),min(salary),
        max(emp_name),min(emp_name)
        from employee;