import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const Animal = sequelize.define("Animal", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    nome: {
        type: DataTypes.STRING,
    },
    especie: {
        type: DataTypes.STRING,
    }
}, {
    tableName: "animal",
});

export default Animal;