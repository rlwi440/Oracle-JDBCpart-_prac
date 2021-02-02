--=============================
--kh 계정
--=============================
SHOW USER;

--table sample 생성
CREATE TABLE sample (
    id NUMBER
);

--현재 계정의 소유 테이블 목록 조회
SELECT
    *
FROM
    tab;

--사원테이블
SELECT
    *
FROM
    employee; 
--부서테이블
SELECT
    *
FROM
    department;           --부서테이블   L3 체크 
--직급테이블
SELECT
    *
FROM
    job;
--지역테이블
SELECT
    *
FROM
    location;
--국가테이블
SELECT
    *
FROM
    nation;
--급여등급테이블
SELECT
    *
FROM
    sal_grade;

--table entity relation 
--데이터를 보관하는 객체 

--열 column field  attribute  세로,데이터가 담길 형식
--행 row record  tuple 가로, 실제 데이터 가 담긴 
--도메인 domain하나의 컬럼에 취할수 있는값의 그룹(범위)

--테이블 명세
--컬럼명    널여부    자료형 
--단어 구문  emp_id  EMP_ID
DESCRIBE employee;

DESC employee;


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
CREATE TABLE tb_datatype (
--컬럼명 자료형 널여부 기본값
    a  CHAR(10),
    b  VARCHAR2(10)
);

--테이블 조회
SELECT
    *    -- * 모든걸럼 
FROM
    tb_datatype; -- 테이블명 

--데이터추가 : 한행을 추가 
INSERT INTO tb_datatype VALUES (
    'hello',
    'hello'
);

INSERT INTO tb_datatype VALUES (
    '안녕',
    '안녕'
);

INSERT INTO tb_datatype VALUES (
    '에브리바디',
    '안녕'
); --ORA-12899: value too large for column "KH"."TB_DATATYPE"."A" (actual: 15, maximum: 10)  KH 사용자  TB_DATATYPE  A

--데이터가 변경 (insert,update,delete)되는경우, 메모리상에서 먼저 처리된다.
--commit 을 통해 실제 database에 적용해야한다.
COMMIT;

--lengthb(컬럼명):number-저장된 데이터의 실제크기를 리턴
SELECT
    a,
    length(a),
    b,
    length(b)
FROM
    tb_datatype;

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

CREATE TABLE tb_datatype_number (
    a  NUMBER,
    b  NUMBER(7),
    c  NUMBER(7, 1),
    d  NUMBER(7, - 2)
);

SELECT
    *
FROM
    tb_datatype_number;

INSERT INTO tb_datatype_number VALUES (
    1234.567,
    1234.567,
    1234.567,
    1234.567
);
--지정한 크기보다 큰 숫자는 ORA-01438: value larger than specified precision allowed for this column 유발
INSERT INTO tb_datatype_number VALUES (
    1234567890.123,
    1234567.567,
    12345678.5678,
    1234.567
);

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
COMMIT; -- 저장시점

ROLLBACK;       --마지막 commit시점 

--지정한 크기보다 큰숫자

------------------------------------------------------------
-- 날짜시간형
------------------------------------------------------------
-- date 년월일시분초
-- timestamp 년월일시분초 밀리초 지역대

CREATE TABLE tb_datatype_date (
    a  DATE,
    b  TIMESTAMP
);

--to_char 날짜/숫자를 문자열로 표현
SELECT
    to_char(a, 'yyyy/mm/dd hh24:mi:ss'),
    b
FROM
    tb_datatype_date;

INSERT INTO tb_datatype_date VALUES (
    sysdate,
    systimestamp
);

--날짜형 +- 숫자(1=하루) = 날짜형
SELECT
    to_char(a, 'yyyy/mm/dd hh24:mi:ss'),
    to_char(a - 1, 'yyyy/mm/dd hh24:mi:ss'),
    b
FROM
    tb_datatype_date;

--날짜형 - 날짜형 = 숫자(1=하루)
SELECT
    sysdate - a --0.009일 차
FROM
    tb_datatype_date;

--to_date 문자열을 날짜형으로 변환 함수
SELECT
    to_date('2021/01/23') - a       --문자열을 날짜형으로 변환 함수 
FROM
    tb_datatype_date;

--dual 가상테이블
SELECT
    ( sysdate + 1 ) - sysdate          --sysdate 현재날짜 
FROM
    dual;

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

SELECT
    *
FROM
    employee
WHERE
    dept_code = 'D9'--데이터는 대소문자 구분
ORDER BY
    emp_name ASC; --오름차순

--1.job테이블에서 job_name 컬럼정보만 출력 
SELECT
    job_name
FROM
    job;

--2.department 테이블에서 모든컬럼을출력 
SELECT
    *
FROM
    department;     

--3.employee테이블에서 이름,이메일 전화번호,입사일을 출력
SELECT
    emp_name,
    email,
    phone,
    hire_date
FROM
    employee;

--4.employee테이블에서 급여가 2,500,000원 이상이 사원의 이름과급여를 출력 
SELECT
    emp_name,
    salary
FROM
    employee       -- from절에조회하고자 하는테이블 명시 
WHERE
    salary >= 2500000; 

--5.employee 테이블에서 급여가 3,500,000원 이상이면서, 직급코드가 'J3'인 사원을조회
--(&&||이 아닌 and or 만 사용가능)

SELECT
    *
FROM
    employee
WHERE
        salary >= 3500000
    AND job_code = 'J3';

--6.employe테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력
SELECT
    emp_name
FROM
    employee
WHERE
    quit_yn = 'N'
ORDER BY
    emp_name ASC;      --ascending (기본값)

-- 7. employee 테이블에서 현재 근무중인 사원을 이름 내림차순으로 정렬해서 출력
SELECT
    emp_name
FROM
    employee
WHERE
    quit_yn = 'N'
ORDER BY
    emp_name DESC;     --descending

--8. employee 테이블에서  급여가  1,500,000원 이상이 사원의 이름과 급여를 출력 
SELECT
    emp_name,
    salary
FROM
    employee
WHERE
    salary >= 1500000;

--9 employee 테이블에서 급여가 1,500,000원 이상이 사원의 주민번호와 급여를 출력
SELECT
    emp_no,
    salary
FROM
    employee
WHERE
    salary >= 1500000;

--10,  employee 테이블에서  이메일 주민등록번호 출력 
SELECT
    emp_no,
    email,
    phone
FROM
    employee;
--11 department 테이블에서   
SELECT
    dept_id,
    dept_title
FROM
    department;

COMMIT;


----------------------
--SELECT
----------------------
--table의 존재하는 컬럼
--가상컬럼 (산술연산) 
-- 임의의 literal
--각 컬럼은 별칭(alias)를  가질수 있다. as와 "(쌍따옴표)는생략가능
--별칭에 공백,특수문자가 있거나 숫자로 시작하는경우 쌍따옴표 필수,
SELECT
    emp_name     AS "사원명",
    phone        "전화번호",
    salary       급여,
    salary * 12    "연 봉",
    123
FROM
    employee;

