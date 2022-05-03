-- 조인 *****
-- 사원번호가 7788인 직원의 부서명은?
SELECT DNO
FROM employee
WHERE ENO = 7788;

DESC employee;

SELECT DNAME
FROM department
WHERE dno = 20;

-- 상기 목적을 달성하려면 JOIN을 쓰면 한번에 조회가 가능함
-- 일반 JOIN(EQUAL JOIN, INNER JOIN) : 교집합 
SELECT A.DNO, B.ENAME, A.DNAME, A.LOC
FROM DEPARTMENT A,
     employee B
WHERE B.DNO = A.DNO
AND B.ENO = 7788;


-- 곱 조인(Cartesian Product) : 카디시안 곱
-- DEPARTMENT 건수 : 4건 X employee 건수 : 14건 => 4 * 14 = 56
SELECT count(*)
FROM DEPARTMENT A,
     employee B;
     
-- Equal Join ( = Join )
-- 조인 대상 테이블에서 공통컬럼을 = 비교를 통해 
-- 같은 값을 가지는 행을 연결하여 결과를 생성
-- 성능 향상 팁 : 항상 작은 건수테이블이 먼저 처리되게 만드는게 팁
-- 문법 :
--  SELECT 테이블1.컬럼, 테이블2.컬럼
--  FROM 테이블1, 테이블2
--  WHERE 테이블2.컬럼 = 테이블1.컬럼

-- 문제 1)
-- 각 사원들이 소속된 부서정보 모두 출력
-- ( 단, = 조인 사용하세요 )
SELECT * 
FROM department A,
    employee B
WHERE A.DNO = B.DNO;

-- 문제 2) 사원번호가 7499, 7900인 사원들의 소속된 부서정보 모두 출력
SELECT * 
FROM department A,
    employee B
WHERE A.DNO = B.DNO -- 공통컬럼 찾아서 = 조인함
AND B.ENO IN (7499, 7900);

-- 문제 3) 사원번호가 7500 ~ 7700 사이에 있는 사원들의 소속된 부서정보 출력하되
-- 부서이름이 SALES 인 파트만 출력하세요.
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT
-- 사원번호 컬럼 : ENO
-- 부서이름 컬럼 : DNAME
-- 부서번호 컬럼 : DNO
SELECT A.DNO, 
    A.DNAME, 
    A.LOC
FROM department A,
    employee B
WHERE B.DNO = A.DNO
AND B.ENO BETWEEN 7500 AND 7700
AND DNAME = 'SALES';

-- 테이블 주석 및 컬럼 주석 넣기
-- 테이블 주석
COMMENT ON TABLE DEPARTMENT IS '부서정보';
-- 컬럼 주석
COMMENT ON COLUMN DEPARTMENT.dname IS '부서이름';
COMMENT ON COLUMN DEPARTMENT.dno IS '부서번호';
COMMENT ON COLUMN DEPARTMENT.LOC IS '지역이름';

COMMENT ON TABLE EMPLOYEE IS '직원정보';
-- 컬럼 주석
  COMMENT ON COLUMN EMPLOYEE.ENO         IS '사원번호';
	COMMENT ON COLUMN EMPLOYEE.ENAME IS '사원이름';
	COMMENT ON COLUMN EMPLOYEE.JOB IS '직급';
	COMMENT ON COLUMN EMPLOYEE.MANAGER IS '매니저';
	COMMENT ON COLUMN EMPLOYEE.HIREDATE IS '입사일';
	COMMENT ON COLUMN EMPLOYEE.SALARY IS '월급';
	COMMENT ON COLUMN EMPLOYEE.COMMISSION IS '보너스';
	COMMENT ON COLUMN EMPLOYEE.DNO IS '사원번호';

COMMENT ON TABLE BONUS IS '보너스정보';
-- ENAME(사원이름), JOB(직급), SAL(월급), COMM(보너스)
COMMENT ON TABLE SALGRADE IS '월급정보';
-- GRADE(등급), LOSAL(최저월급), HISAL(최고월급)

-- 특수용례) not equal 조인
-- = 조인이 아닌 범위 조인
-- 월급등급(SALGRADE) 테이블
-- 1등급 : 700 ~ 1200
-- 2등급 : 1201 ~ 1400
-- 5등급 : 3001 ~ 9999
-- 급여 등급을 기준으로 사원의 급여가 몇등급에 속하는 지 알아보고 싶은 1인
SELECT ENAME, SALARY, GRADE
FROM SALGRADE A,
    EMPLOYEE B
