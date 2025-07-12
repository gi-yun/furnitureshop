
# 🪑 IKEA 가구 쇼핑몰 프로젝트

> **Spring MVC + Spring Security + MyBatis 기반 전자상거래 웹 프로젝트**  
> 실제 IKEA 제품 데이터를 기반으로 한 쇼핑몰 기능 구현 프로젝트입니다.  
> 회원가입, 로그인, 상품 조회, 장바구니, 주문 등 기본적인 쇼핑몰 기능을 제공합니다.

---




## 🧑‍💻 프로젝트 개요

| 항목 | 내용 |
|------|------|
| **프로젝트명** | IKEA 가구 쇼핑몰 |
| **기술 스택** | Java 8, Spring MVC, Spring Security, MyBatis, JSP, MySQL |
| **기반 아키텍처** | MVC(Model-View-Controller) |
| **DB** | MySQL (`ikea` 데이터베이스 사용) |
| **뷰 엔진** | JSP (`/WEB-INF/views/*.jsp`) |
| **보안** | Spring Security, BCrypt |
| **PPT** | [PPT 링크](https://docs.google.com/presentation/d/1WRKsUNDwCdiiGVezDsLG_ndrnSKC18dF/edit?usp=sharing&ouid=103340559708893338520&rtpof=true&sd=true) |
| **시연영상**| [시연영상 링크](https://drive.google.com/file/d/1O52XuXiZiDcKpo64gbevTdmtaNxTvamo/view?usp=sharing) |


---

## 홈페이지 시연 사진
<img width="1089" height="679" alt="가구2" src="https://github.com/user-attachments/assets/5f9bc116-4c41-40c9-98f8-45b626a406d2" />
<img width="860" height="547" alt="가구3" src="https://github.com/user-attachments/assets/492e1ef3-0033-49bb-b67b-70ad03b3e958" />
<img width="1021" height="639" alt="가구5" src="https://github.com/user-attachments/assets/cf68db3f-f990-4b68-abd5-3ec53c814778" />
<img width="1066" height="688" alt="가구1" src="https://github.com/user-attachments/assets/b3712d4f-c86d-4a8e-983d-81fb14a9a044" />

---
## 제작자
- 김기윤
- 박민지



## 📚 주요 기능

- ✅ 회원가입 및 로그인 (중복 ID 체크 포함)
- ✅ 마이페이지 조회 (회원 정보 확인)
- ✅ 상품 카테고리별 조회
- ✅ 저가 상품 정렬
- ✅ 상품 상세 페이지
- ✅ 장바구니 담기 및 조회
- ✅ 주문 기능 (배송지 및 수량 입력)
- ✅ 로그인 성공/실패/로그아웃 흐름 처리

---

## ERD
<img width="1194" height="665" alt="가구erd" src="https://github.com/user-attachments/assets/809b9d72-8630-49eb-9aa2-299f0bbddb79" />

---
## 📌 주요 API 명세

### 👤 `MemberController`

| URL | 메서드 | 설명 |
|-----|--------|------|
| `/idCheck` | GET | 아이디 중복 여부 체크 (`사용가능` / `사용불가`) |
| `/signup` | GET | 회원가입 페이지 이동 |
| `/signup` | POST | 회원가입 처리 (BCrypt 암호화) |
| `/mypage` | GET | 로그인한 사용자의 정보 조회 |
| `/cartList` | GET | 로그인한 사용자의 장바구니 목록 |

---

### 🔐 `LoginController`

| URL | 메서드 | 설명 |
|-----|--------|------|
| `/login` | GET | 로그인 페이지 이동 |
| `/login_success` | GET | 로그인 성공 시 메인 페이지로 이동 |
| `/login_fail` | POST | 로그인 실패 시 로그인 페이지로 리다이렉트 |
| `/logout` | GET | 로그아웃 (세션 종료) 후 메인 이동 |

---

### 🛋 `MainController`

| URL | 메서드 | 설명 |
|-----|--------|------|
| `/main` | GET | 카테고리별 상품 목록 (기본 bed) |
| `/lowPrice` | GET | 전체 상품 중 가격 낮은 순 정렬 |
| `/goodsRetrieve` | GET | 특정 상품의 상세 정보 조회 (`gCode` 필요) |

---

## 🗃 데이터베이스 테이블 요약

### 🔹 `member` – 회원

| 필드명 | 설명 |
|--------|------|
| userid | 사용자 ID (PK) |
| passwd | 암호화된 비밀번호 |
| username, addr, phone, email | 개인정보 항목 |

---

### 🔹 `goods` – 상품

| 필드명 | 설명 |
|--------|------|
| gCode | 상품 코드 (PK) |
| gCategory | 카테고리명 (bed, sofa 등) |
| gName, gContent, gPrice, gImage | 상품 상세 정보 |

---

### 🔹 `cart` – 장바구니

- 회원별 장바구니에 담긴 상품 정보 저장
- `userid`와 `gCode`는 각각 `member`, `goods`를 참조

---

### 🔹 `orderinfo` – 주문

- 장바구니에서 선택된 상품을 실제로 주문한 이력 저장
- 배송지, 연락처, 수량 정보 포함

---

## 🧪 기능 요구사항

| 기능 | 설명 |
|------|------|
| 회원가입 | 회원정보 입력 후 가입 가능, 중복 ID 체크 |
| 로그인/로그아웃 | 로그인 후 메인 이동, 로그아웃 시 세션 종료 |
| 상품 조회 | 카테고리별 상품 목록 제공 |
| 장바구니 | 상품 추가/조회 가능 |
| 주문 처리 | 장바구니 기반 주문 입력 가능 |
| 마이페이지 | 내 정보 확인 가능 |
| 저가 상품 정렬 | 전체 상품 중 가격 낮은 순 정렬 |

---

## 🛡 비기능 요구사항

| 항목 | 설명 |
|------|------|
| 인증 보안 | Spring Security + BCrypt 기반 로그인 처리 |
| 무결성 | FK + ON DELETE CASCADE로 참조 무결성 유지 |
| MVC 분리 | Controller-Service-Mapper 구조로 유지보수성 향상 |
| UI | JSP 기반의 직관적 화면 렌더링 |
| 예외처리 | 로그인 실패, 중복 ID, 없는 상품 등 처리 |
| 재사용성 | DTO, 서비스 인터페이스 분리로 재사용 가능 |

---



## 🗂 프로젝트 디렉토리 구조

```
src/main/java/com/exam
├── controller         # 컨트롤러 계층 (웹 요청 처리)
├── service            # 서비스 계층 (비즈니스 로직)
├── dto                # DTO 클래스
├── mapper             # MyBatis Mapper 인터페이스
├── security           # Spring Security 설정
└── Application.java   # 프로젝트 진입점
```

---

## 🔮 향후 개선 계획

- ✅ Java 17 및 Spring Boot 기반으로 리팩토링 예정
- ✅ Thymeleaf 또는 React 기반 UI 전환
- ✅ 관리자 페이지, 결제 연동, 주문 이력 시스템 고도화
- ✅ RESTful API 문서화 및 Swagger 도입 고려

---

> 이 프로젝트는 Java 웹 개발의 전체 흐름과 아키텍처를 학습하고자 하는 개발자를 위한 실습용 프로젝트입니다.
