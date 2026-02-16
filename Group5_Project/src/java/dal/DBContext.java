package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    private static final String SERVER_NAME = "localhost";
    private static final String DATABASE_NAME = "HotelManagement";
    private static final String USER = "sa";
    private static final String PASSWORD = "123";
    private static final String PORT = "1433";

    public DBContext() {
        try {
            // Nạp driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Chuỗi kết nối
            String url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT + ";"
                    + "databaseName=" + DATABASE_NAME + ";encrypt=false;trustServerCertificate=true;";

            // Tạo kết nối
            connection = DriverManager.getConnection(url, USER, PASSWORD);
            System.out.println("✅ Kết nối database thành công!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Không tìm thấy driver SQLServer: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("❌ Lỗi kết nối database: " + e.getMessage());
        }
    }

    public Connection getConnection() {
        return connection;
    }

    // 🔹 Hàm main để kiểm tra kết nối thủ công
    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.getConnection() != null) {
            System.out.println("🎉 Kết nối tới " + DATABASE_NAME + " thành công!");
        } else {
            System.out.println("⚠️ Kết nối thất bại, vui lòng kiểm tra lại thông tin!");
        }
    }
}
