# 🥕 나의 당근 트레이너

## 목차
1. [프로젝트 소개](#-프로젝트-소개)
2. [주요 기능](#-주요-기능)
3. [개발 환경](#-개발-환경)
4. [서비스 아키텍쳐](#%EF%B8%8F-서비스-아키텍쳐)
5. [배포 설정](#-배포-설정)
6. [Git 전략 및 컨벤션](#-git-전략-및-컨벤션)
7. [역할 분담](#-역할-분담)

## 💪 프로젝트 소개
![나당트](https://github.com/shinhanDSTeamCarrots/CarrotTrainer/assets/19569104/696162e7-4009-4719-8465-fb15dd0db87e)

### 개요
- **서비스명: 나당트**
- **소개: 건강한 라이프스타일 추구, 운동 및 식사 관리를 지원하는 웹 서비스**

## 🤗 주요 기능
### 메인 페이지
https://github.com/shinhanDSTeamCarrots/CarrotTrainer/issues/new
### 로그인

### 게시판

### 건강 기능 시스템

### 쇼핑

### 결제

## 💻 개발 환경
<img width="968" alt="image" src="https://github.com/shinhanDSTeamCarrots/CarrotTrainer/assets/19569104/ded3ba2d-f096-4e63-beee-5e3eba46ca9f">

### 공통
- Trello
- Notion
### 개발 환경
- Java 11
- Spring
- JavaScript
- MySql
- Apache Maven
- Apache Tomcat
- Docker
### 오픈 소스 & 라이브러리
- JQuery
- MyBatis
- Chart.js
- DatePicker

## ⚙️ 서비스 아키텍쳐
<img width="964" alt="image" src="https://github.com/shinhanDSTeamCarrots/CarrotTrainer/assets/19569104/ce461d09-aa9f-4bbf-b4dc-e54bc3fff789">


## 🌟 Git 전략 및 컨벤션
### Git 전략
```
   1. 각자 작업 branches 분리
   2. Main Branch에 통합
   3. Merge 하기 위해서는 이하의 규칙이 필요
      3.1. Merge는 정기 회의 이후 실행
      3.2. 3명 이상의 Code Review후 Approval 승인 후 Merge 가능
      3.3 긴급 수정의 경우 팀장과 협의 후 Merge 실행
   4. Dev-Ops 역할의 분리로, Conflict 시 Merge 작업과 DBMS 재정의 등은 문서화 분리 관리
```
### Git 컨벤션
**태그종류**
| 태그 이름 | 설명 |
| --- | --- |
| Feat | 새로운 기능 추가 |
| Design | CSS, UI 등 디자인 관련 작업 |
| Style | 코드 포맷팅, 세미 콜론 누락 등 |
| Test | 테스트 코드 추가 및 리팩토링 (테스트 이외 코드 변경 X) |
| Fix | 버그 수정 |
| Rename | 파일 혹은 폴더명 수정한 경우 |
| Remove | 파일 삭제하는 작업 수행한 경우 |
| Comment | 주석 추가 및 변경 |
| Refactor | 코드 리팩토링 |
| Docs | 문서 수정한 경우 |

## 🙋‍♀️ 역할 분담
### 이나영(FE,BE)_팀장
- 사용자 맞춤 건강 정보
- 사용자 섭취 음식 기록 기능
- 사용자 운동 내역 기록 기능
- 사용자 신체 및 입력 정보 페이지
- 메인 페이지, 로그인, 사용자 통계 그래프 화면 구현
- 프로젝트 일정 및 기획 총괄
### 이준호(BE)
- 로그인 기능 구현
- 회원가입 기능 구현
### 이기웅(FE,BE)
- 게시판 페이지(건강 뉴스, 공지사항, 자유게시판, 문의게시판)
- 게시글 상세보기 기능
- 게시글 등록, 수정, 삭제 기능
- 관리자 게시글 페이지 구현
- 회원가입 화면 구현
### 장세영(FE,BE)
- 쇼핑몰 페이지
- 상품 상세 페이지
- 장바구니 구현
- 상품 문의 구현
- 메인 페이지 화면 구현
### 전성욱(BE)
- 상품 리뷰 구현
- 결제 구현
- 메인 페이지 기능 구현
- 사용자 통계 그래프 기능 구현