--실급여: salary + (salary*bonus)
--nvl     salary +(salary * nvl(bonus,0))
SELECT
    emp_name,
    salary,
    bonus,
    salary + ( salary * nvl(bonus, 0) ) 실급여
FROM
    employee;
    
--null값과는 산술연산 할수없다. 그 결과는 무조건 null이다.
--null%1(x)나머지연산자는 사용불가
SELECT
    NULL + 1,
    NULL - 1,
    NULL * 1,
    NULL / 1
FROM
    dual; --1행 가상테이블

--nvl(col, null 일때 값 )null처리 함수 
--col의 값이 null이 아니면,col값 리턴
--col의 값이 null 이면 (null일때 값)을 리턴
SELECT
    bonus,
    nvl(bonus, 0) null처리후
FROM
    employee;

--distinct 중복제거용 키워드
--select  절에 단 한번 사용가능하다.
SELECT DISTINCT
    job_code
FROM
    employee;

--여러컬럼 사용시 컬럼을 묶어서 고유한값으로 취급한다.
SELECT DISTINCT
    job_code,
    dept_code
FROM
    employee;

--문자 연결연산자 ||
--+ 는 산술연산만 가능하다.
SELECT
    '안녕'
    || '하세요'
    || 123
    || sysdate
FROM
    dual;

SELECT
    emp_name
    || '('
    || phone
    || ')'
FROM
    employee;

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
SELECT
    *
FROM
    employee       --테이블 
WHERE
    dept_code != 'D6';      --조건 'D6' 코드

SELECT
    emp_name,
    salary
FROM
    employee
WHERE
    salary >= 2000000;         --세자리 마다 , 하면 문자열 

-- 날짜형 크기비교 가능 
SELECT
    emp_name,
    hire_date
FROM
    employee
WHERE
    hire_date < '2000/01/01';     --날짜 형식의 문자열은 자동으로 날짜형으로 형변환
 
 --20년이상 근무한 사원조회:날짜형 -날짜형=숫자(1=하루)
 --날짜형 -숫자(1=하루)=날짜형
 SELECT
    emp_name,
    hire_date
FROM
    employee
WHERE
    sysdate - hire_date >= 20 * 365;          --sysdate 현재날짜 

--부서코드가D6이거나  D9인 조회
SELECT
    emp_name,
    dept_code
FROM
    employee
WHERE
    dept_code = 'D6'
    OR dept_code = 'D9';

--범위 연산
--급여가 200만원 이상 400만원 이하 사원 조회 (사원명 급여)
SELECT
    emp_name,
    salary
FROM
    employee
WHERE
    salary BETWEEN 2000000 AND 4000000;

--  입사일이 1990/01/01 ~ 2001/01/01 인  사원조회(사원명,입사일)
SELECT
    emp_name,
    hire_date
FROM
    employee
WHERE
        hire_date > '1990/0101'
    AND '2001/01/01' < hire_date;
--between  and  사용 
SELECT
    emp_name,
    hire_date
FROM
    employee
WHERE
    hire_date BETWEEN to_date('1990/01/01') AND to_date('2001/01/01');

--like ,not like 
--문자열  패턴 비교 연산 
--wild card : 패턴의미를 가지는 특수문자 
-- 아무문자 1개 
--%아무문자 0개 이상 
SELECT
    emp_name
FROM
    employee
WHERE
    emp_name LIKE '전%';  --전으로 시작,0개이상의 문자가 존재하는가
--파전(x)

SELECT
    emp_name
FROM
    employee
WHERE
    emp_name LIKE '전__';
--전형동,전전전(0)
--전,전진,파전,전당포아저씨(x)

--이름에 가운데 글자가 '옹'인 사원 조회, 단, 이름은 3글자
SELECT
    emp_name
FROM
    employee
WHERE
    emp_name LIKE '_옹_';

--이름에 '이'가 들어가는 사원 조회.
SELECT
    emp_name
FROM
    employee
WHERE
    emp_name LIKE '%이%';

--email컬럼값의 '_'   이전 글자가 3글자인 이메일을조회
SELECT
    email
FROM
    employee
--where email like'___%';
WHERE
    email LIKE '___\_%' ESCAPE '\'; --escape문자등록.데이터에 존재하지 않을것.

--in, not in 값목록에 포함여부
--부석코드가 D6또는 D8인 사원조회
SELECT
    emp_name,
    dept_code
FROM
    employee
WHERE
    dept_code = 'D6'
    OR dept_code = 'D8';

SELECT
    emp_name,
    dept_code
FROM
    employee
WHERE
    dept_code IN ( 'D6', 'D8' );     --개수제한없이 값나열       in 포함여부 


SELECT
    emp_name,
    dept_code
FROM
    employee
WHERE
    dept_code NOT IN ( 'D6', 'D8' );     --개수제한없이 값나열       not in 포함여부 조회 

SELECT
    emp_name,
    dept_code
FROM
    employee
WHERE
        dept_code != 'D6'
    AND dept_code != 'D8';      --D6와 D8이 다르다면 or 같다면 차이점

--is null, is not null :null 비교연산
--인턴사원 조회 
--null값은 산술연산, 비교연산 불가능 하다
SELECT
    emp_name,
    dept_code
FROM
    employee
--where dept_code=null;
WHERE
    dept_code IS NULL;        --비교연산 is null 조회

SELECT
    emp_name,
    dept_code
FROM
    employee
--where dept_code=null;
WHERE
    dept_code IS NOT NULL;       --is not null 조회 null이 아닌사원

--D6,D8부서원이 아닌 사원조회(인터사원 포함)
SELECT
    emp_name,
    dept_code
FROM
    employee
WHERE
    dept_code NOT IN ( 'D6', 'D8' )
    OR dept_code IS NULL; --is null  조회  18행 조회

--nvl 버전 
SELECT
    emp_name,
    nvl(dept_code, '인턴') dept_code
FROM
    employee
WHERE
    nvl(dept_code, 'D0') NOT IN ( 'D6', 'D8' );         --nvl (dept_code,'D0')

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

SELECT
    emp_id,
    emp_name,
    dept_code,
    job_code,
    salary,
    hire_date
FROM
    employee
ORDER BY
    salary DESC;     --asc는 생략가능,desc nulls last  밑으로보낼수있다.

--alias 사용가능

SELECT
    emp_id    사번,
    emp_name  사원명
FROM
    employee
ORDER BY
    사원명;         --order by  테이블정렬 조회
    
--1부터 시작하는 컬럼순서 사용가능
 SELECT
    *
FROM
    employee
ORDER BY
    9 DESC;           --order by  테이블정렬 조회
    
    
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
SELECT
    emp_name,
    length(emp_name)
FROM
    employee;

--where절에서도 사용가능 
SELECT
    emp_name,
    email
FROM
    employee
WHERE
    length(email) < 15;

--length(col)
--값의byte 수 리턴

SELECT
    emp_name,
    lengthb(emp_name),
    email,
    lengthb(email)
FROM
    employee;

