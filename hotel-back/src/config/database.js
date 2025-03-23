const { Sequelize } = require('sequelize')

const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    provess.env.DB_PASSWORD,
    {
        host: process.env.DB_HOST,
        dialect: "postgres"
    }
);

export default sequelize;