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

---

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
| 응답속도 | 모든 조회/처리 기능 1초 내외 응답 목표 |

---

## 🛍 더미 데이터 정보

- `goods` 테이블에 약 **60개 IKEA 제품** 등록됨
- 카테고리 구성:  
  - `bed`, `sofa`, `cabinet`, `chiffonier`, `closet`, `mattress`
- 이미지 링크: 실제 IKEA 웹사이트 이미지 URL 활용
- 등록 파일: [`goods_202406240915.sql`](./goods_202406240915.sql)

---

## 🗂 프로젝트 디렉토리 구조

