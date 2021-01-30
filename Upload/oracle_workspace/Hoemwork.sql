/*
1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
*/
select 
        '2020년 크리스마스는' || to_char(to_date ('2020-12-25' ,'yyyy-mm-dd'),'Day')||'입니다'
        from dual;
/*
2. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 
사원명, 주민번호, 부서명, 직급명을 조회하시오.
*/ 
select emp_name 사원명, emp_no 주민번호, DEPARTMENT.dept_title 부서명, JOB.job_name 직급명 from
EMPLOYEE JOIN DEPARTMENT on (dept_code=Department.dept_id)
JOIN JOB on (EMPLOYEE.job_code=job.job_code) where (emp_no like '%-2%') 
and (substr(emp_no,1,2) between '70' and '80') and (emp_name like '%전%');

/*
3. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
*/
select emp_no 주민번호 ,emp_id 사번 ,emp_name 사원명 
from employee;
select 
E.emp_id 사번, E.emp_name 사원명,
        extract(year from sysdate) 
        -extract(year from (
        to_date(decode(substr(E.emp_no, instr(E.emp_no, '-')+1, 1), '1', 19, '2', 19, 20) || substr(E.emp_no, 1, 6))))+1 나이,
        D.dept_title 부서명, J.job_name 직급명
from employee E 
        join department D   on E.dept_code = D.dept_id
        join job J          using(job_code)
where extract(year from sysdate) -
        extract(year from (
        to_date(decode(substr(E.emp_no, instr(E.emp_no, '-')+1, 1), '1', 19, '2', 19, 20) || substr(E.emp_no, 1, 6))))+1
        =
        (select min
        (
        extract(year from sysdate) -
        extract(year from (
        to_date(decode(substr(emp_no, instr(E.emp_no, '-')+1, 1), '1', 19, '2', 19, 20) || substr(emp_no, 1, 6))))+1
        ) 
        from employee);
/*
4. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
*/

 select e.emp_id 사번, e.emp_name 사원명, d.dept_TITLE 부서명
 from employee e, department d 
 where e.emp_name like '%형%'and d.dept_id = e.dept_code;
/*
5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오
*/
select e.emp_name 사원명, j.job_name 직급명, e.dept_code 부서코드 ,d.dept_title 부서명 
from employee e,department d,job j 
where d.DEPT_ID=e.dept_code and e.job_code=j.job_code  and
 d.DEPT_TITLE in('해외영업1부','해외영업2부');


/*
6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
*/
select e.emp_name 사원명, e.bonus 보너스포인트, d.dept_title 부서명, l.local_name 근무지역명 from
employee e,department d, location l where (e.dept_code=d.dept_id) and (d.location_id=l.local_code) and (bonus is not null);  

/*
7. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
*/
select e.emp_name 사원명, j.job_name 직급명, d.dept_title 부서명, l.local_name 근무지역명
from employee e, department d,job j, location l 
where e.dept_code='D2'and e.dept_code=d.dept_id 
and l.local_code= d.location_id and e.job_code = j.job_code ;

/*
8. 급여등급테이블의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
(사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
*/
select e.emp_name 사원명, j.job_name 직급명,e.salary 급여, (salary*12+salary*12*NVL(BONUS,0)) 연봉
from employee e, job j, sal_grade s 
where j.job_code=e.job_code and s.sal_level=e.sal_level and e.salary>(s.max_sal-500000);

/*
9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
사원명, 부서명, 지역명, 국가명을 조회하시오.
*/
select E.emp_name 사원명, 
            D.dept_title 부서명, 
            L.local_name 지역명, 
            N.national_name 국가명
from employee E
        join department D   on E.dept_code = D.dept_id
        join location L     on d.location_id = l.local_code
        join nation N       using(national_code)
where national_code in ('KO', 'JP');

/*
10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
self join 사용
*/
select  e1.emp_name 사원명,d.dept_title 부서명,e2.emp_name 동료이름 
from employee e1, employee e2, department d 
where (d.dept_id=e2.dept_code) and (e1.dept_code=d.dept_id) and (e1.emp_name !=  e2.emp_name);


/*
11. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
*/ 
select e.emp_name 사원명, j.job_name 직급명, e.salary 급여 from employee e, job j 
where (e.bonus is null)
and (j.job_name in ('차장','사원')) and (e.job_code=j.job_code);

/*
12. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
*/
select count(decode(quit_yn, 'N', 1)) "재직중인 직원 수", count(decode(quit_yn, 'Y', 1)) "퇴사한 직원 수"
from employee;