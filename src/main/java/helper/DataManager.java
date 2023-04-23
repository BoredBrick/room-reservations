package helper;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataManager {
    public static Connection getConnection() throws NamingException, SQLException {
        DataSource src;
        Context context;

        context = new InitialContext();
        Context env = (Context) context.lookup("java:/comp/env");
        src = (DataSource) env.lookup("mvcpool");
        return src.getConnection();
    }
}
