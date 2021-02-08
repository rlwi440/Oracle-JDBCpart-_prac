--@실습문제:tb_number테이블에 난수 100개를 저장하는 익명블럭을 생성하세요.
--실행시마다 생성된 모든 난수의 합을 콘솔에 출력할것 
--@실습문제 : tb_number테이블에 난수 100개(0 ~ 999)를 저장하는 익명블럭을 생성하세요.
--실행시마다 생성된 모든 난수의 합을 콘솔에 출력할 것.
create table tb_number(
    id number, --pk sequence객체로 부터 채번
    num number, --난수
    reg_date date default sysdate,
    constraints pk_tb_number_id primary key(id)
);

create sequence seq_number_id 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
cache 20;

declare 
    rnd number;
    n number=0; 
    for n in 1..100 loop        --1~100사이 
    rnd: = trunc(dbms_random.value(0,1000));    --1000개 랜덤숫자 
     insert into tb_number values(seq_tb_number.nextval,rnd sysdate);       --nextval은 다음 번호표를 주는 친구
    n: = n + rnd;       --난수의합 
    end loop;
    
    dbms_output.put_line('난수의 합 = ' || n);
    end;
    /
    
    drop table tb_number;
    drop sequence seq_num_id;
    
    select * from tb_number;