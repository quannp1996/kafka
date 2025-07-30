| Thành phần              | Mô tả                                     |
| ----------------------- | ----------------------------------------- |
| **Abstraction**         | `ReconciliationJob` – logic xử lý chính   |
| **Implementor**         | `DataSource` – nguồn lấy dữ liệu đối soát |
| **RefinedAbstraction**  | `TransactionReconciliationJob`, v.v.      |
| **ConcreteImplementor** | `BankDataSource`, `PartnerAPI`, ...       |
