const { DataTypes } = requires("sequelize");
const sequelize = require("../config/database");

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

module.exports = Animal;