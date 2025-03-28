# 🧠 BlockBlast_2024 Architecture

This document describes the architecture and module structure of the BlockBlast_2024 Verilog project.

---

## 📌 System Overview | 시스템 개요

BlockBlast_2024 is a Verilog-based 8x8 block puzzle game. It simulates falling blocks controlled by keyboard input, line detection, score updates, and time-based red zone rising. The game is displayed via VGA and modularized for clean hardware logic.

BlockBlast_2024는 키보드 입력 기반 블록 이동, 줄 감지, 점수 계산, 빨간 영역 상승 등으로 구성된 8x8 퍼즐 게임으로, VGA 출력을 통해 시각화되며 하드웨어 논리를 깔끔하게 모듈화했습니다.

---

## 🧩 Module Breakdown | 모듈 구성

| Module         | Description (EN)                                      | 설명 (KR)                                              |
|----------------|-------------------------------------------------------|---------------------------------------------------------|
| `top.v`        | Top-level integration of all modules                  | 전체 시스템을 통합하는 최상위 모듈                          |
| `block_gen.v`  | Generates random blocks for player to use             | 블록을 무작위로 생성                                     |
| `block_choice.v` | Handles block movement and keyboard input           | 블록 이동 및 방향키 입력 처리                              |
| `block_move.v` | Logic for gravity and final placement of blocks       | 블록의 낙하 및 위치 확정 처리                             |
| `scoretime.v`  | Manages score counting and time progress              | 점수 계산 및 시간 흐름 관리                               |
| `vga_driver.v` | Converts coordinates and color to VGA signals         | 좌표 및 색상을 VGA 신호로 변환                            |
| `Keyboard.v`   | Receives and decodes keyboard scan code               | 키보드 입력 스캔코드 수신 및 디코딩                         |
| `MUX_assemble.v`| Selects and combines MIF data for visual output      | 블록 및 숫자 MIF 데이터를 선택, 조합하여 출력                 |

---

## ⏱️ Game Flow | 게임 동작 흐름

```text
[키보드 입력] → [block_choice] → [block_move] → [게임판 메모리 저장]
                               ↘→ [R키 → block_gen → 새 블록 생성]
[시간 흐름 → 빨간 블록 상승 → 게임 종료 조건 판단]

[게임판 메모리] + [점수/시간 상태] → [MUX → VGA 출력]

---

## 💾 MIF File Structure

- `number0.mif ~ number9.mif`  
  → 점수/시간 숫자 디스플레이용
- `blockX.mif`  
  → 각 블록 모양 (8가지)의 픽셀 정보
- `red.mif`  
  → 시간 종료 시 바닥에서 차오르는 빨간 영역

---

## 💡 Design Considerations | 설계 시 고려사항

- 모든 모듈은 가능한 동기식 구조로 설계
- 블록 메모리는 배열 기반 RAM처럼 구성
- VGA 출력을 위한 픽셀 좌표 변환 및 색상 처리
- 점수는 4자리까지 표현 가능 (한 줄 당 8점 기준)
- 게임 종료는 시간 기반 또는 공간 부족 시 트리거

---

## 🚧 Future Improvements | 향후 개선점

- Ghost block 미리보기
- 블록 보류(Hold) 기능
- 자동 게임 종료(빈 공간 없을 때)
- 점수 저장 기능, 외부 입력 연동 (예: 버튼, 스위치)

---

