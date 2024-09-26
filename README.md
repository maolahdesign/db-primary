# PostgreSQL資料庫管理

## Reference
- [PG SQL](https://pg-sql.com/)
- [Postgres.app](https://postgresapp.com/)
- [DiagramGPT](https://www.eraser.io/diagramgpt?source=post_page-----1b10079b9b5f--------------------------------)

## 資料庫是什麼

### SQL 結構式查詢語言
美國國家標準與技術研究院 （NIST），稱為 SQL、結構化查詢語言(Structured Query Language)或稱之為 Simple Query Language。結構式查詢語言 (SQL) 是一種用於在關聯式資料庫中儲存和處理資訊的程式設計語言。關聯式資料庫以表格形式儲存資訊，列和欄代表不同的資料屬性和資料值之間的各種關係。您可以使用 SQL 陳述式來儲存、更新、移除、搜尋和擷取資料庫中的資訊。您也可以使用 SQL 來維護和優化資料庫效能。

### SQL vs NoSQL

一個 NoSQL 數據庫的特性是**靈活的數據結構**。以 MongoDB 為例，它使用文檔導向的數據模型，允許以 JSON 類似的格式儲存數據。這裡是一個範例：

#### SQL 數據庫結構
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    email VARCHAR(100)
);
```

#### NoSQL（MongoDB）數據結構
```json
{
    "_id": "1",
    "name": "Alice",
    "age": 30,
    "email": "alice@example.com",
    "address": {
        "street": "123 Main St",
        "city": "Wonderland"
    },
    "interests": ["reading", "hiking"]
}
```

在這個例子中，MongoDB 允許每個用戶文檔有不同的字段（如 `address` 和 `interests`），而 SQL 數據庫則要求所有記錄遵循相同的結構。這樣的靈活性使得 NoSQL 更適合處理變化頻繁或多樣化的數據。

建立一個內容管理系統（CMS）的資料結構可以包含多個集合，以滿足不同的需求。以下是一個基於 MongoDB 的簡單 CMS 資料結構範例：

#### 1. 使用者集合（users）

```json
{
    "_id": "ObjectId",
    "username": "admin",
    "password": "hashed_password",
    "email": "admin@example.com",
    "role": "admin", // 角色：admin, editor, viewer
    "created_at": "ISODate",
    "updated_at": "ISODate"
}
```

#### 2. 文章集合（posts）

```json
{
    "_id": "ObjectId",
    "title": "文章標題",
    "content": "文章內容",
    "author_id": "ObjectId", // 參考 users 集合的 _id
    "tags": ["tag1", "tag2"],
    "created_at": "ISODate",
    "updated_at": "ISODate",
    "published": true, // 是否已發佈
    "comments": [
        {
            "comment_id": "ObjectId",
            "author": "commenter_name",
            "content": "評論內容",
            "created_at": "ISODate"
        }
    ]
}
```

#### 3. 分類集合（categories）

```json
{
    "_id": "ObjectId",
    "name": "分類名稱",
    "description": "分類描述",
    "created_at": "ISODate",
    "updated_at": "ISODate"
}
```

#### 4. 標籤集合（tags）

```json
{
    "_id": "ObjectId",
    "name": "標籤名稱",
    "created_at": "ISODate",
    "updated_at": "ISODate"
}
```

#### 5. 訪問日誌集合（logs）

```json
{
    "_id": "ObjectId",
    "user_id": "ObjectId", // 參考 users 集合的 _id
    "action": "create_post", // 操作類型
    "timestamp": "ISODate",
    "details": {
        "post_id": "ObjectId", // 可選，對應的文章 ID
        "changes": "更改內容"
    }
}
```

#### 說明

- **使用者集合**：儲存使用者資訊，包括角色，以控制訪問權限。
- **文章集合**：包含文章的主要內容，並能夠關聯到作者、標籤和評論。
- **分類集合**：用於將文章組織到不同的類別中。
- **標籤集合**：用於為文章添加標籤，以便更好地分類和搜尋。
- **訪問日誌集合**：記錄用戶的操作，以便進行審計和追蹤。

這個資料結構能夠為一個基本的 CMS 提供支持，可以根據具體需求進一步擴展和調整。

---
## 為什麼選擇 PostgresSQL

- not MySQL(Oracle)

**PostgreSQL vs MySQL**

| 類別 | MySQL | PostgreSQL |
| --- | --- | --- |
| 資料庫技術 | MySQL 是一個純粹的關聯式資料庫管理系統。 | PostgreSQL 是一個物件型關聯式資料庫管理系統。 |
| 功能 | MySQL 對資料庫功能 (例如檢視、觸發程序和程序) 的支援有限。 | PostgreSQL 支援各項最進階的資料庫功能，例如具體化視觀表、*INSTEAD OF* 觸發程序，以及多種語言的預存程序。 |
| 資料類型 | MySQL 支援數字、字元、日期與時間、空間和 JSON 資料類型。 | PostgreSQL 支援所有 MySQL 資料類型，以及幾何、枚舉、網路地址、陣列、範圍、XML、hstore 和複合。 |
| ACID 合規 | MySQL 僅在 InnoDB 和 NDB 叢集存儲引擎方面符合 ACID。 | PostgreSQL 始終符合 ACID。 |
| 索引 | MySQL 具有 B 型樹狀結構和 R 型樹狀結構索引支援。 | PostgreSQL 支援多種索引類型，如表達式索引、部分索引和雜湊索引以及樹狀結構。 |
| 效能 | MySQL 改善了高頻讀取操作的效能。 | PostgreSQL 改善了高頻寫入操作的效能。 |
| 初學者支援 | 開始使用 MySQL 更容易。它為非技術使用者提供了更廣泛的工具集。 | 開始使用 PostgreSQL 更複雜。它為非技術使用者提供了有限的工具集。 |

PostgreSQL 的 ACID 是指數據庫的四個基本特性，用於保證交易的可靠性和一致性。ACID 代表以下四個特性：

1. **原子性 (Atomicity)**：交易要麼完全執行，要麼完全不執行。如果交易中的任何一步失敗，所有已執行的步驟都將被還原，確保數據庫不會處於不一致狀態。

2. **一致性 (Consistency)**：交易必須使數據庫從一個一致的狀態轉變到另一個一致的狀態。在交易開始和結束時，數據庫必須遵循所有的約束條件和規則。

3. **隔離性 (Isolation)**：每個交易的執行不應受到其他交易的干擾。即使多個交易同時執行，它們的結果也應當與逐個執行的結果相同。這是通過不同的隔離級別來實現的。

4. **持久性 (Durability)**：一旦交易被確認，其結果將永久保存，即使系統崩潰或發生其他故障，數據也不會丟失。

這些特性確保了 PostgreSQL 在處理數據時的可靠性和穩定性，使其成為一個強大的數據庫管理系統。

## PostgreSQL架構介紹

PostgreSQL 是一個開源的關聯式資料庫管理系統（RDBMS），它支援 SQL 語法並具備豐富的功能，如事務、並發處理、擴展性以及對 NoSQL 功能的支持（如 JSONB、HStore）。PostgreSQL 的架構是模組化的，提供了靈活性和高效的資源管理，適合各種應用場景。

下面是 PostgreSQL 的主要架構組件介紹：

### 1. **PostgreSQL 整體架構概覽**

PostgreSQL 架構主要分為兩部分：
- **後端（Backend）**：負責資料庫內部邏輯，包括查詢處理、記憶體管理、日誌管理、存儲引擎等。
- **前端（Frontend）**：用戶通過 SQL 語句與資料庫交互，這些語句會經過前端處理，傳遞到後端進行執行。

架構中的主要組件包括：

- **客戶端-伺服器模型**：PostgreSQL 運行在伺服器端，客戶端通過網絡連接來訪問數據庫。
- **共享記憶體（Shared Memory）**：伺服器上的進程共享記憶體區，用來存儲快取和進程之間共享的信息。
- **WAL 機制（Write-Ahead Logging）**：確保資料的一致性和故障恢復。

### 2. **PostgreSQL 架構的核心組件**

#### （1）**Postmaster（伺服器進程）**
Postmaster 是 PostgreSQL 的主進程，負責管理所有其他子進程。當客戶端連接到伺服器時，Postmaster 會為每個客戶端分配一個子進程。

主要功能：
- 負責處理客戶端連接。
- 啟動和停止伺服器。
- 啟動後端進程來執行查詢。

#### （2）**客戶端與伺服器的通訊**
PostgreSQL 使用客戶端-伺服器模型，客戶端通過網絡（TCP/IP 或本地 socket）與資料庫伺服器進行交互。

1. **客戶端**：可以是任何使用 SQL 語句的應用程式或工具（如 `psql` 命令行工具）。
2. **伺服器**：當收到客戶端的 SQL 請求時，伺服器會處理請求，然後將結果返回給客戶端。

#### （3）**Process Model（進程模型）**
PostgreSQL 使用多進程架構，而不是多執行緒架構。每個客戶端連接對應一個伺服器進程。

- **Postmaster 進程**：主要負責監控和管理其他進程。
- **客戶端進程**：每個客戶端連接都會啟動一個子進程來處理查詢。
- **Background Worker 進程**：例如，自動分析、清理、日誌歸檔等操作都有專門的後台進程來執行。

#### （4）**Memory Structure（記憶體結構）**
PostgreSQL 使用兩種類型的記憶體：**共享記憶體（Shared Memory）** 和 **私有記憶體（Private Memory）**。

- **共享記憶體（Shared Memory）**：所有後端進程共享這塊記憶體區，主要存儲快取、WAL 緩衝區和鎖資訊。
  - **Shared Buffer**：這是用來快取資料塊的內存區，避免頻繁的磁碟讀寫操作。
  - **WAL Buffer**：用來快取 WAL 日誌以提高寫入效率。
  - **Lock Table**：用來管理資料庫鎖資訊，協調多進程之間的並發操作。

- **私有記憶體（Private Memory）**：每個後端進程都有自己的私有記憶體，負責處理該進程的臨時數據。
  - **Sort Memory**：用來儲存排序操作的中間結果。
  - **Work Memory**：每個查詢運行時需要分配的工作記憶體。

#### （5）**WAL 機制（Write-Ahead Logging）**
PostgreSQL 使用 WAL 機制來保證數據的一致性和故障恢復。當系統發生故障時，WAL 可以用來恢復資料庫到最近的穩定狀態。

- **WAL 日誌**：WAL 機制會先將即將進行的修改寫入到 WAL 日誌中，只有日誌成功寫入後，資料才會寫入磁碟，這樣可以確保在系統故障時能夠重建數據。
- **檔案恢復**：使用 WAL 來進行故障恢復，將數據恢復到發生故障前的狀態。

#### （6）**查詢處理（Query Processing）**
查詢處理是 PostgreSQL 的核心功能之一。查詢的處理過程如下：

1. **解析（Parsing）**：SQL 查詢會被解析成查詢樹（Parse Tree），檢查語法正確性。
2. **重寫（Rewrite）**：查詢樹可能會根據規則進行重寫，以適應查詢邏輯的優化。
3. **規劃與優化（Planning and Optimization）**：重寫後的查詢樹會被優化，生成執行計劃（Execution Plan）。
4. **執行（Execution）**：優化過的計劃被執行，數據會從資料庫中讀取或修改。

#### （7）**存儲引擎（Storage Engine）**
PostgreSQL 的存儲層負責管理磁碟上的資料存取。所有資料都以頁（page）為單位進行讀寫，每個頁面默認大小為 8 KB。

- **表（Tables）** 和 **索引（Indexes）** 都存儲在檔案系統的資料塊中。
- **MVCC（多版本並發控制）**：PostgreSQL 使用 MVCC 來支援並發操作，這樣每個事務都可以看到一個資料的快照，並發讀寫不會互相阻塞。

#### （8）**事務處理（Transaction Processing）**
PostgreSQL 支援 **ACID（Atomicity, Consistency, Isolation, Durability）**，這保證了資料的一致性和可靠性。

- **事務隔離級別**：PostgreSQL 支援多種事務隔離級別，包括 Read Uncommitted、Read Committed、Repeatable Read 和 Serializable。
- **樂觀鎖與悲觀鎖**：PostgreSQL 提供了樂觀鎖和悲觀鎖的機制來控制資料並發讀寫。

---

### 3. **架構優點**
- **擴展性**：PostgreSQL 支援擴展，可以添加新的資料類型、函數、操作符等。
- **彈性**：除了關聯式資料模型外，PostgreSQL 還支援 JSONB、HStore 等半結構化數據存儲。
- **可靠性**：WAL 機制和 MVCC 保證了數據的一致性、容錯能力和高效並發操作。
- **豐富功能**：支援視圖、觸發器、外鍵、全文本搜索等高級功能。

### 4. 常用的名詞中英對照表：

| 英文名詞             | 中文對照       |
| -------------------- | -------------- |
| Database             | 資料庫         |
| Table                | 資料表         |
| Column               | 欄位           |
| Row                  | 資料列/記錄    |
| Schema               | 結構           |
| Query                | 查詢           |
| Index                | 索引           |
| Primary Key          | 主鍵           |
| Foreign Key          | 外鍵           |
| Constraint           | 約束           |
| Sequence             | 序列           |
| View                 | 檢視表         |
| Transaction          | 交易           |
| Commit               | 提交           |
| Rollback             | 回滾           |
| Backup               | 備份           |
| Restore              | 還原           |
| Trigger              | 觸發器         |
| Function             | 函數           |
| Procedure            | 程式           |
| Role                 | 角色           |
| Privilege            | 權限           |
| Grant                | 賦予           |
| Revoke               | 撤銷           |
| Join                 | 連接           |
| Inner Join           | 內部連接       |
| Outer Join           | 外部連接       |
| Left Join            | 左連接         |
| Right Join           | 右連接         |
| Full Join            | 全連接         |
| Subquery             | 子查詢         |
| Aggregate Function   | 聚合函數       |
| Foreign Data Wrapper | 外部資料包裝器 |
| Extension            | 擴充套件       |
| Operator             | 運算符         |
| Data Type            | 資料型別       |
| NULL                 | 空值           |

### 總結
PostgreSQL 是一個功能強大且靈活的資料庫系統，其架構設計基於多進程模型、共享記憶體、WAL 機制和查詢優化器，提供了高效的並發控制、數據一致性和可擴展性。這使它成為各類應用場景下穩定可靠的選擇。

---

## 安裝 PostgreSQL 

## 我的第一個資料庫


### 試過了？其實還有很多事沒做
**在完成資料庫設計模型之前，有幾個重要的準備工作需要事先完成**，以確保資料庫設計符合需求並具備可擴展性和效能。這些前置步驟有助於理解業務需求、資料流程及資料庫的結構。以下是    設計資料庫模型之前應該完成的工作：

#### 1. **需求分析 (Requirements Analysis)**
   - 了解業務需求，確認系統要解決的問題以及需要儲存的資料類型和範圍。這包括與相關利益相關者（如客戶、開發人員、業務分析師）進行討論，以明確他們的需求。
   - 定義業務規則，理解如何在資料庫中反映這些規則。這些規則可能影響資料的關聯性、完整性和一致性。

#### 2. **資料需求定義 (Data Requirements Definition)**
   - 定義將要儲存在資料庫中的主要資料類型和資料實體（例如，客戶、訂單、產品等）。
   - 確定每個實體的屬性（例如，客戶的姓名、聯絡方式等），並確保這些屬性符合業務需求。

#### 3. **資料流程分析 (Data Flow Analysis)**
   - 分析資料在系統內外的流動方式，識別資料的來源、目的和處理過程。這有助於設計資料輸入和輸出的結構。
   - 確認資料從哪裡來（如外部系統、使用者輸入）、將傳遞到哪裡（如報表、系統其他模組），以及如何處理和儲存這些資料。

#### 4. **實體-關係圖 (Entity-Relationship Diagram, ERD)**
   - 繪製 ERD 圖表，這是一個圖形化的工具，用於表示資料實體和它們之間的關聯。實體-關係圖有助於可視化資料結構，確保每個資料實體及其之間的關聯都清楚定義。
   - 在設計 ERD 時，還需要考慮每個實體的主鍵和外鍵，確保它們之間的關係正確反映在圖中。

#### 5. **資料正規化 (Normalization)**
   - 對資料結構進行正規化，將資料分解為多個表格，以減少資料冗餘並確保資料的一致性。常見的正規化過程包括將資料調整到一階正規化 (1NF)、二階正規化 (2NF) 和三階正規化 (3NF)。
   - 這一過程幫助確保每個表格只存放單一實體的屬性，並且沒有重複資料或冗餘。

#### 6. **資料庫效能需求 ( Performance Requirements)**
   - 了解效能要求，如查詢速度、寫入頻率、並發性（多使用者同時存取）等。這將決定資料庫需要如何進行索引、分區或使用其他效能優化技術。
   - 如果系統預期有大量資料讀取或寫入，需提前考慮索引設計、資料分區策略，以及可能的負載平衡解決方案。

#### 7. **資料安全與合規性要求 (Security and Compliance Requirements)**
   - 了解資料的安全性需求，確定哪些資料是敏感的，並規劃相應的加密、存取控制和使用者權限管理。
   - 確認資料庫設計符合當地或國際的數據保護法規（如 GDPR 或 CCPA），確保使用者隱私得到保障，並設計適當的備份和災難恢復策略。

#### 8. **資料庫技術選型 (Technology Selection)**
   - 根據資料性質和系統需求選擇合適的資料庫管理系統（如 MySQL、PostgreSQL、SQL Server、MongoDB 等）。
   - 對於一些應用場景，可能需要選擇關聯式資料庫，而對於一些非結構化資料的需求，則可能選擇 NoSQL 資料庫。

#### 9. **容量與擴展性規劃 (Capacity and Scalability Planning)**
   - 預測資料庫的容量需求（如未來的資料增長量）以及系統的擴展能力。這包括儲存容量的規劃以及資料庫在未來是否能夠有效擴展。
   - 確認資料庫是否需要支持分布式架構，以應對大量並行請求或海量數據。

#### 10. **資料遷移與整合 (Data Migration and Integration)**
   - 如果現有系統有資料需要遷移到新資料庫，則必須詳細規劃資料遷移過程，確保資料的一致性和完整性。
   - 如果新資料庫需要與其他系統進行整合，也需要規劃好資料交換的方式和格式。

#### 總結
資料庫設計是一個複雜的過程，前期準備工作至關重要。從需求分析到資料正規化，再到技術選型和效能、安全考量，這些步驟確保資料庫設計不僅滿足業務需求，還具備良好的擴展性和效能。

---
## 資料型別
PostgreSQL 支援豐富的資料型別，涵蓋數字、文字、日期時間、二進制等。以下是常見的資料型別分類及示例：

### 1. **數字型別**
   - **整數類型**
     - `smallint`: 小範圍的整數，範圍 -32,768 到 32,767（2 bytes）。
     - `integer` 或 `int`: 標準範圍的整數，範圍 -2,147,483,648 到 2,147,483,647（4 bytes）。
     - `bigint`: 大範圍的整數，範圍 -9,223,372,036,854,775,808 到 9,223,372,036,854,775,807（8 bytes）。
   
   - **浮點數類型**
     - `real`: 單精度浮點數（4 bytes）。
     - `double precision`: 雙精度浮點數（8 bytes）。
   
   - **精確數字型別**
     - `numeric(p, s)` 或 `decimal(p, s)`: 精確的數字，`p` 為總位數，`s` 為小數位數。適合金融運算。

   - **序列和自動遞增型別**
     - `serial`: 自動遞增整數，等同於 `integer` 加上自動生成的序列。
     - `bigserial`: 自動遞增的大整數，等同於 `bigint` 加上自動生成的序列。

### 2. **字串型別**
   - **可變長度字串**
     - `varchar(n)`: 可變長度字串，最多 `n` 個字元。
     - `text`: 不限制長度的字串，通常用於儲存較長的文字。

   - **固定長度字串**
     - `char(n)`: 固定長度字串，不足部分會自動填充空格。

### 3. **布林型別**
   - `boolean`: 布林型別，取值為 `TRUE`, `FALSE`, 或 `NULL`。

### 4. **日期與時間型別**
   - `date`: 只包含日期（年、月、日），格式為 `YYYY-MM-DD`。
   - `time`: 只包含時間（時、分、秒），格式為 `HH:MI:SS`。
   - `timestamp`: 包含日期和時間，無時區信息，格式為 `YYYY-MM-DD HH:MI:SS`。
   - `timestamptz`: 包含日期和時間，有時區信息。
   - `interval`: 時間間隔，表示時間段（例如，1 天或 2 小時）。

### 5. **二進制資料型別**
   - `bytea`: 用於存儲二進制資料，例如圖像或文件的數據。

### 6. **列舉型別**
   - `enum`: 列舉型別，用於定義一組可能的值。例如：

     ```sql
     CREATE TYPE mood AS ENUM ('happy', 'sad', 'neutral');
     ```

### 7. **JSON 與 XML 型別**
   - `json`: 存儲 JSON 格式的數據，但沒有強制檢查格式正確性。
   - `jsonb`: 二進制 JSON，存儲結構化的 JSON，支援更高效的查詢和索引。
   - `xml`: 用於存儲 XML 資料。

### 8. **陣列型別**
   - PostgreSQL 支援陣列類型，任何資料型別都可以存儲為陣列。例如：

     ```sql
     integer[]  -- 整數陣列
     text[]     -- 字串陣列
     ```

   - 陣列可以包含多維結構，例如 `integer[3][3]` 表示三維矩陣。

### 9. **UUID 型別**
   - `uuid`: 通用唯一識別碼，用於儲存 128 位的 UUID 資料。

### 10. **CIDR 和 INET 型別**
   - `cidr`: 用於存儲 IP 網段。
   - `inet`: 用於存儲 IP 位址（IPv4 或 IPv6）。

### 11. **點與幾何型別**
   - `point`: 二維平面上的一個點，格式為 `(x, y)`。
   - `line`: 無限直線。
   - `lseg`: 線段。
   - `box`: 矩形。
   - `path`: 路徑。
   - `polygon`: 多邊形。
   - `circle`: 圓形。

### 12. **範圍型別**
   - `int4range`: 32 位整數範圍。
   - `int8range`: 64 位整數範圍。
   - `numrange`: 數字範圍。
   - `tsrange`: 無時區的時間範圍。
   - `tstzrange`: 有時區的時間範圍。
   - `daterange`: 日期範圍。

### 13. **金錢型別**
   - `money`: 用於存儲貨幣金額，包含小數位。

## PostgreSQL 資料型別說明

| 資料型別             | 描述           | 長度限制                                    | 預設值  | 說明                                                        |
| -------------------- | -------------- | ------------------------------------------- | ------- | ----------------------------------------------------------- |
| **Integer**          | 整數           | 無限制                                      | 0       | 整數值，包含正數、負數和零。                                |
| **Smallint**         | 小整數         | -32768 到 32767                             | 0       | 小整數，占用較少空間。                                      |
| **BigInt**           | 大整數         | -9223372036854775808 到 9223372036854775807 | 0       | 大整數，占用較多空間。                                      |
| **Serial**           | 自動遞增整數   | 無限制                                      | 1       | 自動遞增整數，常用於自增 ID。                               |
| **Float**            | 單精度浮點數   | 無限制                                      | 0.0     | 浮點數，精度較低。                                          |
| **Double Precision** | 雙精度浮點數   | 無限制                                      | 0.0     | 浮點數，精度較高。                                          |
| **Real**             | 單精度浮點數   | 無限制                                      | 0.0     | 浮點數，精度較低。                                          |
| **Decimal**          | 定點數         | 可定義                                      | 0       | 精確的浮點數，可定義小數位數。                              |
| **Character**        | 字符串         | 1 到 1000                                   | 空字串  | 字符串，長度限制可定義。                                    |
| **Varchar**          | 可變長度字符串 | 1 到 65535                                  | 空字串  | 字符串，長度可變。                                          |
| **Text**             | 長字符串       | 無限制                                      | 空字串  | 長字符串，長度可變。                                        |
| **Boolean**          | 布林值         | 無限制                                      | false   | 布林值，只能為 true 或 false。                              |
| **Date**             | 日期           | 無限制                                      | 無      | 日期格式，例如 2023-10-26。                                 |
| **Time**             | 時間           | 無限制                                      | 無      | 時間格式，例如 14:30:00。                                   |
| **Timestamp**        | 時間戳         | 無限制                                      | 無      | 日期和時間格式，例如 2023-10-26 14:30:00。                  |
| **Interval**         | 時間間隔       | 無限制                                      | 無      | 時間間隔，例如 1 天或 2 小時。                              |
| **Array**            | 陣列           | 無限制                                      | 空陣列  | 陣列，可包含任何資料型別。                                  |
| **JSON**             | JSON 資料      | 無限制                                      | 空 JSON | JSON 格式的資料。                                           |
| **UUID**             | 通用唯一識別碼 | 無限制                                      | 無      | 通用唯一識別碼，例如 a1b2c3d4-e5f6-7890-1234-567890abcdef。 |

**備註:**

* 某些資料型別可能需要額外的設定，例如 `Decimal` 的精度和尺度。
* 上述表格僅列出常見的資料型別，PostgreSQL 提供更多其他資料型別。
* 更多詳細資訊，請參考 PostgreSQL 官方文件: [postgresql.org](https://www.postgresql.org/docs/)

---

這些是 PostgreSQL 中常見的資料型別，提供了靈活的數據處理和儲存選擇。你可以根據具體應用的需求選擇最合適的型別來構建資料表。

## 定義資料結構
在關連式資料庫中，原始資料儲存在表格之中，所以在這一章裡，主要說明表格如何建立及調整，以及有什麼樣的功能可以操控所存放的資料。


---
## 建立與管理資料庫

在設計一個教學網站的資料庫時，我們可以使用**PostgreSQL**，並遵循資料庫的**1NF（一階正規化）**、**2NF（二階正規化）** 和 **3NF（三階正規化）** 的規則來設計和優化資料表。以下是每個正規化階段的範例演進。

### 範例背景：
假設我們設計一個教學網站，系統要記錄課程資訊、學生資訊以及學生的課程註冊情況。

### 1. **一階正規化（1NF）**
**1NF** 要求表格中的每個欄位都只包含**不可分割的值**（即表格是平坦的，每個儲存格只包含一個值），而且每一列應該是唯一的。

#### 原始資料表（未正規化）：
我們將所有課程、學生和註冊資訊放在一個表中，這會導致數據重複和結構不佳。

```plaintext
| StudentID | StudentName | CourseID | CourseName          | Instructor  | EnrollmentDate        |
|-----------|-------------|----------|---------------------|-------------|-----------------------|
| 1         | John Smith  | 101      | Web Development      | Jane Doe    | 2023-01-01            |
| 1         | John Smith  | 102      | Database Systems     | John Carter | 2023-01-02            |
| 2         | Alice Brown | 101      | Web Development      | Jane Doe    | 2023-01-05            |
```

在此表中：
- 學生和課程的資訊重複。
- 學生選擇多個課程時，學生名字會被重複列出。

#### 一階正規化（1NF）：
確保每一列的數據是原子性的，不包含多值欄位。

```sql
CREATE TABLE Enrollments (
    StudentID INT,
    StudentName VARCHAR(100),
    CourseID INT,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100),
    EnrollmentDate DATE,
    PRIMARY KEY (StudentID, CourseID)
);
```

這樣就滿足了**1NF**，但仍然有很多數據冗餘（例如 `StudentName` 和 `CourseName` 重複）。

---

### 2. **二階正規化（2NF）**
**2NF** 要求資料表滿足**1NF**，並且每個非主鍵屬性都完全依賴於**主鍵的全部**，不能僅依賴於部分主鍵。

在上面的 `Enrollments` 表中，`StudentName` 只依賴於 `StudentID`，而 `CourseName` 和 `Instructor` 只依賴於 `CourseID`，這些都是部分依賴。

#### 二階正規化（2NF）：
我們將資料分拆成兩個表：一個是關於學生的表，另一個是關於課程的表，然後使用第三個表來表示註冊關係。

1. **Students 表**
```sql
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);
```

2. **Courses 表**
```sql
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100)
);
```

3. **Enrollments 表**
```sql
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
```

這樣，我們把非主鍵屬性與主鍵的依賴關係完全分開，避免了重複數據的存儲，滿足了**2NF**。

---

### 3. **三階正規化（3NF）**
**3NF** 要求資料表滿足**2NF**，並且**非主鍵屬性不能依賴於其他非主鍵屬性**（即消除傳遞依賴）。

在 `Courses` 表中，假設未來課程的講師 (`Instructor`) 可能會有更多信息（例如 Email 或 Office 地址），這可能會造成傳遞依賴。如果 `Instructor` 的資訊不僅依賴於 `CourseID`，而是依賴於 `Instructor` 自身，我們需要將講師的信息單獨提取到一個新表中。

#### 三階正規化（3NF）：
我們再將講師資訊拆分出來，這樣就不會有傳遞依賴。

1. **Instructors 表**
```sql
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100),
    Email VARCHAR(100),
    Office VARCHAR(100)
);
```

2. **Courses 表（更新後）**
```sql
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);
```

3. **Students 表**
保持不變。

4. **Enrollments 表**
保持不變。

---

### 最終結構：
經過 1NF、2NF 和 3NF 的正規化後，資料表變得更加結構化和優化：

1. **Students 表**：
   - 存儲學生的基本信息。
   
2. **Courses 表**：
   - 存儲課程信息和負責講師的 `InstructorID`。

3. **Instructors 表**：
   - 存儲講師的詳細信息。

4. **Enrollments 表**：
   - 表示學生與課程的註冊關係。

### 最終 SQL 查詢範例：
假設我們想查詢每個學生註冊的課程及其講師的詳細信息：

```sql
SELECT s.StudentName, c.CourseName, i.InstructorName, i.Email, e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Instructors i ON c.InstructorID = i.InstructorID;
```

這樣的正規化結構：
- 消除了數據冗餘。
- 提高了數據完整性。
- 容易進行數據更新和維護，避免數據異常情況（如不同記錄中相同學生的名字拼寫不同）。
## 命令列管理工具
CREATE USER username WITH PASSWORD 'password';
CREATE DATABASE dbname WITH OWNER 'username';

commend
- \d+ users 檢視資料表 schema
- psql 檢視資料表 users

```
DROP TABLE users;

CREATE TABLE users(
    id SERIAL,
    name VARCHAR(128),
    email VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
)
```
## 使用 PostgreSQL 線上教學網站會員管理及課程管理資料表規劃


## 圖形化管理工具
## 安全性
## SQL語言簡介
- get last insert row or id.
## 備份、復原與特定點復原
## 日常的管理工作
## 資料字典
## 載入與搬移資料

