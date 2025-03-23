const { Animal } = require("../models");

const getAnimais = async () => {
    return await Animal.findAll();
};

const addAnimais = async (nome, especie) => {
    return await Animal.create({nome, especie});
};

module.exports = {getAnimais, addAnimais};