--insert (string,searh[,position[,occurence]])
--string 에서 search 가 위치한 index 를반환.
--oracle에서는 1-based index ,1부터 시작
--occurence 출현순서
            
SELECT
    instr('kh정보교육원 국가정보원', '정보'),  --3
                instr('kh정보교육원 국가정보원', '안녕'),    --0 값없음
                instr('kh정보교육원 국가정보원', '정보', 5),  --11
                instr('kh정보교육원 국가정보원 정보문화사',
    '정보', 1, 3), --15
                instr('kh정보교육원 국가정보원', '정보', - 1) --11 startPostion이 음수면 뒤에서부터 검색
FROM
    dual;

--email 컬럼값중 '@'의 위치는 ? (이메일,인덱스)
SELECT
    email, --테이블 
        instr(email, '@')
FROM
    employee;      
    
--substr(string,startindex[,length])            --[] 생략의 의미
--string 에서 startindex부터length 개수 만큼 잘라내어 리턴
--length 생략시에는 문자열 끝까지 반환

SELECT
    substr('show me the money', 6, 2), --me
        substr('show me the money', 6),--me the money
        substr('show me the money', - 5, 3)--mon
        FROM
    dual;
        
--@실습문제 :사원명에서 성(1글자로 가정) 만 중복없이 사전순으로 출력
SELECT DISTINCT
    substr(emp_name, 1, 1) "성 "     --별칭명 
FROM
    employee
ORDER BY
    "성";

-- lpad|rpad(string, byte[, padding_char])
-- byte수의 공간에 string을 대입하고, 남은 공간은 padding_char를 (왼쪽|오른쪽) 채울것.
-- padding char는 생략시 공백문자.

SELECT
    lpad(email, 20, '#'),
    rpad(email, 20, '#'),
    '['
    || lpad(email, 20)
    || ']',      --
                '['
    || rpad(email, 20)
    || ']'
FROM
    employee;

--@실습문제: 남자사원만 사번, 사원명, 주민번호, 연봉 조회
--주민번호 뒤  6자리는 ****** 숨김처리할 것.
SELECT
    emp_id,
    emp_name,
    substr(emp_no, 1, 8)
    || '******'                                       emp_no,
    rpad(substr(emp_no, 1, 8), 14, '*')               emp_no,
    ( salary + ( salary * nvl(bonus, 0) ) ) * 12          annul_pay
FROM
    employee
WHERE
    substr(emp_no, 8, 1) IN ( '1', '3' );

--************************************************************
--b .문자처리함수
--************************************************************

--mod (피젯수,젯수)
--나머지 함수, 나머지 연산자%가 없다.

SELECT
    mod(10, 2),
    mod(10, 3),
    mod(10, 4)
FROM
    dual;

--입사년도가 짝수인 사원 조회
SELECT
    emp_name,
    EXTRACT(YEAR FROM hire_date) year --날짜함수 년도추출
FROM
    employee
--where mod(year, 2) = 0 -- ORA-00904: "YEAR": invalid identifier
WHERE
    mod(EXTRACT(YEAR FROM hire_date), 2) = 0         -- 입력된 날짜에서 추출하고자 하는 연도,월,시간,분 초 등을 반환하는 함수
ORDER BY
    year;

--ceil(number)
--소수점기준으로 올림
SELECT
    ceil(123.456),
    ceil(123.456 * 100) / 100 --부도소수점
FROM
    dual;

--floor (number)
--소수점기준으로버림
SELECT
    floor(456.789),
    floor(456.789 * 10) / 10
FROM
    dual;

--round(number[,position])
--position 기준(기본값 0, 소수점기준)으로 반올림처리
SELECT
    round(234.567),
    round(234.567, 2),
    round(235.567, - 1)
FROM
    dual;

--trunc(number,[,position])
--버림
SELECT
    trunc(123.567),
    trunc(123.567, 2),-- 소수점 둘째자리 까지 남기면됩니다.
        trunc(1234.56, 1)
FROM
    dual;

--****************************************************
-- c. 날짜처리함수
--****************************************************
--날짜형 + 숫자 = 날짜형
--날짜형 - 날짜형 = 숫자

--add_months(date, number)
--date기준으로 몇달(number) 전후의 날짜형을 리턴
SELECT
    sysdate,
    sysdate + 5,
    add_months(sysdate, 1),
    add_months(sysdate, - 1),
    add_months(sysdate + 5, 1)      --말일 표시??
FROM
    dual;

SELECT
    add_months(TO_DATE('2021/06/30', 'yyyy/mm/dd') + 1, 1)
FROM
    dual;
--months_between(미래,과거)
--두날짜형의 개월수 차이를 리턴한다.
SELECT
    sysdate,
    to_date('2021/07/08'),--날짜형 변환함수
         trunc(months_between(to_date('2021/07/08'), sysdate), 1) diff
FROM
    dual;

--이름 입사일,군무개월수(n개월),근무개월수(n년 m개월)조회

SELECT
    emp_name,
    hire_date,
    trunc(months_between(sysdate, hire_date))
    || '개월'   근무개월수,
    trunc(months_between(sysdate, hire_date) / 12)
    || '년 '
    || trunc(mod(months_between(sysdate, hire_date), 12))
    || '개월'   근무개월수
FROM
    employee;

SELECT
    emp_name,
    hire_date,
    trunc(months_between(sysdate, hire_date))
    || '개월' 근무개월수,
    trunc
