# 무선 네트워크 공격 프로젝트

이 프로젝트는 무선 네트워크 보안을 테스트하고 평가하기 위한 간단한 스크립트를 제공합니다. 이 스크립트는 주변 무선 네트워크를 스캔하고, 선택한 네트워크를 대상으로 Deauthentication 공격을 실행할 수 있도록 도와줍니다.

## 사용법

### 1. 사용 가능한 무선 네트워크 인터페이스 확인
시스템에서 사용 가능한 무선 인터페이스를 나열하기 위해 스크립트를 실행합니다.

### 2. 무선 네트워크 스캔 및 대상 네트워크 선택
스크립트는 무선 네트워크를 스캔하고 Deauthentication 공격을 위한 대상 네트워크를 선택할 수 있게 합니다.

## 요구 사항

- Linux 운영 체제 (스크립트는 Linux에서만 동작합니다)
- 필요한 라이브러리 및 도구: `iwconfig`, `iwlist`, `airmon-ng`, `aireplay-ng`

## 설치

스크립트는 필요한 도구들(`GNU Parallel`, `airmon-ng`, `aireplay-ng`)을 확인하고 설치를 제안합니다.

## 주의 사항

- 이 스크립트는 보안 테스트 및 학습 목적으로만 사용해야 합니다.
- 다른 사람의 무선 네트워크를 공격하는 것은 불법이며, 사용 권한이 있는 네트워크에서만 테스트해야 합니다.
- 스크립트를 사용할 때 주의하고, 관련 법률 및 규정을 준수하세요.