WHERE SALARY BETWEEN LOSAL AND HISAL;

-- 상기 예에서 추가 부서 정보 보여주기 
SELECT ENAME, DNAME, SALARY, GRADE
FROM SALGRADE A,
    DEPARTMENT C,
    EMPLOYEE B
WHERE B.DNO = c.DNO
AND SALARY BETWEEN LOSAL AND HISAL;

-- 특수용례) SELF 조인
-- 사원테이블에 MANAGER 컬럼(그 사원 매니저의 사번)
SELECT MAN.ENO, 
        MAN.ENAME AS "직원", 
        MAN.MANAGER AS "매니저 사원번호",
        EMP.ENAME AS "매니저" 
FROM EMPLOYEE EMP,
    EMPLOYEE MAN
WHERE EMP.ENO = MAN.MANAGER
AND MAN.ENAME LIKE 'SMITH%';

-- 특수용례)*** OUTER 조인 
-- = 조인 공통 컬럼을 연결해서 데이터를 보여주는데 
-- NULL값은 = 연산이 안돼기 때문에 데이터에서 제외됨
-- NULL값에 해당되는 다른 컬럼을 보여줘야 될때도 있음
SELECT EMP.ENAME AS "직원", 
        MAN.ENAME AS "매니저"
FROM EMPLOYEE EMP,
     EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.ENO(+);


-- DDL(Data Definition Language) : 데이터 정의어
-- 테이블 만들기, 테이블 수정하기, 컬럼수정하기, 컬럼추가하기
-- 테이블 만들기
-- 예) 부서정보를 저장하기 위한 테이블 생성하기
-- 테이블명 : TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT(
    DNO NUMBER(2),
    DNAME VARCHAR2(20),
    LOC VARCHAR2(20)
);

-- 테이블 삭제하기
DROP TABLE TB_DEPARTMENT;

-- 테이블 복사하기
-- 데이터까지 복사
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT;

-- 데이터까지 복사
-- 데이터 빼고 구조만 복사
CREATE TABLE TB_DEPARTMENT2
AS
SELECT *
FROM DEPARTMENT
WHERE 1=2; -- 거짓으로 조회

DROP TABLE TB_DEPARTMENT;
DROP TABLE TB_DEPARTMENT2;

-- 20번 부서 소속 사원에 대한 정보를 포함한 테이블 생성하기
-- 테이블 이름 : TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM EMPLOYEE
WHERE DNO = 20;

DROP TABLE TB_DEPARTMENT;


-- 테이블 구조를 변경하는 명령어
-- ALTER TABLE ~
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE 1=2;

-- TB_DEPARTMENT 테이블에 컬럼 추가
ALTER TABLE TB_DEPARTMENT
ADD(BIRTH DATE);

DESC TB_DEPARTMENT;

-- TB_DEPARTMENT 테이블에 컬럼 변경
-- DNAME VARCHAR2(14) -> VARCHAR2(20) 변경(수정)
ALTER TABLE TB_DEPARTMENT
MODIFY DNAME VARCHAR2(20);

-- TB_DEPARTMENT 테이블에 컬럼 삭제
-- BIRTH 컬럼 삭제
-- 한번에 하나만 삭제가 가능
ALTER TABLE TB_DEPARTMENT
DROP COLUMN BIRTH;

-- 테이블 이름을 변경하는 명령어
-- 문법) RENAME A TO B : A 테이블명을 B 테이블명으로 바꾸기
RENAME TB_DEPARTMENT02 TO TB_DEPARTMENT;

-- 테이블의 모든 데이터를 제거하는 명령어(데이터 + 할당된공간)
-- 테스트 데이터 생성
CREATE TABLE TB_DEPARTMENT02
AS
SELECT * 
FROM department;
-- 데이터 조회
SELECT * FROM TB_DEPARTMENT02;
-- 데이터 삭제
TRUNCATE TABLE TB_DEPARTMENT02;

-- 딕셔너리 : 추가로 오라클 DB에서 사용하는 
-- 메타정보(생성된 테이블, 컬럼정보, 유저정보 등)를 볼수 있는 테이블
-- USER_xxx : 접속된 유저에 대한 여러가지 정보들 보여줌(컬럼, 테이블 등)
-- ALL_XXX : 접속된 유저 + 다른 유저에 대한 정보들 보여줌(컬럼, 테이블 등)
-- DBA_XXX : 모든 유저에 대한 정보들 보여줌(컬럼, 테이블 등)
SELECT * FROM USER_TABLES;

DROP TABLE TB_DEPARTMENT02;

