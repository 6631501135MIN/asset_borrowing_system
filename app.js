// file: server/app.js
require('dotenv').config();
const express = require('express');
const argon2 = require('@node-rs/argon2');
const con = require('./db');

const app = express();
app.use(express.json());

//========================== Students ======================================

// Get all available assets
app.get("/api/student/assets", (req, res) => {
  const sql = `
    SELECT a.asset_id, a.asset_code, a.asset_name, a.status,
           c.name AS category_name, c.image AS category_image
    FROM asset a
    JOIN category c ON a.category_id = c.category_id
    WHERE a.status = 'available' AND c.is_active = 1
    ORDER BY c.name, a.asset_name
  `;
  con.query(sql, (err, result) => {
    if (err) return res.status(500).send("Database server error");
    res.json(result);
  });
});

// Get available assets by category
app.get("/api/student/assets/category/:categoryId", (req, res) => {
  const categoryId = req.params.categoryId;
  const sql = `
    SELECT a.asset_id, a.asset_code, a.asset_name, a.status,
           c.name AS category_name, c.image AS category_image
    FROM asset a
    JOIN category c ON a.category_id = c.category_id
    WHERE a.category_id = ? AND c.is_active = 1 AND a.status = 'available'
    ORDER BY a.asset_name
  `;
  con.query(sql, [categoryId], (err, result) => {
    if (err) return res.status(500).send("Database server error");
    res.json(result);
  });
});

// Get all active categories
app.get("/api/student/categories", (req, res) => {
  const sql = `
    SELECT category_id, name, image
    FROM category
    WHERE is_active = 1
    ORDER BY name
  `;
  con.query(sql, (err, result) => {
    if (err) return res.status(500).send("Database server error");
    res.json(result);
  });
});

// Request to borrow an asset
app.post("/api/student/borrow", (req, res) => {
  const { borrower_id, asset_id, borrow_date, return_date } = req.body;

  // Basic validation (why: reject obviously bad data early)
  if (!borrower_id || !asset_id || !borrow_date) {
    return res.status(400).send("borrower_id, asset_id, borrow_date are required");
  }

  const borrowDate = new Date(borrow_date);
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  if (Number.isNaN(borrowDate.getTime())) {
    return res.status(400).send("Invalid borrow_date");
  }
  if (borrowDate < today) {
    return res.status(400).send("Borrow date must be today or after");
  }

  if (return_date) {
    const rd = new Date(return_date);
    if (Number.isNaN(rd.getTime())) {
      return res.status(400).send("Invalid return_date");
    }
    if (rd <= borrowDate) {
      return res.status(400).send("Return date must be after borrow date");
    }
  }

  // Check if asset is available
  const checkAssetSql = "SELECT status FROM asset WHERE asset_id = ?";
  con.query(checkAssetSql, [asset_id], (err, assetResult) => {
    if (err) return res.status(500).send("Database server error");

    if (assetResult.length === 0) {
      return res.status(404).send("Asset not found");
    }
    if (assetResult[0].status !== 'available') {
      return res.status(400).send("Asset is not available");
    }

    // Insert borrowing request (returned_at is NULL)
    const insertSql = `
      INSERT INTO borrowing(borrower_id, asset_id, status, borrow_date, return_date)
      VALUES (?, ?, 'pending', ?, ?)
    `;
    con.query(
      insertSql,
      [borrower_id, asset_id, borrow_date, return_date || null],
      (err2, result) => {
        if (err2) {
          if (err2.code === 'ER_DUP_ENTRY') {
            // why: unique_active_key / active_asset_key may block duplicates
            return res.status(400).send("You already have a pending or approved request for this date, or asset is already requested");
          }
          return res.status(500).send("Database server error");
        }

        if (result.affectedRows !== 1) {
          return res.status(500).send("Database server error");
        }

        // Update asset status to pending
        const updateAssetSql = "UPDATE asset SET status = 'pending' WHERE asset_id = ?";
        con.query(updateAssetSql, [asset_id], (err3) => {
          if (err3) return res.status(500).send("Database server error");
          res.json({ message: 'Borrow request submitted', borrowing_id: result.insertId });
        });
      }
    );
  });
});

// Get student's borrowing history
app.get("/api/student/history/:uid", (req, res) => {
  const uid = req.params.uid;
  const sql = `
    SELECT b.borrowing_id, b.status, b.borrow_date, b.return_date, b.returned_at,
           a.asset_id, a.asset_code, a.asset_name,
           c.name AS category_name,
           u.first_name AS approver_first_name, u.last_name AS approver_last_name
    FROM borrowing b
    JOIN asset a ON b.asset_id = a.asset_id
    JOIN category c ON a.category_id = c.category_id
    LEFT JOIN users u ON b.approver_id = u.uid
    WHERE b.borrower_id = ?
    ORDER BY b.borrow_date DESC, b.borrowing_id DESC
  `;
  con.query(sql, [uid], (err, result) => {
    if (err) return res.status(500).send("Database server error");
    res.json(result);
  });
});

