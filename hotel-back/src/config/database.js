import { Sequelize } from "sequelize";

const sequelize = new Sequelize(
    'hoteldb',
    'postgres',
    'postgres',
    {
        host: 'localhost',
        dialect: "postgres"
    }
);

export default sequelize;