-- DML(Data Manipulation Language) : 데이터 조작어
-- INSERT / UPDATE / DELETE
-- 현재 유저에 속한 테이블목록 보기
SELECT * FROM USER_TABLES;
-- 필요없는 테이블 삭제
DROP TABLE EMP;
DROP TABLE DEPT;

-- 테스트용 테이블 및 데이터 만들기
CREATE TABLE DEPT_COPY
AS
SELECT * 
FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;
-- 데이터 삭제
TRUNCATE TABLE DEPT_COPY;
-- 데이터 추가하기
INSERT INTO DEPT_COPY
VALUES(10, 'ACCOUNTING', 'NEW YORK');
SELECT * FROM DEPT_COPY;

COMMIT;

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(20, 'RESEARCH', 'DALLAS');

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(30, 'SALES', 'CHICAGO');

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(40, 'OPERATIONS', 'BOSTON');

COMMIT;

SELECT * FROM DEPT_COPY;

-- 데이터 추가 
-- 1) NULL 인값은 생략하고 추가
INSERT INTO DEPT_COPY(DNO, DNAME)
VALUES(50, 'SALES');

SELECT * FROM DEPT_COPY;
-- 2) 명시적으로 NULL 추가 
INSERT INTO DEPT_COPY
VALUES(60, 'OPERATIONS', NULL);

-- 테스트 데이터 및 EMP_COPY 테이블 만들기
CREATE TABLE EMP_COPY
AS 
SELECT *
FROM EMPLOYEE
WHERE 1=2;

SELECT * FROM EMP_COPY;
DESC EMP_COPY;

-- EMP_COPY 테이블에 데이터 넣기
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7000, 'CANDY', 'MANAGER', SYSDATE, 10);

SELECT * FROM EMP_COPY;
-- COMMIT 되기 전으로 되돌리기(작업 취소)
ROLLBACK;
-- DB에 영구 반영
COMMIT;

-- 다른 테이블의 데이터를 복사해서 INSERT 하기
SELECT * FROM DEPT_COPY;
-- 데이터/ 공간 비우기(삭제)
TRUNCATE TABLE DEPT_COPY;
-- 다른 테이블의 데이터를 복사해서 INSERT 하기
INSERT INTO DEPT_COPY
SELECT * FROM DEPARTMENT;
-- DB에 영구 반영
COMMIT;


-- 데이터 수정하기 : UPDATE
SELECT * FROM DEPT_COPY;

-- 일반적인 사용) UPDATE + WHERE 조건절 
-- 문법) 
--      UPDATE 테이블명
--      SET 컬럼명 = 수정할값
--      WHERE 조건
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING'
WHERE DNO = 10;

-- 실행 취소
ROLLBACK; 
-- DB 영구 반영
COMMIT;

-- 문제 1) DEPT_COPY 테이블에 부서명이 'SALES'인 부서만 
--      LOC 컬럼을 'PUSAN' 수정하세요. 
UPDATE DEPT_COPY
SET LOC = 'PUSAN'
WHERE DNAME = 'SALES';

SELECT * FROM DEPT_COPY;

-- 응용문제 2) DEPT_COPY 테이블에 부서번호가 20인 부서만 
--      부서이름을 'JAVA' 수정하고, LOC 컬럼을 'SEOUL'로 수정하세요. 
    UPDATE DEPT_COPY
    SET DNAME = 'JAVA',
        LOC = 'SEOUL'    
    WHERE DNO = 20;
    
    COMMIT;

-- 특이한 예) DEPT_COPY 테이블에서 부서번호가 10인 LOC 데이터를 가져와서
-- 부서번호가 20인 LOC 데이터로 수정하기
UPDATE DEPT_COPY
SET LOC = (SELECT LOC 
            FROM DEPT_COPY 
            WHERE DNO = 20)
WHERE DNO = 10;

COMMIT;

-- DELETE : 테이블의 내용을 삭제하는 DML 명령어
-- 문법 : 
--       DELETE [FROM] 테이블명
--       WHERE 조건
DELETE FROM DEPT_COPY
WHERE DNO = 10;
COMMIT;

-- 문제 2) DEPT_COPY 테이블에서 부서번호(DNO)가 20 또는 30 인 데이터를 삭제하시오.
DELETE FROM DEPT_COPY
WHERE DNO IN (20, 30);

SELECT * FROM DEPT_COPY;
COMMIT;

-- 참고) DELETE ~ 서브쿼리 사용 가능
DELETE FROM DEPT_COPY
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME= 'SALES');