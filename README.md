# BlockBlast_2024

A Verilog-based block puzzle game designed for an 8x8 grid. Players control blocks with the keyboard, and try to clear lines to earn the highest score before the red zone rises!

Verilog로 구현된 8x8 블록 퍼즐 게임입니다. 플레이어는 키보드를 이용해 블록을 조작하고, 제한 시간 안에 줄을 제거해 점수를 얻는 것이 목표입니다.

---

## 🎮 Game Overview | 게임 소개

BlockBlast_2024 is a Verilog-based 8x8 block puzzle game. Players control falling blocks using keyboard inputs. There are 8 different block types that can be rotated and moved using arrow keys. Pressing Enter places the block at the desired position. You can reset the block set using the R key. After a set time limit, red blocks begin filling the grid from the bottom, and the game ends when they reach the top.

Block lines are cleared when a row or column is fully filled, which increases the score. The goal is to get the highest score possible before the red zone rises.

**블록블라스트(BlockBlast_2024)**는 Verilog로 구현한 8x8 블록 퍼즐 게임입니다. 방향키로 8종류 블록을 조작하고, **Enter 키**로 블록을 고정시킵니다. **R 키**로 블록 큐를 리셋할 수 있습니다.  
제한 시간이 지나면 아래에서 빨간 블록이 차오르며 게임이 종료됩니다. 줄이 완성되면 자동으로 제거되고 점수가 오릅니다.

---

## 📦 Game Features | 게임 기능 요약

| Feature (EN)                          | 설명 (KR)                                                    |
|--------------------------------------|---------------------------------------------------------------|
| 8x8 Game Grid                        | 8x8 게임판에서 블록을 배치하고 줄을 맞추는 퍼즐 구조                |
| 8 Block Types                        | 8종류의 다양한 블록이 랜덤으로 생성됨                              |
| Keyboard Control (Arrow Keys)       | 방향키를 사용해 블록을 이동하고 회전 가능                           |
| Enter Key to Place                  | Enter 키로 블록을 현재 위치에 고정함                                |
| R Key to Reset Block Queue          | R 키를 눌러 블록 큐를 새로운 블록으로 리셋                           |
| Line Clear (Row & Column)           | 가로 또는 세로 줄이 채워지면 제거되어 점수를 얻음                      |
| Time-based Game Over                | 시간이 지나면 아래부터 빨간 블록이 차오르며 게임 종료                   |
| Block Collision Prevention          | 블록이 겹칠 경우 Enter로 고정되지 않도록 제한함                       |
| Score System (8 points per line)    | 줄 제거 시 8점씩 누적, 점수는 4자리로 표시됨                          |
| VGA Display + Color Control         | VGA 신호로 블록 모양과 색상(RGB)을 화면에 출력                        |
| MIF (Memory Initialization Files)   | 숫자 표시 및 블록 표현에 사용되는 `.mif` 파일                         |
| Row/Column Full Detection           | 메모리 배열로 줄이 채워졌는지 감지 후 자동 제거 처리                   |

📘 See full architecture documentation: [architecture.md](doc/architecture.md)

---

## 🚀 Getting Started | 실행 방법

1. Clone the repository:
   ```bash
   git clone https://github.com/Yooonsung/BlockBlast_2024.git
   cd BlockBlast_2024
   ```

2. Open the project in **Intel Quartus Prime**.

3. Compile the project and load it onto your FPGA board (if available).  
   > Alternatively, simulate each Verilog module separately.

4. Controls:
   - Arrow keys: Move/rotate block
   - `Enter`: Fix block
   - `R`: Reset block queue

> 본 프로젝트는 Quartus Prime 환경에서 개발되었으며, 시뮬레이션 또는 FPGA 보드를 통해 실행 가능합니다.

---

## 📁 Folder Structure | 폴더 구조

```
BlockBlast_2024/
├── mif/               # 블록 및 빨간 영역 MIF 파일
├── numbers/           # 숫자(0~9) 표시용 MIF 파일
├── doc/               # 설계 문서 및 발표 자료
├── *.v                # Verilog 소스코드
├── *.qsf, *.qpf       # Quartus 프로젝트 파일
├── README.md          # 프로젝트 설명 파일
└── architecture.md    # 시스템 아키텍처 상세 설명
```

---

## 📽️ Presentation Slides | 발표 자료

You can view the final presentation slides for BlockBlast_2024 here:  
👉 [Google Slides - BlockBlast_2024.pptx](https://docs.google.com/presentation/d/1kPK7CXwUDxbFqIboGk80agwpP8AwOG1m/edit?usp=drive_link&ouid=111513277059932010620&rtpof=true&sd=true)

> 발표 자료는 Google Slides로 작성되었으며, BlockBlast_2024의 전체 구조와 기능을 시각적으로 설명합니다.

---

## 🛡️ License

This project is released under the MIT License.  
Feel free to use, modify, and distribute with proper attribution.

> 본 프로젝트는 MIT 라이선스 하에 배포되며, 자유롭게 활용이 가능합니다.

---
