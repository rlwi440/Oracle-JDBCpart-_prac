/*
기술지원부에 속한 사람들의 사람의 이름,부서코드,급여를 출력하시오
*/
select e.emp_name 사원명, e.dept_code 부서코드,e.salary 급여,d.dept_title 부서명 
from employee e,department d
where d.DEPT_ID=e.dept_code and d.DEPT_TITLE in('기술지원부');
/*
문제2
기술지원부에 속한 사람들 중 가장 연봉이 높은 사람의 이름,부서코드,급여를 출력하시오
*/
select e.emp_name 사원명, e.dept_code 부서코드,e.salary 급여
from employee e
left join department d
on e.dept_code =d .dept_id 
where (dept_code ,salary)in( select dept_code, max(salary)     --최대급여 max 
from employee
group by dept_code)
and D.dept_title = '기술지원부';
/*
문제3
매니저가 있는 사원중에 월급이 전체사원 평균을 넘고 
사번,이름,매니저 이름, 월급을 구하시오. 
1. JOIN을 이용하시오
2. JOIN하지 않고, 스칼라상관쿼리(SELECT)를 이용하기
*/
--1.JOIN을 이용하시오 
select A.emp_id "사원 사번",
       B.emp_name "사원 이름",
       A.emp_name "매니저 이름",
       B.salary "월급"
from employee A join employee B
on A.emp_id =B.emp_id 
where B.salary > (select avg(salary) from employee);
--2. JOIN하지 않고, 스칼라상관쿼리(SELECT)를 이용하기
select emp_id 사번, emp_name 이름, 
(select emp_name from employee  where emp_id =e.manager_id) 매니저이름 ,
salary 급여
from employee e 
where salary >(select trunc(avg(salary)) from employee);
/*
문제4
같은 직급의 평균급여보다 같거나 많은 급여를 받는 직원의 이름, 직급코드, 급여, 급여등급 조회
*/
select emp_name 이름, job_code 직급코드, salary 급여, s.sal_level 급여등급
from employee e join sal_grade s        -- 
on e.sal_level = s.sal_level
where salary >= (select round(avg(salary))          -- 평균보다 같거나 많은 급여 
                from employee
                where job_code= e.job_code);            
/*
문제5
부서별 평균 급여가 3000000 이상인 부서명, 평균 급여 조회
단, 평균 급여는 소수점 버림, 부서명이 없는 경우 '인턴'처리
*/
select  nvl(d. dept_title, '인턴') 
       , trunc(avg(salary))평균급여 
from employee e join department d 
on e.dept_code =d.dept_id
where 3000000<= (select trunc (avg(salary))
            from employee
                where nvl(dept_code, '인턴') = nvl(E.dept_code, '인턴'))
group by nvl(d.dept_title, '인턴');
/*
문제6
직급의 연봉 평균보다 적게 받는 여자사원의
사원명,직급명,부서명,연봉을 이름 오름차순으로 조회하시오
연봉 계산 => (급여+(급여*보너스))*12    
*/
select emp_name 사원명,            
       (select job_name from job where job_code = E.job_code) 직급,           --직급명 
       (select dept_title from department where E.dept_code = dept_id) 부서,      --부서명
       trunc((salary +(salary*bonus)) * 12) 연봉      -- 급여+(급여*보너스))*12)
from (select E.*,   
        decode(substr(emp_no, 8, 1),'1','남','3','남','여') gender
    from employee E) E
where gender = '여' and trunc((salary +(salary*bonus)) * 12)         --여자사원 
                    < (select trunc(avg((salary +(salary*bonus)) * 12))     --평균보다 적게 받는 여자사원 
                       from employee
                        where E.job_code = job_code);               --각각 비교결과가 전체결과 될수있다             
/*
-문제7
--다음 도서목록테이블을 생성하고, 공저인 도서만 출력하세요.
*/
create table tbl_books (
book_title  varchar2(50)
,author     varchar2(50)
,loyalty     number(5)
);
insert into tbl_books values ('반지나라 해리포터', '박나라', 200);
insert into tbl_books values ('대화가 필요해', '선동일', 500);
insert into tbl_books values ('나무', '임시환', 300);
insert into tbl_books values ('별의 하루', '송종기', 200);
insert into tbl_books values ('별의 하루', '윤은해', 400);
insert into tbl_books values ('개미', '장쯔위', 100);
insert into tbl_books values ('아지랑이 피우기', '이오리', 200);
insert into tbl_books values ('아지랑이 피우기', '전지연', 100);
insert into tbl_books values ('삼국지', '노옹철', 200);
select *
from tbl_books t
where (select count(*)
    from tbl_books 
    where book_title =t.book_title) >=2; 
    