// Get student's pending/approved requests
app.get("/api/student/requests/:uid", (req, res) => {
  const uid = req.params.uid;
  const sql = `
    SELECT b.borrowing_id, b.status, b.borrow_date, b.return_date,
           a.asset_id, a.asset_code, a.asset_name,
           c.name AS category_name
    FROM borrowing b
    JOIN asset a ON b.asset_id = a.asset_id
    JOIN category c ON a.category_id = c.category_id
    WHERE b.borrower_id = ? AND b.status IN ('pending', 'approved')
    ORDER BY b.borrow_date DESC
  `;
  con.query(sql, [uid], (err, result) => {
    if (err) return res.status(500).send("Database server error");
    res.json(result);
  });
});

// Cancel a pending request
app.put("/api/student/cancel/:borrowingId", (req, res) => {
  const borrowingId = req.params.borrowingId;
  const { borrower_id } = req.body;

  const checkSql = `
    SELECT b.status, b.asset_id, b.borrower_id
    FROM borrowing b
    WHERE b.borrowing_id = ?
  `;
  con.query(checkSql, [borrowingId], (err, result) => {
    if (err) return res.status(500).send("Database server error");

    if (result.length === 0) return res.status(404).send("Request not found");
    if (result[0].borrower_id !== borrower_id) return res.status(403).send("Not authorized");
    if (result[0].status !== 'pending') return res.status(400).send("Only pending requests can be cancelled");

    const assetId = result[0].asset_id;

    // Cancel the borrowing
    const updateSql = "UPDATE borrowing SET status = 'cancelled' WHERE borrowing_id = ?";
    con.query(updateSql, [borrowingId], (err2, upd) => {
      if (err2) return res.status(500).send("Database server error");
      if (upd.affectedRows !== 1) return res.status(500).send("Database server error");

      // Only set asset available if no other active rows exist for this asset
      const setAssetSql = `
        UPDATE asset a
        LEFT JOIN (
          SELECT 1 AS has_active
          FROM borrowing
          WHERE asset_id = ? AND status IN ('pending','approved','borrowed')
          LIMIT 1
        ) x ON 1=1
        SET a.status = CASE WHEN x.has_active IS NULL THEN 'available' ELSE a.status END
        WHERE a.asset_id = ?
      `;
      con.query(setAssetSql, [assetId, assetId], (err3) => {
        if (err3) return res.status(500).send("Database server error");
        res.send('Request cancelled');
      });
    });
  });
});

//========================== Common APIs =================================

// password generator
app.get('/api/password/:raw', (req, res) => {
  const raw = req.params.raw;
  const hash = argon2.hashSync(raw);
  res.send(hash);
});

// login
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  const sql = "SELECT uid, password, role, first_name, last_name, email FROM users WHERE username = ?";
  con.query(sql, [username], (err, results) => {
    if (err) return res.status(500).send("Database server error");
    if (results.length !== 1) return res.status(401).send("Wrong username");

    const same = argon2.verifySync(results[0].password, password);
    if (!same) return res.status(401).send("Wrong password");

    res.json({
      uid: results[0].uid,
      username,
      role: results[0].role,
      first_name: results[0].first_name,
      last_name: results[0].last_name,
      email: results[0].email
    });
  });
});

// register (student)
app.post('/api/register', (req, res) => {
  const { email, password, first_name, last_name, ph_num, username } = req.body;
  if (!email || !password || !first_name || !username) {
    return res.status(400).send("email, password, first_name, username are required");
  }

  const hashedPassword = argon2.hashSync(password);
  const sql = `
    INSERT INTO users(email, password, first_name, last_name, ph_num, username, profile_img, role)
    VALUES (?, ?, ?, ?, ?, ?, 'default.png', 'student')
  `;
  con.query(sql, [email, hashedPassword, first_name, last_name || null, ph_num || null, username], (err, result) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') return res.status(400).send("Username or email already exists");
      return res.status(500).send("Database server error");
    }
    if (result.affectedRows !== 1) return res.status(500).send("Database server error");
    res.json({ message: 'Registration successful', uid: result.insertId });
  });
});

//=================== Starting server =======================
const HOST = process.env.HOST || 'localhost';
const PORT = process.env.PORT || 3000;

app.listen(PORT, HOST, () => {
  console.log(`\n🚀 Server is running on http://${HOST}:${PORT}`);
  console.log(`📡 API Base URL: http://${HOST}:${PORT}/api`);
  console.log(`📊 Test in Thunder Client: http://${HOST}:${PORT}/api/register\n`);
});
