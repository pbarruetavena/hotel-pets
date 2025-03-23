import sequelize from '../config/database.js';
import Animal from "./Animal.js";

const syncd = async () => {
    try {
        console.log(sequelize);
        await sequelize.sync({alter: true});
        console.log("Tabelas sincronizadas!");
    } catch(error) {
        console.log(error.message);
    }
};

export default syncd;