( months_betww

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
select to_char( 
sysdate+ to_yminterval('02-03')+to_dsinterval('005 04:05:06'),
'yyyy/mm/dd hh24: mi(am):ss') result
    from dual;
    
    
    select to_char(
        sysdate+to_yminterval('02-3')
        +to_dsinterval('5 05:05:06')
        ,'yyyy/mm/dd hh24:mi:ss pm'
        ) 값
from dual;
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
           
from employee
where  emp_no ='남';

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

select count(*)
from employee 
where bonus is null;       --보너스 없는사람만조회 

select sum( case
                when  bonus is not null then 1
        --        when bonus is null then 0     null여부 조회
                end
                )bonusman
from employee;

--사원이 속한 부서 총수 (중복없음)
select count(distinct dept_code)
from employee;

select count(distinct job_code)
from employee;

--max(col)|min(col)
--숫자.날짜(과거->미래),문자(ㄱ->ㅎ)
select max(salary),min(salary),
        max(emp_name),min(emp_name)
        from employee;
--max(col) |min(
    Select max(emp_no),min(emp_no),
            max(Salary),min(salary),
            max(phone),min(phone)
            from employee;
            
--나이 추출시 주의점
--현재년도 - 탄생년도 + 1 => 한국식 나이
select emp_name,
            emp_no,
            substr(emp_no, 1, 2),
--            extract(year from to_date(substr(emp_no, 1, 2), 'yy')),
--           extract(year from sysdate) -  extract(year from to_date(substr(emp_no, 1, 2), 'yy')) + 1,
--           extract(year from to_date(substr(emp_no, 1, 2), 'rr')),
--           extract(year from sysdate) -  extract(year from to_date(substr(emp_no, 1, 2), 'rr')) + 1
             extract(year from sysdate) -
            (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age
from employee;

--yy는 현재년도 2021 기준으로 현재세기(2000~ 2099)범위에서 추측한다.
--rr는 현재년도 2021 기준으로(1950~2049)범위에서 추측한다 

--============================
--DQL2
--============================
------------------------------
--GROUP BY
------------------------------
--지정컬럼 기준으로 세부적인 그룹핑이 가능하다 .
--group by 구문없이는 전체를 하나의 그룹으로 취급한다.
--group by 절에 명시한 컬럼만 select절에 사용가능하다.

select dept_code,
--            emp_name, --ORA-00979: not a GROUP BY expression
    sum(salary)
from employee
group by dept_code;     --일반컬럼|가공컬럼이 가능

select job_code,
    sum(salary)
    from employee
    group by job_code;      --세부적인 그룹핑 저장 컬럼기준

--부서코드 코드별 사원수 조회
select job_code,
            trunc(avg(salary), 1)
from employee
group by job_code
order by job_code;

--부서코드별 사원수,급여합계 조회
select nvl( dept_code, 'intern'),         --중복제거 distinct  
       count(emp_no)
from employee
group by dept_code
order by dept_code;

select dept_code 부서코드,
        count(*)사원수,
        trunc(avg(salary)) 급여평균,            --TRUNC 함수는 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
        trunc(avg(salary), 1)급여합계       --TRUNC 함수는 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
from employee
group by dept_code
order by dept_code;

--성별 인원수, 평균급여 조회
select decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender,
            count(*) count,
            to_char(trunc(avg(salary), 1), 'fml9,999,999,999.0') avg
from employee
group by decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여');

--직급코드 j1 을 제외하고, 입사년도별 인원수를 조회
select extract(year from hire_date)yyyy, 
count(*)
from employee
where job_code != 'J1'
group by extract(year from hire_date); 

--직급코드 j2 만 포함한  입사년도별 인원수를 조회
select extract(year from hire_date)yyyy, 
count(*)
from employee
where job_code = 'J2'
group by extract(year from hire_date); 

--두개 이상의 컬럼으로 그룹핑가능
--null 하나의그룹이다 .
select nvl(dept_code,'인턴') dept_code,
            job_code,
            count(*)
from employee
group by  dept_code, job_code
order by 1,2;
--부서별 성별 인원수 조회
select nvl(dept_code,'인턴')부서별 ,
       decode(substr(emp_no, 8, 1),'1', '남', '3', '남', '여') 성별, --성별조회 
       count(decode(substr(emp_no, 8, 1),'1','남','3','남', '여')) 인원      --count 인원조회 
from employee
group by dept_code, 
         decode(substr(emp_no, 8, 1),'1','남','3','남', '여')
order by 1,2;     --순서 정렬 
------------------------------
--HAVING
------------------------------
--group by 이후 조건절 

--부서별 평균급여가 3,000,000원 이상인 부서만 조회
select dept_code,
        trunc(avg(salary))avg
from employee
group by dept_code 
having avg(salary) >= 3000000
order by 1;

--부서별 인원수가 3명이상인 직급과 인원수 조회 
select dept_code,
    count(*)
from employee
group by dept_code
having count(*) >= 3
order by 1;
--직급별 인원수 3명이상인 직급과 인원수 조회
select job_code,
    count(*)
    from employee 
    group by job_code
    having count(*) >=3
    order by 1;
    
--관리하는사원이 2명이상인 manager의 아이디와 관리하는 사원수 조회 
select manager_id, 
           count(*)
from employee
where manager_id is not null
group by manager_id
having count(*) >= 2
order by 1;
-- 선택 1번 where 절을 선택을해 is not null
select manager_id, 
           count(*)
from employee
group by manager_id
having count(manager_id) >= 2
order by 1;
--컬럼 (manager_id )를 넣어서 null값을 없애기

--rollup |cube (col1,, col2...)
--group by 절에 사용하는 함수
--그룹핑 결과에대해 소계를 제공

--rollup 지정컬럼에대해 단방향 소계제공
--cube 지정컬럼에 대해 양방향 소계제공
--지정컬럼이 하나인경우,rollup/cube의 결과는 같다.
select dept_code,
        count(*)
        from employee
        group by  cube(dept_code)
        order by 1;
        
        select dept_code,
        count(*)
        from employee
        group by  rollup(dept_code)
        order by 1;
    
    --grouping()
    --실제 데이터(0) |집계데이터(1) 컬럼을 구분하는함수  
select decode(grouping(dept_code), 0, nvl(dept_code, '인턴'), 1, '합계') dept_code,
--            grouping(dept_code),
            count(*)
from employee
group by rollup(dept_code)
order by 1;
    

--두개이상의 컬럼을 rollup|cube에 전달하는 경우
select decode(grouping(dept_code), 0, nvl(dept_code, '인턴'), '합계') dept_code, 
            decode(grouping(job_code), 0, job_code, '소계') job_code,
            count(*)
from employee
group by rollup(dept_code, job_code)            --부서별 코드 소개
order by 1, 2;

select decode(grouping(dept_code), 0, nvl(dept_code, 'INTERN'), '소계') dept_code,
            decode(grouping(job_code), 0, job_code, '소계') job_code,
            count(*)
from employee
group by cube(dept_code, job_code)
order by 1, 2;

/*
select(5)
from(1) 
where(2)
group by(3)
having (4)
order by(6)
*/

--relation 만들기
--가로방향 합치기JOIN  행+행 
--세로방향 합치기 UJOIN 열 +열 

--=========================
--JOIN
--=========================
--두개이상의 테이블을 연결해서 하나의 가상테이블 (relation)을 생성
--기준컬럼을 가지고 행을 연결한다

--송중기 사원의 부서명을 조회
select dept_code  --D9
from employee
where emp_name = '송종기';

select dept_title --총무부
from department 
where dept_id ='D9';

--join
select D.dept_title
from employee E join department D 
    on E.dept_code = D.dept_id
where E.emp_name = '송종기';

select * from employee;
select * from department;
--join 종류 
--1.EQUI -join      동등비교조건에 (=)에 의한 조인
--non-EQUI JOIN 동등비교조건이 아닌 (berween and , in ,not in ,!=)조인

--join 문법
--1.ANSI 표준문법     :모든 DBMS 공통문법
--2.Vendor 별 문법 :DBMS별로 지원하는 문법 ,오라클 전용문법 (컴마)사용 

--테이블 별칭
select employee.emp_name,
            job.job_code,--ORA-00918: column ambiguously defined
            job.job_name
from employee join job
    on employee.job_code = job.job_code;
    
select E.emp_name,
            J.job_code,
            J.job_name
from employee E join job J
    on E.job_code = J.job_code;
    
--기준컬럼명이 좌우테이블에서 동일하다면, on 대신 using 사용가능
--using을 사용한 경우는 해당컬럼에 별칭을 사용할  수 없다.
--ORA-25154: column part of USING clause cannot have qualifier
select E.emp_name,
            job_code, --별칭을 사용할 수 없다.
            J.job_name
from employee E join job J
    using(job_code);

select * from employee;
select * from job;
/*
1. inner join 교집합

2. outer join 합집합
    - left outer join 좌측테이블 기준 합집합
    - right outer join 우측테이블 기준 합집합
    - full outer join 양테이블 기준 합집합
    
3. cross join 
    두 테이블 간의 조인할 수 있는 최대경우의 수를 표현

4. self join
    같은 테이블의 조인

5. multiple join
    3개이상의 테이블을 조인

*/
------------------------------------------
-- INNER JOIN
------------------------------------------
--A (inner) join B
--교집합
--1. 기준컬럼값이 null인 경우, 결과집합에서 제외.
--2. 기준컬럼값이 상대테이블 존재하지 않는 경우, 결과집합에서 제외.

--1. employee에서 dept_code가 null인 행 제외 : 인턴사원 2행 제외
--2. department에서 dept_id가 D3, D4, D7인 행은 제외
select *
from employee E join department D
    on E.dept_code = D.dept_id; 
--22 

--(oracle)
select *
from employee E, department D
where E.dept_code = D.dept_id and E.dept_code = 'D5';

select *
from employee E join job J
    on E.job_code = J.job_code;

--(oracle)
select *
from employee E, job J
where E.job_code = J.job_code;

select *
from department;

select *
from employee E join job J
    on E.job_code = J.job_code;

---------------------------------------------
-- OUTER JOIN
---------------------------------------------
--1. left (outer) join
--좌측테이블 기준
--좌측테이블 모든 행이 포함, 우측테이블에는 on조건절에 만족하는 행만 포함.
--24 = 22 + 2(left)
select *
from employee E left outer join department D
    on E.dept_code = D.dept_id;
--(oracle)
--기준테이블의 반대편 컬럼에 (+)를 추가
select *
from employee E, department D
where E.dept_code = D.dept_id(+);
    
--2. right (outer) join
--우측테이블 기준
--우측테이블 모든 행이 포함, 좌측테이블에는 on조건절에 만족하는 행만 포함.
--25 = 22 + 3(right)

select *
from employee E right join department D
    on E.dept_code = D.dept_id;
--(oracle)에서는 full  outer join을 지원하지 않는다 
select *
from employee E ,department D
where E.dept_code(+)= D.dept_id;

--3. full (outer) join
--완전 조인.
--좌우 테이블 모두 포함
--27 = 22 + 2(left) + 3(right)
select *
from employee E full join department D
    on E.dept_code = D.dept_id;
--(oracle)
-- 

select*
from emplyee e left outer
--사원명/부서명 조회시
--부서지정이 안된 사원은 제외 : inner join
--부서지정이 안된 사원도 포함 : left join
--사원배정이 안된 부서도 포함 : right join

/*
--문법(첫번째방식)--
SELECT
테이블별칭.조회할칼럼,
테이블별칭.조회할칼럼
FROM 기준테이블 별칭
CROSS JOIN 조인테이블 별칭

--예제(첫번째방식)--
SELECT
A.NAME, --A테이블의 NAME조회
B.AGE --B테이블의 AGE조회
FROM EX_TABLE A
CROSS JOIN JOIN_TABLE B

=====================================================================================

--문법(두번째방식)--
SELECT
테이블별칭.조회할칼럼,
테이블별칭.조회할칼럼
FROM 기준테이블 별칭,조인테이블 별칭

--예제(두번째방식)--
SELECT
A.NAME, --A테이블의 NAME조회
B.AGE --B테이블의 AGE조회
FROM EX_TABLE A,JOIN_TABLE B
*/

---------------------------------------
--CROSS JOIN
---------------------------------------
--상호조인, 
--on 조건절 없이, 좌측테이블 행과 우측테이블의 행이 연결될수 있는 모든경우의수를 포함한 결과집합.
--Cartesian's  Product 
--216=24*9

select *
from employee e cross join department d ;
--(oracle)
select *
from employee E, department D;

select *
from employee e cross join department d ;
--일반컬럼,그룹함수  결과를 함께조회.
select trunc(avg(salary))
from employee;
--별칭 으로 사용 가능하다 
select emp_name, salary,avg,salary-avg diff
from employee e cross join (select trunc(avg(salary))avg
            from employee)A;
/*
--문법--
SELECT
테이블별칭.조회할칼럼,
테이블별칭.조회할칼럼
FROM 테이블 별칭,테이블 별칭2

--예제--
SELECT
A.NAME, --A테이블의 NAME조회
B.AGE --B테이블의 AGE조회
FROM EX_TABLE A,EX_TABLE B
*/
--------------------------------------
--self join
--------------------------------------
--조인시 같은테이블을 좌/우측 테이블로 사용.
--사번,사원명,관리자사번,관리자명 조회

select E1.emp_id,
            E1.emp_name, 
            E1.manager_id,
            E2.emp_id,
            E2.emp_name
from employee E1 join employee E2
    on E1.manager_id  = E2.emp_id;

------------------------------------------
-- MULTIPLE JOIN
------------------------------------------
--한번에 좌우 두 테이블씩 조인하여 3개이사의 테이블을 연결함.

--사원명, 부서명, 지역명, 직급명 
select * from employee; --E.dept_code
select * from department; --D.dept_id, D.location_id
select * from location; --L.local_code

select E.emp_name,
            D.dept_title,
            l.local_name,
            J.job_name
from employee E 
    left join department D
        on E.dept_code = D.dept_id
    left join location L
        on D.location_id = L.local_code
    join job J
        on E.job_code = J.job_code;
--where E.emp_name = '송종기';

--조인하는 순서를 잘 고려할 것. 
--left join으로 시작했으면, 끝까지 유지해줘야 데이터가 누락되지 않는 경우가 있다.

--(oracle)
select *
from employee E, department D, location L, job J
where E.dept_code = D.dept_id(+) 
    and D.location_id = L.local_code(+)
    and E.job_code = J.job_code;

--직급이 대리,과장 이면서 ASIA지역에는 근무하는 사원조회
--사번,이름 ,직급명,부서명,급여 ,근무지역 국가
select E.emp_id 사번, E.emp_name 이름, J.job_name 직급명, D.dept_id 부서명, E.salary 급여, L.local_name 근무지역, N.national_code 국가
from employee E 
        left join job J on E.job_code = J.job_code
        left join department D on E.dept_code = D.dept_id
        left join location L on D.location_id = L.local_code
        left join nation N on L.national_code= N.national_code
where L.local_name like '%ASIA%' and J.job_name like '대리' or J.job_name like '과장';
---------------------------------------
--NON -EQUI-JOIN
----------------------------------------
--employee,sal_grade 테이블을 조인 
--employee 테이블의 sal_level 컬럼이없다고 가정 
--employee.salary 컬럼과 sal_grade_min _sal|sal_grade_max _sal 비교해서 join
select*from employee;
select*from sal_grade;
select*
from employee e
    join sal_grade s
    on e.salary between s.min_sal and s.max_sal;

--조인조건절에 따라 1행에 여러행이 연결된 결과를 얻을수 있다.
select *        
from employee E
    join department D
        on E.dept_code != D.dept_id
order by E.emp_id, D.dept_id;

--===========================
--SET OPERATOR
--===========================
-- 집합연산자,entity를 컬럼수가 동일하다는 조건한에 상하로 연결
--select절의 컬럼수가 동일
--컬럼별이 자료형이 상호호환 가능해야 한다 .문자열(char,varchhar2)끼리 ok날짜형+문자열 error
--컬러명이 다른경우,첫번째 enity의 컬럼명을 결과집합에 반영
--orderr by ㄹ는 마지막 entity에서 딱 한번 만 사용가능 
--집합 연산자
--Union 합집합
--union all 합집합
--intersect 교집합
--minus

/**
a={1,3,2,5}
b={2,4,6}

a union b=>{1,2,3,4,5,6}중복제거,첫번째 컬럼기준으로 오름차순 정렬
a union all b=>{1,3,2,5,2,4,6}
a intersect b =>{2}
a minus b => {1,3,5}

**/    

-------------------------
--union |union all
---------------------------
--A D5 부서원의 사번,사원명,부서코드,급여 
select emp_id,emp_name,dept_code ,salary
from employee 
where dept_code ='D5';

--B : 급여가 300만이 넘는 사원조회(사번, 사원명, 부서코드, 급여)
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;

--A UNION B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
--order by salary 마지막 entity에서만 사용가능
union           -- 오름차순 
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000
order by dept_code;


--A UNION ALL B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
union all       --union 합집합: 중복된 행x , 첫컬럼 오름차순 정렬
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000
order by dept_code;

--A INTERSECT B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
intersect       --교집합 
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;

--A MINUS B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
minus       --차집합 
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;

select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000
minus
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5';

--=========================================
--SUB QUERY
--=========================================
--하나의 sql문 (main-query)안에종속된 또 다른 sql문(sub-query)
--존재하지 않는값, 조건에 근거한 검색등을 실행할때.

--반드시 소괄호로 묶어서 처리할것
--sub-query 내에는 order by 문법지원 안함.
--연산자 오른쪽에서 사용할것 where col=()

--노옹철사원의 관리자 이름을 조회
select * from employee;

select A.emp_id "사원 사번",
       A.emp_name "사원 이름",
       B.emp_name "매니저 이름"
from employee A, employee B
where A.manager_id = B.emp_id
      and A.emp_name = '노옹철';

--노옹철사원의 관리자 이름을 조회
select E1.emp_name 사원명,
        E2.emp_name 관리자
from employee E1
    join employee E2
        on E1.manager_id = E2.emp_id
where E1.emp_name = '노옹철';

--1.노옹철 사원행 manager_id 조회 
--2.emp_id가 조회한 manager_id와 동일한 행의 emp_name을 조회 
select manager_id
from employee
where emp_name ='노옹철';

--노옹철사원의 관리자 이름을 조회 sub query 로 이용한 
select emp_name
from employee
where emp_id =(select manager_id
                            from employee
                            where emp_name ='노옹철');

/*
1.단일행 단일컬럼 서브쿼리 
2.다중행 단일컬럼 서브쿼리 
3.다중열  서브쿼리(단일행/다중행)

4.상관서브<---->쿼리
5.스칼라 서브쿼리 
6.inline-view 
*/
----------------------------
--단일행 단일컬럼 서브쿼리 
----------------------------
--서브쿼리 조회결과가 1행 1열인 경우 

--(전체평균급여)보다 많은 급여를 받는사원조회 
select emp_name 급여
from employee
where salary > (select avg(salary) from employee);      --전체평균(select(salary) from employee)

select emp_name
        ,salary
from employee
where salary>(select round(avg(salary),1)
                    from employee);
                    
--(전체평균급여)보다 많은 급여를 받는 사원 조회
select emp_name, 
            salary, 
            trunc((select avg(salary)
                      from employee)) avg
from employee
where salary > (select avg(salary)
                          from employee);

-- 윤은해사원과 같은 급여를 받는사원조회 (사번,이름,급여)
select emp_id 사번 , emp_name 이름 , salary 급여 
from employee
where salary = (select salary
                        from employee
                        where emp_name = '윤은해')
                        and emp_name!= '윤은해';           -- 윤은해를 제외한
                        
--D1,D2부서원 중에 D5부서의 평균급여보다 많은 급여를 받는사원조회 (부서코드,사번,사원명,급여)
select dept_code 부서코드, emp_id 사번, emp_name 사원명, salary 급여
from employee
where dept_code in ('D1','D2') and salary>(select trunc(avg(salary),1)
from employee
where dept_code in 'D5');

--예제 연습방법
select dept_code, emp_no, emp_name, salary
from employee
where salary > (select avg(salary) from employee  where dept_code = 'D5')
group by dept_code, emp_no, emp_name, salary
having dept_code in ('D1','D2');

------------------------------------
--다중행 단일컬럼 서브쿼리 
------------------------------------
--연산자  in |not in |any|all|exists 와 함께 사용하능한 서브쿼리 

--송종기,하이유 사원이 속한 부서원 조회 

select emp_name,dept_code
from employee
where dept_code in (select  dept_code
from employee
 where emp_name in('송종기','하이유')     -- 송종기 ,하이유 속한 부서원 체크 
);

select emp_name,dept_code
from employee
where dept_code in (select  dept_code
from employee
 where emp_name in('대북혼','심봉선')     -- 대북혼 ,심봉선 속한 부서원 체크 
);

select  dept_code
from employee
 where emp_name in('송종기','하이유');
 
 
 --차태연,전지연 사원의 급여등급 (sal_level)과 같은 사원조회(사원명,직급명,급여등급 조회)
 
select emp_name 사원명 , job_name 직급명 , sal_level 급여등급 
from employee
join job 
using (job_code)
where sal_level in (select sal_level
                                from employee
                                where emp_name in ('차태연', '전지연')            --sal_level S5,S4 
                                )
                                and emp_name not in ('차태연','전지연');

--직급명(job,job_name) 이대표,부사장이 아닌 사원조회 (사번,사원명,직급코드)
select emp_id,
emp_name,
job_code
from employee E
where e.job_code not in (
    select job_code
    from job
    where job_name in ('대표','부사장')
);
--ASIA1지역에 근무하는 사원조회 (사원명 ,부서코드)
-- 
select * from location;
select * from department;
select emp_name 사원명 , dept_code 부서코드 
from employee
where dept_code in (
                            select dept_id
                            from department
                            where location_id in (
                                        select local_code
                                        from location
                                        where local_name = 'ASIA1'
                                        )
                            );
--------------------------------------
--다중열 서브쿼리
--------------------------------------
-- 서브쿼리의 리턴된 컬럼이 여러개인 경우,
--퇴사한 사원과 같은부서, 같은직급의 사원조회(사번,부서코드,직급코드)
--in 연산자는 다중행 다중컬럼 처리가능

select emp_name,
            dept_code,
            job_code
from employee
where (dept_code,job_code )= (select dept_code, job_code
from employee
where quit_yn = 'Y');

--manager 가 존재하지않는 사원과 같은부서코드, 직급코드를 가진 사원조회
select emp_name,
            dept_code,
            job_code
from employee
where (nvl(dept_code, 'D0'), job_code) in (
                                                select nvl(dept_code, 'D0'), job_code
                                                from employee
                                                where manager_id is null
                                            );

--부서별  최대급여를 받는 사원조회(사원명,부속코드,급여)
select emp_name 사원명 , nvl(dept_code, '인턴') 부서코드, salary 급여         --테이블
from employee
where (nvl(dept_code, '인턴'), salary) in (select nvl(dept_code, '인턴'), max(salary)
                             from employee
                             group by dept_code)        --group  by 절 
order by 2;

--부서별  최소급여를 받는 사원조회(사원명,부속코드,급여)
select emp_name 사원명 , nvl(dept_code, '인턴') 부서코드, salary 급여         --테이블
from employee
where (nvl(dept_code, '인턴'), salary) in (select nvl(dept_code, '인턴'), min(salary)
                             from employee
                             group by dept_code)        --group  by 절 
order by 2;

-----------------------------------
--상관 서브쿼리 
-----------------------------------
--상호연관,서브쿼리 
--메인쿼리의 값을 서브쿼리에 전달하고,서브쿼리 수행후 결과를 다시 메인쿼리에 반환

--직급별 평균급여보다 많은급여를 받는사원조회 
--상관서브쿼리로 처리 
select emp_name, job_code, salary
from employee E     --메인쿼리 테이블 별칭이 반드시필요
where salary > (select avg(salary)
                from employee
                where job_code = E.job_code);
                
select emp_name,dept_code,salary
from employee E 
where salary>(select avg (salary)
                from employee 
                where dept_code=E.dept_code);
                

select job_code ,avg(salary) avg 
from employee
group by job_code;

--join 으로 처리 
select E.emp_name,
            E.job_code,
            E.salary
from employee E join (select job_code, trunc(avg(salary)) avg
                                    from employee
                                    group by job_code)  J
        on E.job_code = J.job_code
where E.salary > J.avg;   

---부서별 평균급여보다 적은급여를 받는사원조회 
select emp_name,
        nvl(dept_code, '인턴'),       --인턴 포함
        salary
from employee E         --메인쿼리 테이블 별칭 필요
where salary < (select avg(salary)
                from employee
                where nvl(dept_code, '인턴') = nvl(E.dept_code, '인턴'));   --where 인턴포함
                
 ---부서별 평균급여보다 많은급여를 받는사원조회 
select emp_name,
        nvl(dept_code, '인턴'),       --인턴 포함
        salary
from employee E         --메인쿼리 테이블 별칭 필요
where salary > (select avg(salary)
                from employee
                where nvl(dept_code, '인턴') = nvl(E.dept_code, '인턴'));   --where 인턴포함

--exists 연산자
--exists(sub-query) sub-query에 행이 존재하면 참, 행이 존재하지않으면 거짓 

select *
from employee 
where 1=1;     --true       결과행이 존재한다.  결과집합이 참일때만 결과값이나온다

select *
from employee 
where 1=0;     --false      결과행이 존재하지않는다.

--행이 존재하는 subque :exists true
select *
from employee 
where exists(select *
from employee 
where 1=1
);
--행이 존재하지않는 subquery:exists false
select *
from employee 
where exists(select *
from employee 
where 1=0
);

--관리하는 직원이 한명이라도 존재하는 관리자 사원조회 
--내 emp_id 값이 누군가의 manager_id로 사용된다면,나는 관리자 ! 
--내 emp_id 값이 누군가의 manager_id로 사용된다면,나는 관리자 가아님
select emp_id,emp_name 
from employee   e
where exists(
    select*
    from employee 
    where manager_id =e.emp_id
);

select*     --행의 존재여부  확인
from  employee e;

select * 
from employee 
where manager_id='203';


--부서테이블에서 실제 사원이 존재하는 부서만조회 (부서코드 설명)
select dept_id,이블
            dept_title 
            from department d
            where exists (
                    select *        --행 존재 여부 확인  1도 사용가능 존재여부 
                    from employee
                    where dept_code = d.dept_id
                    );
                    
                    select*from department d;
                    
                select 1 
                from employee 
                where dept_code='D2';
--부서테이블에서 실제 사원이 존재하지않는 부서만조회 (부서코드 설명)  
--not exists (sub-query) :sub-query의 결과행이 존재하지않으면 true,
--sub-query의 결과행이 존재하면 false

select dept_id,
            dept_title 
            from department d
            where not exists (
                    select *        --행 존재 여부 확인  1도 사용가능 존재여부 
                    from employee
                    where dept_code = d.dept_id
                    );
--최대/최소값 구하기(not exists)
--가장 많은급여 를 받은 사원을 조회
--가장많은 급여를받는다 -> 본인보다 많은급여를 받는사원이 존재하지 않는다 
select emp_name,
            salary  
            from employee e 
            where not exists (
                    select *        --행 존재 여부 확인  1도 사용가능 존재여부 
                    from employee
                    where salary > e.salary
                    );
                    
--ex)가장 적은급여를받는다 
select emp_name,
            salary  
            from employee e 
            where not exists (
                    select *        --행 존재 여부 확인  1도 사용가능 존재여부 
                    from employee
                    where salary < e.salary
                    );
---------------------------------------
--SCALA SUBQUERY
---------------------------------------
--서브쿼리의 실행결과 1 (단일행 단일컬럼) 인 상관서브쿼리 

--관리자이름조회 

select emp_name,
       nvl((
        select emp_name
        from employee
        where emp_id = e.manager_id
        ) ,' ')manager_name 
        from employee e;
--사원명,부서명 ,직급명 조회 
select emp_name 사원명 ,
         nvl ((
                select dept_title       부서명 
                from department
                where E.dept_code = dept_id
            ),'인턴') dept_name,
            (
                select job_name     직급명 
                from job
                where E.job_code= job_code
            ) job_name
from employee E;

----------------------------------
--INLINE VIEW
----------------------------------
--from 절에 사용된 subquery .가상테이블.

--여사원의 사번, 성별조회 
select emp_id,
            emp_name,
            decode(substr(emp_no,8,1),'1','남','3','남','여') gender
from employe,
WHERE
    decode(substr(emp_no, 8, 1), '1', '남', '3', '남',
           '여') = '여';

--INLINE VIEW
    SELECT
    *
FROM
    (
        SELECT
            emp_id,
            emp_name,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남',
                   '여') gender
        FROM
            employee
    );

SELECT
    *
FROM
    (
        SELECT
            emp_id,
            emp_name,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남',
                   '여') gender
        FROM
            employee
    );
                    
                    
