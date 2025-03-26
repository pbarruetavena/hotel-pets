import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";
import Tutor from "./Tutor.js";

const Animal = sequelize.define("Animal", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    nome: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    especie: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    raca : {
        type: DataTypes.STRING,
        allowNull: false,
    },
    tutorId: {
        type: DataTypes.INTEGER,
        references: {
            model: Tutor,
            key: "id",
        },
        allowNull: false
    }
}, {
    tableName: "animal",
});

Animal.belongsTo(Tutor, {foreignKey: "tutorId", as: "tutor"});
Tutor.hasMany(Animal, {foreignKey: "tutorId", as: "animal"});

export default Animal;