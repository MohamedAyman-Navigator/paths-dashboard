const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const connectionString = 'postgresql://postgres:MUgkEUfaUYXzGWXToHLjYaqquZCUEWVC@hopper.proxy.rlwy.net:19239/railway';

async function setupDatabase() {
    const client = new Client({
        connectionString,
        ssl: {
            rejectUnauthorized: false
        }
    });

    try {
        console.log('🔗 Connecting to Railway PostgreSQL...');
        await client.connect();
        console.log('✓ Connected!\n');

        // Read schema file (skip the first 9 lines with DROP/CREATE DATABASE and \c commands)
        console.log('📄 Reading schema.sql...');
        const schemaPath = path.join(__dirname, 'database', 'schema.sql');
        let schemaSQL = fs.readFileSync(schemaPath, 'utf8');

        // Remove problematic lines
        const lines = schemaSQL.split('\n');
        const filteredLines = lines.filter((line, index) => {
            // Skip lines 1-9 (DROP DATABASE, CREATE DATABASE, \c commands)
            return index >= 9 && !line.trim().startsWith('\\c');
        });
        schemaSQL = filteredLines.join('\n');

        console.log('🏗️  Creating database schema...');
        await client.query(schemaSQL);
        console.log('✓ Schema created successfully!\n');

        // Read and execute seed data
        console.log('📄 Reading seed.sql...');
        const seedPath = path.join(__dirname, 'database', 'seed.sql');
        const seedSQL = fs.readFileSync(seedPath, 'utf8');

        console.log('🌱 Loading seed data...');
        await client.query(seedSQL);
        console.log('✓ Seed data loaded successfully!\n');

        console.log('✅ Database setup complete!\n');
        console.log('📝 Default admin account:');
        console.log('   Email: admin@example.com');
        console.log('   Password: admin123');
        console.log('\n⚠️  Remember to change the admin password after deployment!\n');

    } catch (error) {
        console.error('❌ Error setting up database:', error.message);
        process.exit(1);
    } finally {
        await client.end();
    }
}

setupDatabase();