SELECT emp_id,
                emp_name,
                gender
FROM
    (
        SELECT
            emp_id,
            emp_name,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남',
                   '여') gender
        FROM
            employee
    );
--30~50세 사이의 여사원 조회 (사번,이름,부서명,나이,성별)
--inline-view 나이,성별
select emp_id 사번,
           emp_name 이름,
           nvl(dept_code,'인턴') 부서명,
           age 나이,
           gender 성별
from (
    select emp_id,
    emp_name,
    dept_code,
    decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender,
    extract(year from sysdate)-(decode(substr(emp_no, 8, 1), '1', 1900+substr(emp_no, 1, 2), '2', 1900+substr(emp_no, 1, 2), 2000+substr(emp_no, 1, 2)))+1 age
    from employee
)
where gender ='여'
and age > 30
and age < 50;
--강사님 풀이버전 
select *
from (
            select emp_id, 
                        emp_name,
                        nvl((select dept_title from department where dept_id = E.dept_code), '인턴') dept_title,
                        extract(year from sysdate) -
                        (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age,
                        decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
            from employee E
        ) 
where age between 30 and 50 
    and gender = '여';
--================================
--고급쿼리
--================================

-----------------------------------
--TOP-N분석
-----------------------------------
--급여를 많이 받는 top-5 ,입사일이 가장 최근인 Top-10 조회등 

select emp_name,salary
from employee
order by salary desc;


--rownum|rowid 
--rownum :테이블 레코드 추가시 1부터 1씩증가하면서 부여된 일련번호,부여된 번호는 변경불가
--               inlineview생성시,where절 사용시 rownum은 새로 부여된다
--rownum 행번호
--rowid :테이블 특정레코드에 접근하기 위한 논리적 주소값 

select rownum,rowid,e.*
from employee e
order by salary desc;
--where절 사용시 rownum새로부여 
select rownum, e.*
from employee e 
where dept_code='D5';

select rownum, E.*
from (
        select 
--                    rownum old,
                    emp_name, 
                    salary
        from employee
        order by salary desc
        ) E
where rownum between 1 and 5;

--입사일이 빠른 10명 조회 
select rownum, E.*
from (
        select rownum old, emp_name, hire_date
        from employee
        order by hire_date asc      --느린경우 desc   
        ) E
where rownum between 1 and 10;      --10명조회 구간

--ex)입사일 느린 10명 조회

