import java.sql.*;

public class ListingMethods {

    // Egyszerű listázás normál parancssal [cite: 29]
    public static void listAllUgyfel() {
        String sql = "SELECT * FROM Ugyfel";
        try (Connection conn = DbMethods.Connect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("ID\tNév\tTelefon\tCím\tReg.Dátum");
            while (rs.next()) {
                System.out.println(rs.getInt("ugyfel_id") + "\t" +
                        rs.getString("nev") + "\t" +
                        rs.getString("telefonszam") + "\t" +
                        rs.getString("lakcim") + "\t" +
                        rs.getString("regisztracio_datuma"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    // KAPCSOLT TÁBLÁS LEKÉRDEZÉS (JOIN) - Kötelező elem [cite: 13, 25]
    public static void listJarmuWithTulajdonos() {
        String sql = "SELECT J.rendszam, J.tipus, U.nev FROM Jarmu J " +
                     "JOIN Ugyfel U ON J.tulajdonos_id = U.ugyfel_id";
        
        try (Connection conn = DbMethods.Connect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("Rendszám\tTípus\tTulajdonos");
            while (rs.next()) {
                System.out.println(rs.getString("rendszam") + "\t" +
                        rs.getString("tipus") + "\t" +
                        rs.getString("nev"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public static void listTeljesSzervizTortenet() {
    // SQL: Összekapcsoljuk a SzervizNaplót a Járművel, a Járművet pedig az Ügyféllel
    String sql = "SELECT S.leiras, J.tipus, S.munkadij, U.nev " +
                 "FROM SzervizNaplo S " +
                 "JOIN Jarmu J ON S.jarmu_id = J.jarmu_id " +
                 "JOIN Ugyfel U ON J.tulajdonos_id = U.ugyfel_id";

    try (Connection conn = DbMethods.Connect();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {

        System.out.println("\n--- TELJES SZERVIZ TÖRTÉNET ---");
        System.out.printf("%-30s | %-15s | %-10s | %-20s\n", "Munkálat", "Autó típusa", "Összeg", "Tulajdonos");
        System.out.println("---------------------------------------------------------------------------------------");

        while (rs.next()) {
            System.out.printf("%-30s | %-15s | %-10.2f | %-20s\n", 
                rs.getString("leiras"), 
                rs.getString("tipus"), 
                rs.getDouble("munkadij"), 
                rs.getString("nev"));
        }
    } catch (SQLException e) {
        System.out.println("Lekérdezési hiba: " + e.getMessage());
    }
}
}
