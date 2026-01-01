// Vercel serverless function handler
// This wraps our Express app for Vercel's serverless environment

const path = require('path');

// Import the compiled Express app
const app = require('../dist/server').default || require('../dist/server');

// Export handler for Vercel
module.exports = app;