select rownum, E.*
from (
        select rownum old, emp_name, hire_date
        from employee
        order by hire_date desc
        ) E
where rownum between 1 and 10;

 
--입사일이 빠른순서 로 6번째에서 10번째 사원조회
--rownum은 where절이 시작하면서 부여되고, where절이 끝나면 모든행에 부여가 끝난다.
--offset이 있다면, 정상적으로 가져올수가 없다.
--inlineview를 한계층 더 사용해야한다.
select E.*
from (
            select rownum rnum, E.*
            from (
                        select emp_name, 
                                    hire_date
                        from employee
                        order by hire_date asc
                    ) E
            ) E        
where rnum between 6 and 10;



--직급이 대리인 사원중에 연봉 Top-3조회(순위,이름,연봉)
select emp_name,
        salary * 12
from (
        select rownum old, emp_name, salary
        from employee E
        where job_code in (select job_code from job where job_name = '대리')     
        order by  salary * 12  desc -- 연봉3순위
      ) E
where rownum < 3+1;     

-- 직급이 대리인 사원 중에서 연봉 4~6위(순위,이름, 연봉)

select E.*
from ( select rownum rnum, E.*     
from (
        select  emp_name, salary * 12
        from employee E
        where job_code in (select job_code from job where job_name = '대리')
        order by  salary * 12  desc
      ) E
      ) E
