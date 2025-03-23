const sequelize = require('../config/database');
const Animal = require('./Animal');

const sync = async () => {
    try {
        await sequelize.sync({alter: true});
    } catch(error) {
        console.log(error.message);
    }
};

module.exports = {Animal, sync};