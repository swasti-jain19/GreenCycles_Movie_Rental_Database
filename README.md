# GreenCycles_Movie_Rental_Database 🎥🎬

Welcome to the GreenCycles movie rental database project! 🍿 This repository delves into the world of GreenCycles, a thriving online movie rental shop, using the power of SQL.

* **SQL Scripts:** A collection of SQL queries categorized into:
    * **Data Exploration & Validation** 🔍🔍
    * **Business Insights** 📈📊
    * **Operational Support** 🛠️⚙️
    * **Decision-Making Support** 💡📊
    * **Additional Views** (e.g., `sales_by_film_category`, `sales_by_store`) 📊

**Database Overview:**

**Tables:**

* **Customers:** 👤 Stores information about customers, including their names, addresses, contact details, and rental history.
* **Movies:** 🎞️ Contains details about movies, such as title, description, release year, genre, and rental duration.
* **Inventory:** 📦 Tracks the availability of each movie across different stores.
* **Rentals:** 📝 Records rental transactions, including the customer, movie, rental date, and return date.
* **Payments:** 💰 Stores payment information for completed rentals.
* **Staff:** 🧑‍💼 Information about store employees.
* **Stores:** 🏪 Information about the different store locations.
* **Categories:** 🎞️ Classifies movies into different genres.
* **Actors:** 🧑‍🎤 Stores information about actors who appear in movies.
* **Language:** 💬 Stores information about the languages in which movies are available.
* **Film_Category:** 🎞️ Links movies to their corresponding categories.
* **Film_Actor:** 🧑‍🎤 Links movies to the actors who appear in them.
* **Address:** 🏠 Stores addresses for customers, stores, and staff.
* **City:** 🏙️ Stores information about cities.
* **Country:** 🌎 Stores information about countries.

## Importing SQL Data into pgAdmin 📥

This guide outlines the steps to import data from an SQL file into a PostgreSQL database using pgAdmin.

**1. Open pgAdmin 🖥️**

* Launch pgAdmin on your system.

**2. Connect to your Server 🔗**

* In the left-hand pane, expand the "Servers" node.
* Click on the server you want to connect to.

**3. Select the Database 🗄️**

* Expand the "Databases" node under your server.
* Select the specific database where you want to import the data.

**4. Open Query Tool 🛠️**

* Right-click on the selected database and choose "Query Tool" from the context menu.

**5. Load the SQL File 📂**

* In the Query Tool window, click on the "Open File" button (📁).
* Browse to and select the `.sql` file containing your insert statements.

**6. Execute the Query ▶️**

* Press F5 or click on the "Execute" button (▶️) to run the SQL commands in the file.

**7. Verify the Results ✅**

* Once the execution is complete, query the relevant tables in your database to ensure that the data has been inserted correctly.

**🎉 Congratulations! Your data is now imported into PostgreSQL.**

**A Note from the Developer**

I enjoyed working on this project and learning about the intricacies of database design and SQL. I hope this repository serves as a valuable resource for others interested in data analysis and database management. 

Feel free to reach out if you have any questions or suggestions.