where rnum between 4 and 6; 
--강사님이 풀었던  방법
select E.*
from (
        select rownum rnum, 
                    E.*
        from (
                select emp_name,
                            (salary + (salary * nvl(bonus, 0))) * 12 annual_salary
                from employee
                where job_code = (  
                                                    select job_code
                                                    from job
                                                    where job_name = '대리'
                                                )
                order by annual_salary desc
                ) E
        ) E
where rnum between 4 and 6;

--부서별 평균급여 Top-3조회 (순서,부서명 ,평균급여)
select rownum 순위,
       (select dept_title from department where dept_id = E.dept_code) 부서명,
       avg 평균급여
from (
      select dept_code, trunc(avg(salary)) avg
      from employee
      group by dept_code
      order by avg desc
     ) E
where rownum <= 3;

--급여 상위 6~10위 조회
select *
from (
    select rownum rnum, E.*
    from (
        select emp_name, salary
        from employee
        order by salary desc -- level 1 : 랭킹 1위부터 10위까지는 여기서 이미 정렬됨
        ) E 
    ) E -- level2 : 여기서 새로 rownum 부여하는 작업
where rnum between 6 and 10;


/*
select E.*
from (
            select rownum rnum, E.*
            from (
                        <<정렬된 ResultSet>>
                    ) E
            ) E        
where rnum between 시작 and 끝;
*/
--with구문
--inlineview서브쿼리에 별칭을 지정해서 재사용하게 함.
with emp_hire_date_asc
as
(
select emp_name, 
            hire_date
from employee
order by hire_date asc
)
select E.*
from (
            select rownum rnum, E.*
            from emp_hire_date_asc E
            ) E        
