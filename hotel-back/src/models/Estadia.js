import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";
import Animal from "./Animal.js";

const Estadia = sequelize.define("Estadia", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    entrada: {
        type: DataTypes.DATEONLY,
        allowNull: false,
    },
    saida: {
        type: DataTypes.DATEONLY,
        allowNull: true,
    },
    animalId: {
        type: DataTypes.INTEGER,
        references: {
            model: Animal,
            key: "id",
        },
        allowNull: false,
    }
}, {
    tableName: "estadia",
});

Estadia.belongsTo(Estadia, {foreignKey: "animalId", as: "animal"});
Animal.hasMany(Estadia, {foreignKey: "animalId", as: "estadia"});

export default Estadia;