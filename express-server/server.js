const express = require('express');
const app = express();
const PORT = process.env.PORT || 3010;

// Middleware
app.use(express.json());

// Simple route
app.get('/', (req, res) => {
  res.send('Hello from Express Server!');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

