import java.sql.*;


public class DbMethods {
    final static String URL = "jdbc:sqlite:C:/sqlite3/VBProjektdb";
    
    public static void Register() {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found exception:" + e.getMessage());
        }
 }

    public static Connection Connect() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL);
        } catch (SQLException e) {
            System.out.println( e.getMessage());
        }
        return conn;
    }

    public static void Disconnect(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.println( e.getMessage());
            }
        }
    }

    public static void ReadAllData(){
        int id;
        String vnev;
        String knev;
        String szuli;
        String lakcim;

        String sql = "SELECT ID, vnev, knev, szuli, lakcim FROM hallgato";
        Connection conn = Connect();
        try{
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                id = resultSet.getInt("ID");
                vnev = resultSet.getString("vnev");
                knev = resultSet.getString("knev");
                szuli = resultSet.getString("szuli");
                lakcim = resultSet.getString("lakcim");

                System.out.println(
                    id +"\t"+
                        vnev +"\t"+
                        knev +"\t"+
                        szuli +"\t"+
                        lakcim
                );

                
                
            }
            resultSet.close();
            statement.close();
        }catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            Disconnect(conn);
        }
    }



}