where rnum between 6 and 10;

-------------------------------
--WINDOW FUNCTION
-------------------------------
--행과 행간의 관계를 쉽게 정의하기 위한 표준함수
--1.순위함수
--2.집계함수
--3.분석함수

/*
window_funcion(args) over([partiotion by절] [order by 절] [windowing절 ])
1.args 윈도우 함수인자 0~ n개 지점 
2.partition by절: 그룹핑
3.order by절 :정렬기준 컬럼
4.windowing절 :처리할 행의 범위를 지정 
*/

--rank()  over() :순위를 지정 
--dense_rank  over(): 빠진숫자없이 순위를 지정 
select emp_name,
            salary, 
            rank()over(order by salary desc)rank,--내림차순 정렬
            dense_rank()over(order by salary desc)rank
from employee ;

--그룹핑에 따른 순위지정 
select E.*
from (
        select emp_name,
                    dept_code,
                    salary,
                    rank() over(partition by dept_code order by salary desc) rank_by_dept
        from employee
        ) E
where rank_by_dept between 1 and 3;

--sum() over() 
--일반 컬럼과 같이 사용할수있다 .
select emp_name,
            salary,
            dept_code,
--(select sum (salary) from employee)sum,
        sum(salary) over()"전체사원급여합계",
        sum(salary) over (partition by  dept_code)"부서별 급여합계",
        sum(salary) over (partition by  dept_code order by salary)"부서별 급여누계_급여"
         from employee;

--avg() over() 
select  emp_name,   
            dept_code,
            round(avg(salary) over(partition by dept_code)) "부서별 평균급여" 
from employee;
--count() over() 
select emp_name,    
            dept_code,
            count(*) over(partition by dept_code) cnt_by_dept
            from employee;
