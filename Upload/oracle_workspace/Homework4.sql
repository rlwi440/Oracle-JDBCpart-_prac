/*
1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
정렬은 이름으로 오름차순 표시하도록 한다. 
*/
select * from tb_student;
select student_name 이름, student_address 주소지
from tb_student
order by student_name asc; 
/*
2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
*/
select student_name 이름, student_SSN 주민번호
from tb_student
where absence_yn ='Y'
order by student_SSN desc; 
/*
3. 주소지가 강원도나 경기도인 학생들 중 1900 년대 학번을 가진 학생들의 이름과 학번,
주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는 "학생이름","학번",
"거주지 주소" 가 출력되도록 핚다.
*/
select student_name 학생이름,student_no 학번, student_address  거주지주소
,to_char(ENTRANCE_DATE,'YYYY')      --to_char 날짜/숫자를 문자열로 표현
,to_char(ENTRANCE_DATE,'YYYY/MM/DD') --to_char 날짜/숫자를 문자열로 표현
from tb_student where ((STUDENT_ADDRESS like '강원%' or
 STUDENT_ADDRESS like '%경기%') and to_char(ENTRANCE_DATE,'YYYY') like '19__') 
 order by student_name;
 /*
 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인핛 수 있는 SQL 문장을
작성하시오. (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아
내도록 하자)
*/
select professor_name,professor_ssn
from tb_professor 
join tb_department using (department_no)
where department_name ='법학과'
order by 2;
/*
5. 2004 년 2 학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 핚다. 학점이
높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을
작성해보시오.
*/
select STUDENT_NO,round(point,2)
from tb_grade
where class_no='C3118100' and term_no = '200402'        --2004년 2학기 
order by  point desc;

/*
6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL
문을 작성하시오.
*/
select student_no,student_name, department_name
from tb_student,tb_department
where tb_department.department_no = tb_student.department_no
order by student_name asc;          --asc 생략가능 

/*
7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
*/
select class_name,department_name
from tb_class,tb_department
where tb_department.department_no = tb_class.department_no;     --각각 비교결과가 전체결과 될수있다             

/*
8. 과목별 교수 이름을 찾으려고 핚다. 과목 이름과 교수 이름을 출력하는 SQL 문을
작성하시오.
*/
select class_name ,professor_name
from tb_class,tb_professor,tb_class_professor
where tb_class.class_no = tb_class_professor.class_no  
and tb_professor.professor_no = tb_class_professor.professor_no;

/*
9. 8 번의 결과 중 ‘인문사회’ 계열에 속핚 과목의 교수 이름을 찾으려고 핚다. 이에
해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
*/
select class_name, professor_name
from tb_class,tb_class_professor,tb_professor,tb_department
where tb_class.class_no = tb_class_professor.class_no
and tb_professor.professor_no = tb_class_professor.professor_no 
and tb_professor.department_no = tb_department.department_no and category='인문사회';


/*
10. ‘음악학과’ 학생들의 평점을 구하려고 핚다. 음악학과 학생들의 "학번", "학생 이름",
"전체 평점"을 출력하는 SQL 문장을 작성하시오. (단, 평점은 소수점 1 자리까지만
반올림하여 표시한다.)
*/
select tb_student.student_no as 학번, tb_student.student_name as "학생 이름", round(avg(point),1) as "전체 평점"
from tb_grade,tb_student,tb_department
where tb_department.department_no = tb_student.department_no and department_name='음악학과' and tb_student.student_no = tb_grade.student_no
group by tb_student.student_no,tb_student.student_name
order by tb_student.student_no;

/*
11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 젂달하기
위핚 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용한  SQL 문을
작성하시오. 단, 출력헤더는 학과이름,학생이름, 지도교수이름으로
출력되도록 한다.
*/
select department_name 학과이름,student_name  학생이름, professor_name 지도교수이름 
from tb_student, tb_department,tb_professor
where tb_student.department_no = tb_department.department_no and
tb_student.coach_professor_no=tb_professor.professor_no and tb_student.student_no = 'A313047';

