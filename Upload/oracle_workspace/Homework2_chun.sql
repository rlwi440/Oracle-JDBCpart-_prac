--@실습문제 : INNER JOIN & OUTER JOIN
--1. 학번, 학생명, 학과명을 출력
select * from tb_student;
select * from tb_department;
select s.student_no  학번,
            s. student_name 학생명,
            d.department_name  학과명
from tb_student s 
            join tb_department d 
            using(department_no)
order by 1;
--2. 학번, 학생명, 담당교수명을 출력하세요.
--담당교수가 없는 학생은 '없음'으로 표시
select * from tb_professor;
select s.student_no 학번, s.student_name 학생명, nvl(professor_name, '없음') 담당교수명
from tb_student s left join tb_professor p
    on s.coach_professor_no = p.professor_no;
    
--3. 학과별 교수명과 인원수를 모두 표시하세요.
select * from tb_department;
select * from tb_professor;

select department_name 교수명,
        nvl2(professor_name, professor_name, count(*)) 인원수 
from tb_department
    join tb_professor       --자식클래스
        using(department_no)        --기준 컬럼명이 같을경우  
group by cube(professor_name), department_name
order by department_name;

  /*
  --null 처리함수
  select emp_name,
            bonus,
            nvl(bonus, 0) nvl1,
            nvl2(bonus, '있음', '없음') nvl2
            from employee;
*/

-- 4. 이름이 [~람]인 학생의 평균학점을 구해서 학생명과 평균학점(반올림해서 소수점둘째자리까지)과 같이 출력.
-- (동명이인일 경우에 대비해서 student_name만으로 group by 할 수 없다.)
select s.student_name 학생명, 
round(avg(point),2) 평균학점        --반올림해서 소수점 둘째자리 까지 
from tb_student s, tb_grade g 
where s.student_no = g.student_no 
and student_name like '%람'
group by s.student_no, s.student_name;
--5. 학생별 다음정보를 구하라.
/*
--------------------------------------------
학생명  학기     과목명    학점
--------------------------------------------
감현제	200401	전기생리학 	4.5
            .
            .
--------------------------------------------
*/
select * from tb_grade;
select * from tb_student;
select * from tb_class;
select student_name 학생명, term_no 학기,class_name 과목명,point 학점
from tb_student s ,tb_grade g , tb_class c
where s.student_no=g.student_no and g.class_no =c.class_no
order by 1,2;