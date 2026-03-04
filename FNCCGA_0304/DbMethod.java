import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class DbMethod {
    private static final String URL = "jdbc:mysql:C:/sqlite3/autodb";
    
    public static void Register() {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            System.out.println("SQlite JDBC driver nem található: " + e.getMessage());
        }

        String sql="CREATE TABLE IF NOT EXISTS auto (" +
                   "rendszam char PRIMARY KEY," +
                   "tipus char NOT NULL," +
                   "szin char NOT NULL," +
                   "kor INTEGER NOT NULL," +
                   "ar INTEGER NOT NULL," +
                   "tulaj char NOT NULL" +
                   ");";

        try (Connection conn = Connect();
                Statement st = conn.createStatement()) {
                st.execute(sql);
            } catch (SQLException e) {
                System.out.println("Regisztrációs hiba: " + e.getMessage());
            }
    }

    public static Connection Connect() throws SQLException {
        return DriverManager.getConnection(URL);
    }

    public static void ReadAllData(){
        String sql="Select rendszam, tipus, szin, kor, ar, tulaj from auto Order by rendszam;";

        
        try(Connection conn = Connect();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql)) {
            System.out.println("\nRendszám\tTípus\tSzín\tKor\tÁr\tulajdonos");
            System.out.println("---------------------------------------------------");

            while(rs.next()){
                System.out.println(
                    rs.getString("rendszam") + "\t" +
                    rs.getString("tipus") + "\t" +
                    rs.getString("szin") + "\t" +
                    rs.getInt("kor") + "\t" +
                    rs.getInt("ar") + "\t" +
                    rs.getString("tulaj")
                );
                }
        } catch (SQLException e) {
            System.out.println("Adatlekérdezési hiba: " + e.getMessage());
        }
    }

    public static void Insert(String rendszam, String tipus, String szin, int kor, int ar, String tulaj){
        String sql="INSERT INTO auto (rendszam, tipus, szin, kor, ar, tulaj) VALUES (?, ?, ?, ?, ?, ?);";

        try(Connection conn = Connect();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rendszam);
            ps.setString(2, tipus);
            ps.setString(3, szin);
            ps.setInt(4, kor);
            ps.setInt(5, ar);
            ps.setString(6, tulaj);

            int rowsAffected = ps.executeUpdate();
            if(rowsAffected > 0){
                System.out.println("Sikeres beszúrás!");
            } else {
                System.out.println("Beszúrás sikertelen.");
            }
        } catch (SQLException e) {
            System.out.println("Beszúrási hiba: " + e.getMessage());
        }
    }
}
