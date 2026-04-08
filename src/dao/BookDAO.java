package dao;

import model.Book;
import java.sql.*;
import java.util.*;

public class BookDAO {

    public static void addBook(Book b) throws Exception {
        Connection con = DBConnection.getConnection();

        if (con == null) {
            System.out.println("DB CONNECTION FAILED");
            return;
        }

        System.out.println("✅ DB CONNECTED");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO book (book_id, title, available_copies, author_id, category_id) VALUES (?, ?, ?, ?, ?)"
        );

        ps.setInt(1, b.getId());
        ps.setString(2, b.getTitle());
        ps.setInt(3, b.getAvailableCopies());
        ps.setInt(4, b.getAuthorId());
        ps.setInt(5, b.getCategoryId());

        int rows = ps.executeUpdate();

        System.out.println("Rows inserted: " + rows);
    }

    public static List<Book> getAllBooks() throws Exception {
        List<Book> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT * FROM book");

        while (rs.next()) {
            Book b = new Book();

            b.setId(rs.getInt("book_id"));
            b.setTitle(rs.getString("title"));
            b.setAvailableCopies(rs.getInt("available_copies"));
            b.setAuthorId(rs.getInt("author_id"));
            b.setCategoryId(rs.getInt("category_id"));

            list.add(b);
        }

        return list;
    }
}