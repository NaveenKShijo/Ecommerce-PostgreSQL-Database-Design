
# 📚 Ecommerce Bookstore Database (PostgreSQL)

This can be used as a guide for anyone who wants to start practicing database design in PostgreSQL. 

A relational database system designed for an **ecommerce platform selling books**.  
Built using **PostgreSQL**, following best practices in **database normalization, transactional consistency, and trigger-based automation**.

---

## 🚀 Features

- Structured database design following **real-world ecommerce flows**
- Support for **multiple authors, categories, cart functionality, orders, payments, shipping**
- **Automatic stock adjustment & order total update via triggers**
- Includes **sample data**, **analytics queries**, and **stored program logic** (functions, triggers)

---

## 🛠️ Tech Stack

| Component | Technology |
|----------|------------|
| Database | PostgreSQL |
| Admin Tool | pgAdmin 4 |
| Language | SQL, PL/pgSQL |
| ORM Support | Compatible with any ORM (e.g., SQLAlchemy, Django ORM) |
| OS | Platform-independent |

---

## 📂 Project Structure

ecommerce-database

    ├── analytics_queries.sql

    ├── data_insertion.sql (DML)
  
    ├── triggers.sql

    ├── table_creation.sql (DDL)

    ├──er_diagram.svg

    ├── README.md # ← You are here

---

## 📌 Core Entities

| Entity | Description |
|--------|-------------|
| `product` | Book details |
| `author` | Author master data |
| `product_author` | Mapping (Many-to-Many) |
| `category` | Genre/category |
| `product_category` | Product-category mapping |
| `product_image` | URLs of product images |
| `customer` | Customer profile |
| `address` | Shipping address |
| `cart`, `cart_items` | Cart system |
| `orders`, `order_items` | Orders |
| `payment` | Payment details |
| `shipment` | Shipping tracking |

---

Next Enhancements


- Add support for wishlist, discounts & reviews


- Implement inventory reservation model


- Include soft deletes (deleted_at)


- Add index optimization


- Implement role-based security for admin

---

💡 Author
Developed by Naveen

🎯 Aspiring Data Scientist, passionate about database architecture & backend development

If you like this project:

⭐ Please give it a Star on GitHub

🐛 Feel free to open issues / pull requests

---

📞 Contact & Support
📧 Email: naveenshijo@gmail.com

🔗 LinkedIn: www.linkedin.com/in/naveen-k-shijo


---

Let me know if you want:
- A `.sql` test case file to validate triggers 💡  
- Optimization suggestions for production  
- Adding Docker setup for easier deployment  

Just say the word!
