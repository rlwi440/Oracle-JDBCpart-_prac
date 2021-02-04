/*
1. 첫번째 테이블 명 : EX_MEMBER
* MEMBER_CODE(NUMBER) - 기본키                       -- 회원전용코드 
* MEMBER_ID (varchar2(20) ) - 중복금지                  -- 회원 아이디
* MEMBER_PWD (char(20)) - NULL 값 허용금지                 -- 회원 비밀번호
* MEMBER_NAME(varchar2(30))                             -- 회원 이름
* MEMBER_ADDR (varchar2(100)) - NULL값 허용금지                    -- 회원 거주지
* GENDER (char(3)) - '남' 혹은 '여'로만 입력 가능             -- 성별
* PHONE(char(11)) - NULL 값 허용금지                   -- 회원 연락처
*/

create table  ex_member(
member_code number,     --기본키
member_id  varchar2(20), --회원아이디 
member_pwd char(20) NOT NULL,   --회원비밀번호
member_name varchar2(30),       --회원이름
member_addr varchar2(100) not null, --회원 거주지
gender char(3),     --성별
phone char (11) not null,   --회원 연락처
constraint pk_ex_memer_code primary key(member_code), -- constraint 제약조건
 constraint uq_ex_member_id  unique(member_id),
 constraints ck_ex_member_gender check(gender in ('남','여'))
);

--제약조건 검색
select constraint_name,
            uc.table_name,
            ucc.column_name,
            uc.constraint_type,
            uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'EX_MEMBER';      --대문자가 데이터로 저장이됩니다. 


/*
2. EX_MEMBER_NICKNAME 테이블을 생성하자. (제약조건 이름 지정할것)
(참조키를 다시 기본키로 사용할 것.)
* MEMBER_CODE(NUMBER) - 외래키(EX_MEMBER의 기본키를 참조), 중복금지       -- 회원전용코드
* MEMBER_NICKNAME(varchar2(100)) - 필수                       -- 회원 이름
*/

--drop table ex_member_nickname

create table ex_member_nickname(
member_code number,
member_nickname  varchar2(100) not null,
constraints fk_ex_member_nickname_id foreign key(member_code) references ex_member(member_code),      --references 다른테이블
constraints pk_ex_membe_nickname_id primary key (member_code)
);

--제약조건 검색
select constraint_name,
            uc.table_name,
            ucc.column_name,
            uc.constraint_type,
            uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'EX_MEMBER_NICKNAME';     --대문자가 데이터로 저장이됩니다
