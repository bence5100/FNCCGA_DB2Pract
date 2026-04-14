import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class DbMethods {
    final static String URL = "jdbc:sqlite:C:/sqlite3/Autoszerviz.db";

    public static void Register() {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver nem található: " + e.getMessage());
        }
    }

    public static Connection Connect() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL);
        } catch (SQLException e) {
            System.out.println("Csatlakozási hiba: " + e.getMessage());
        }
        return conn;
    }

    public static void Disconnect(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.println("Zárási hiba: " + e.getMessage());
            }
        }
    }

    // DÁTUM ELLENŐRZÉS - Kötelező elem [cite: 20]
    public static boolean isValidDate(String dateStr) {
        try {
            LocalDate.parse(dateStr); // Elvárt: YYYY-MM-DD
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    // ADATFELVITEL (INSERT) - Paraméterezett [cite: 24, 30]
    public static void insertUgyfel(String nev, String tel, String cim, String regDat) {
        if (!isValidDate(regDat)) {
            System.out.println("Hiba: Rossz dátum formátum (ÉÉÉÉ-HH-NN)!");
            return;
        }
        String sql = "INSERT INTO Ugyfel(nev, telefonszam, lakcim, regisztracio_datuma) VALUES(?,?,?,?)";
        try (Connection conn = Connect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, nev);
            pstmt.setString(2, tel);
            pstmt.setString(3, cim);
            pstmt.setString(4, regDat);
            pstmt.executeUpdate();
            System.out.println("Ügyfél sikeresen rögzítve.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    // ADATMÓDOSÍTÁS (UPDATE) [cite: 25]
    public static void updateUgyfelCim(int id, String ujCim) {
        String sql = "UPDATE Ugyfel SET lakcim = ? WHERE ugyfel_id = ?";
        try (Connection conn = Connect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, ujCim);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
            System.out.println("Lakcím frissítve.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    // ADATTÖRLÉS (DELETE) [cite: 26]
    public static void deleteUgyfel(int id) {
        String sql = "DELETE FROM Ugyfel WHERE ugyfel_id = ?";
        try (Connection conn = Connect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int affected = pstmt.executeUpdate();
            if (affected > 0) System.out.println("Ügyfél törölve.");
            else System.out.println("Nincs ilyen ID.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}