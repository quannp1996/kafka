| `type`      | Ý nghĩa ngắn gọn                       | Mức độ tối ưu      | Giải thích                                             |
| ----------- | -------------------------------------- | ------------------ | ------------------------------------------------------ |
| **ALL**     | Full Table Scan                        | ❌ Tệ nhất          | Quét toàn bộ bảng → cực kỳ chậm với bảng lớn           |
| **index**   | Full Index Scan                        | ⚠️ Trung bình      | Quét toàn bộ index (nhanh hơn ALL, nhưng vẫn scan hết) |
| **range**   | Truy theo khoảng                       | ✅ Tốt              | Dùng điều kiện kiểu `BETWEEN`, `>`, `<`, `IN (...)`    |
| **ref**     | Lookup bằng key = const                | ✅ Rất tốt          | Truy theo giá trị cụ thể (`WHERE col = 'abc'`)         |
| **eq\_ref** | Lookup 1:1 bằng khóa chính hoặc unique | ✅✅ Cực nhanh       | Dùng trong JOIN với khóa chính hoặc unique key         |
| **const**   | So sánh hằng số                        | ✅✅ Cực nhanh       | Truy vấn chỉ trả về 1 dòng (VD: `WHERE id = 5`)        |
| **system**  | Bảng 1 dòng duy nhất                   | ✅✅ Nhanh tuyệt đối | Truy bảng hệ thống chỉ có 1 dòng                       |


