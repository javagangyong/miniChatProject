# 💬 miniChat - WebSocket/STOMP 기반 실시간 다중 채팅 서비스

> **여러 채팅방을 동시에 이용할 수 있는 실시간 채팅 웹 애플리케이션입니다.**
> WebSocket·STOMP를 활용한 실시간 메시지 송수신과 함께, 사용자의 실제 채팅창 상태를 기준으로 **안 읽은 메시지 수를 관리하고 DB 및 네트워크 처리량을 줄이는 방식**을 고민하여 구현했습니다.

---

## 🛠 Tech Stack

* **Backend:** Java 11, Spring Framework, MyBatis
* **Database:** Oracle
* **Real-time:** WebSocket, STOMP, SockJS
* **Frontend:** HTML5, CSS3, JavaScript (ES6+), jQuery, Ajax
* **Development:** STS, Maven, Git

---

## 🌟 Key Features

### 1. 실시간 다중 채팅방

* 여러 채팅방을 동시에 열어 사용할 수 있는 동적 채팅 모달 구현
* 채팅방별 STOMP 구독을 통해 독립적인 메시지 송수신
* 채팅방 입장 시 기존 대화 기록 조회
* 채팅방별 참여 정보 관리
* 채팅방 최소화 및 복원 기능
* 채팅방 종료 및 나가기 기능

### 2. 채팅창 상태 관리

채팅창이 화면에 표시되어 있는지 여부를 `isWatching` 상태로 관리했습니다.

* `Y` : 사용자가 현재 채팅창을 보고 있는 상태
* `N` : 채팅창을 최소화하거나 닫은 상태

WebSocket 연결 여부와 실제 사용자의 화면 상태를 분리하여 메시지 읽음 상태를 판단할 수 있도록 설계했습니다.

### 3. 안 읽은 메시지 및 인원 수 관리

메시지 전송 시 현재 채팅방 참여자의 `isWatching` 상태를 확인하여 안 읽은 인원 수를 계산하고 메시지에 `unReadCount`를 저장합니다.

* `isWatching = N`인 참여자 수 → 해당 메시지의 `unReadCount`
* `isWatching = Y`인 참여자 → 현재 메시지 번호를 `lastReadMsgNo`에 반영
* 채팅창 복원 시 읽지 않은 메시지 범위를 계산하여 `unReadCount` 차감
* 채팅방 목록에서도 새로운 메시지 여부를 확인할 수 있도록 구현

---

## 🎬 Demo

### 1. 참여 중인 채팅방

전체 채팅방과 참여 중인 채팅방을 AJAX 비동기 방식으로 전환할 수 있도록 구현했습니다.

![참여 중인 채팅방](docs/gif/chat-room-list.gif)

### 2. 다중 채팅창 및 창 상태 관리

여러 채팅방을 동시에 열 수 있으며, 채팅창의 최소화·복원·닫기 및 채팅방 전환을 구현했습니다.

![다중 채팅창 및 창 상태 관리](docs/gif/multi-chat-window.gif)

### 3. 실시간 메시지 송수신

WebSocket과 STOMP를 활용하여 메시지 전송 시 상대방의 채팅창에 실시간으로 메시지가 전달되도록 구현했습니다.

![실시간 메시지 송수신](docs/gif/send-message.gif)

### 4. 참여 시점에 따른 대화 출력

채팅방 참여 시점에 따라 사용자가 조회할 수 있는 대화 범위를 구분하여, 참여 이후에 생성된 메시지만 조회하도록 구현했습니다.

![참여 시점에 따른 대화 출력](docs/gif/chat-history.gif)

### 5. 안 읽은 메시지 수 실시간 차감

메시지 발송 시 실제 채팅창을 보고 있지 않은 사용자의 수를 기준으로 안 읽은 메시지 수를 관리하고, 사용자가 메시지를 확인할 때마다 읽지 않은 메시지 수가 실시간으로 감소하도록 구현했습니다.

![안 읽은 메시지 수 실시간 차감](docs/gif/unread-count.gif)

---

## 🔥 Key Troubleshooting & Optimization

### 1. WebSocket 연결 상태와 실제 시청 상태 분리

**문제**

처음에는 WebSocket 연결 여부를 기준으로 사용자가 메시지를 읽었는지 판단하려 했습니다.

하지만 채팅창을 최소화하거나 닫더라도 WebSocket 연결과 구독은 유지될 수 있기 때문에, **소켓이 연결되어 있다는 사실만으로 사용자가 실제 메시지를 보고 있는지 판단할 수 없었습니다.**

**해결**

실제 채팅창을 보고 있는지를 나타내는 `isWatching` 상태를 추가했습니다.

```text
채팅창을 보고 있음
      ↓
isWatching = Y

채팅창 최소화 / 닫기
      ↓
isWatching = N
```

메시지가 전송되면 `isWatching = N`인 참여자 수를 계산하여 해당 메시지의 `unReadCount`로 저장하고, `Y`인 참여자는 `lastReadMsgNo`를 현재 메시지 번호로 갱신하도록 처리했습니다.

이를 통해 **WebSocket 연결 상태와 사용자의 실제 시청 상태를 분리하고, 해당 상태를 메시지의 읽음 데이터와 연결**할 수 있었습니다.

---

### 2. 읽음 처리 과정의 데이터 갱신 순서 문제

**문제**

사용자가 최소화된 채팅창을 다시 열었을 때 읽지 않은 메시지 수를 차감하는 과정에서 SQL 오류는 발생하지 않았지만, unReadCount가 정상적으로 차감되지 않는 문제가 발생했습니다.

**원인 분석**

읽음 처리는 다음과 같은 메시지 범위를 기준으로 동작했습니다.

```text
lastReadMsgNo ~ 현재 메시지 번호
```

