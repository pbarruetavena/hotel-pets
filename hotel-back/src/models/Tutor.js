import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const Tutor = sequelize.define("Tutor", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    nome: {
        type: DataTypes.STRING,
    },
    email: {
        type: DataTypes.STRING,
    }
}, {
    tableName: "tutor",
});

export default Tutor;