/*
12. 2007 년도에 '인갂관계론' 과목을 수강핚 학생을 찾아 학생이름과 수강학기를 표시하는
SQL 문장을 작성하시오.
*/
select student_name, term_no
from tb_student,tb_grade,tb_class
where tb_student.student_no = tb_grade.student_no and tb_class.class_no=tb_grade.class_no
and term_no like '2007%' and class_name = '인간관계론';
/*
13. 예체능 계열 과목 중 과목 담당교수를 핚 명도 배정받지 못핚 과목을 찾아 그 과목
이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
*/
select class_name, department_name
from tb_class
        left join tb_class_professor using(class_no)
        join tb_department using(department_no)
where category='예체능'
        and professor_no is null
order by department_name ;
/*
14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 핚다. 학생이름과
지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우 "지도교수 미지정"으로
표시하도록 하는 SQL 문을 작성하시오. 단, 출력헤더는 "학생이름", "지도교수"로
표시하며 고학번 학생이 먼저 표시되도록 핚다.
*/
select
          s.student_name 학생이름,          --student_name학생이름 
          nvl((         --nvl 추가 
            select p.professor_name
            from tb_professor p
            where p.professor_no = s.coach_professor_no         -- 지도 교수가 없는 학생일 경우 "지도교수 미지정"         
          ),'지도교수 미지정') 지도교수
from tb_student s, tb_department d
where s.department_no = d.department_no
    and d.department_name = '서반아어학과'        --춘 기술대학교 서반아어학과 출력 
order by s.student_no;

/*
15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과
이름, 평점을 출력하는 SQL 문을 작성하시오.
*/
select s.student_name, avg(g.point)
from tb_student s , tb_grade g
where s.student_no = g.student_no(+) --기준테이블의 반대편 컬럼에 (+)를 추가
    and s.absence_yn = 'N'
group by s.student_no,s.student_name
having avg(g.point) >= 4.0 ;
/*
16. 환경조경학과 전공과목들의 과목 별 평점을 파악핛 수 있는 SQL 문을 작성하시오.
*/
select c.class_no, c.class_name, avg(g.point)
from tb_class c, tb_department d, tb_grade g
where c.department_no = d.department_no
 and c.class_no = g.class_no
and c.class_type like '전공%'  --%아무문자 0개 이상      
and d.department_name = '환경조경학과'
group by c.class_no, c.class_name
order by c.class_no;
/*
17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는
SQL 문을 작성하시오.
*/
select student_name,student_address
from tb_student
where department_no=(select  department_no from tb_student where student_name ='최경희');
/*
18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을
작성하시오.
*/SELECT
    student_no,
    student_name
FROM
         tb_student
    JOIN tb_department USING ( department_no )
    JOIN tb_grade USING ( student_no )
WHERE
    department_name = '국어국문학과'
GROUP BY
    student_no,
    student_name
HAVING
    AVG(point) = (
        SELECT
            MAX(AVG(point))--그룹조건절 가장높은 max
                                        FROM
                 tb_grade
            JOIN tb_student USING ( student_no )
            JOIN tb_department USING ( department_no )
        WHERE
            department_name = '국어국문학과'      --국어국문학과
        GROUP BY
            student_no
    );
/*
19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을
파악하기 위한 적절한 SQL 문을 찾아내시오. 단, 출력헤더는 "계열 학과명",
"전공평점"으로 표시되도록 하고, 평점은 소수점 핚 자리까지만 반올림하여 표시되도록
한다.
*/
select department_name "계열학과명", round(avg(point),1)
from tb_department
  join tb_student using(department_no)
  join tb_grade using(student_no)
where category=(select category
                from tb_department
                where department_name='환경조경학과')
group by department_name;