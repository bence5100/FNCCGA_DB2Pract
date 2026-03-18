import java.sql.Connection;
import java.sql.ResultSetMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ListingMethods {
    //task_a: rekord számainak kiírása táblából
    public static void task_a(String table_name){
        String sql = "SELECT COUNT(*) AS count FROM " + qIdent(table_name);
        Connection conn = DbMethods.Connect();
        ResultSet resultSet = exeute(conn, sql);
        
        if(resultSet != null){
            try {
                if(resultSet.next()){
                    int count = resultSet.getInt("db");
                    System.out.println(table_name+ "tábla rekordjainak száama: " + count);
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            } 
        }
        DbMethods.Disconnect(conn);
    }
    public static void task_b(String table_name, String column){
        String sql = "SELECT COUNT(DISTINCT " + qIdent(column_name) + ") AS count FROM " + qIdent(table_name);
        Connection conn = DbMethods.Connect();
        ResultSet resultSet = exeute(conn, sql);
        
        if(resultSet != null){
            try {
                if(resultSet.next()){
                    int count = resultSet.getInt("db");
                    System.out.println(table_name+ "tábla "+ column_name+" oszlopának egyedi értékeinek száama: " + count);
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            } 
        }
        DbMethods.Disconnect(conn);
        
    }
}