그런데 `lastReadMsgNo`를 먼저 최신 메시지 번호로 변경한 후 `unReadCount`를 차감하면서, 차감 대상이 되는 메시지 범위 자체가 사라지는 문제가 발생했습니다.

**해결**

데이터 변경 순서를 다음과 같이 수정했습니다.

```text
① 읽지 않은 메시지의 unReadCount 차감
                ↓
② lastReadMsgNo 최신화
```

이를 통해 읽음 처리에 필요한 메시지 범위를 유지하면서 두 데이터가 정상적으로 동기화되도록 개선했습니다.

---

### 3. 메시지별 DB 조회를 범위 연산으로 개선

**문제**

처음에는 메시지마다 `unReadCount`를 DB에서 조회하고 WebSocket을 통해 전달하는 방식을 고려했습니다.

하지만 메시지가 많아질수록 메시지마다 DB 조회와 네트워크 통신이 반복되기 때문에, 사용자와 메시지가 증가할 경우 불필요한 처리량이 증가할 수 있다고 판단했습니다.

**해결**

마지막으로 읽은 메시지 번호와 현재 메시지 번호를 이용해 읽지 않은 메시지의 범위를 계산하도록 변경했습니다.

```text
lastReadMsgNo
      ↓
현재 메시지 번호
      ↓
fromMsgNo ~ toMsgNo
      ↓
해당 범위의 메시지를 일괄 처리
```

`fromMsgNo`와 `toMsgNo`를 DTO에 전달하여 한 번의 요청으로 해당 범위의 메시지에 대한 `unReadCount`를 일괄 차감하도록 개선했습니다.

**핵심 변화**

```text
메시지 단위 처리
        ↓
메시지 범위 단위 처리
```

메시지마다 반복적으로 데이터를 조회하고 전달하는 대신 필요한 범위를 한 번에 처리하도록 변경하여 불필요한 DB 및 네트워크 작업을 줄였습니다.

---

### 4. 채팅방 재입장 시 참여 정보 중복 방지

**문제**

사용자가 동일한 채팅방에 다시 입장할 경우 기존 참여 정보가 중복 저장될 수 있었습니다.

**해결**

Oracle의 `MERGE INTO`를 활용하여 동일한 방과 사용자 조합의 참여 정보가 이미 존재하면 중복 생성하지 않고, 존재하지 않을 때만 참여 정보를 생성하도록 처리했습니다.

또한 DB에 방 번호와 사용자 번호 조합에 대한 `UNIQUE` 제약조건을 적용하여 애플리케이션 로직뿐만 아니라 데이터베이스에서도 중복 데이터를 방지하도록 설계했습니다.

---

## 🔄 Message & Read Status Flow

```text
[메시지 전송]
      │
      ▼
현재 채팅방 참여자 상태 확인
      │
      ├── isWatching = N
      │       ↓
      │   안 읽은 인원 수 계산
      │       ↓
      │   unReadCount 저장
      │
      └── isWatching = Y
              ↓
        lastReadMsgNo 갱신

                ↓

[채팅창 최소화]
        isWatching = N

                ↓

[채팅창 복원]
        isWatching = Y
                │
                ▼
     lastReadMsgNo ~ 현재 msgNo
                │
                ▼
       fromMsgNo ~ toMsgNo
                │
                ▼
       unReadCount 일괄 차감
                │
                ▼
        lastReadMsgNo 갱신
```

---

## 📁 Project Structure

```text
src
├── main
│   ├── java
│   │   └── com.itbank
│   │       ├── controller
│   │       │   └── StompController.java
│   │       ├── service
│   │       │   └── ChatService.java
│   │       ├── dao
│   │       └── model
│   │           ├── ChatMessageDTO.java
│   │           └── ChatRoomJoinDTO.java
│   │
│   ├── resources
│   │   └── mybatis
│   │       └── chat-mapper.xml
│   │
│   └── webapp
│       └── resources
│           └── js
│               └── chatting.js
```

---

## 🗄️ Database

주요 데이터는 다음과 같이 관리했습니다.

### ChatRoom

채팅방의 기본 정보를 관리합니다.

### ChatRoomJoin

채팅방별 사용자의 참여 상태를 관리합니다.

```text
roomNo
userid
isWatching
lastReadMsgNo
joinDate
```

### ChatMessage

채팅 메시지와 읽지 않은 인원 수를 관리합니다.

```text
msgNo
roomNo
senderId
messageContent
unreadCount
sendTime
```

`lastReadMsgNo`를 기준으로 사용자가 마지막으로 읽은 메시지를 기록하고, 이를 현재 메시지 번호와 비교하여 읽지 않은 메시지 범위를 계산할 수 있도록 설계했습니다.

---

## 💡 What I Learned

1. 실시간 채팅 서비스에서는 **WebSocket 연결 상태와 사용자의 실제 화면 상태를 구분하여 관리하는 것이 중요하다**는 것을 경험했습니다.

2. 사용자의 상태를 단순히 화면에서만 관리하는 것이 아니라 `isWatching`, `lastReadMsgNo`, `unReadCount`와 같은 데이터로 연결하여 **서버와 클라이언트의 상태를 일관되게 유지하는 과정**을 경험했습니다.

3. 동일한 기능이라도 메시지마다 처리하는 방식과 메시지 범위를 한 번에 처리하는 방식에 따라 DB와 네트워크의 처리량이 달라질 수 있음을 경험하며, **기능 구현 이후의 처리 효율까지 고려하는 습관**을 갖게 되었습니다.

4. 애플리케이션 로직만으로 데이터를 보호하기보다 `UNIQUE` 제약조건과 같은 DB 레벨의 제약조건을 함께 활용하여 **데이터 무결성을 보장하는 설계의 중요성**을 배웠습니다.
