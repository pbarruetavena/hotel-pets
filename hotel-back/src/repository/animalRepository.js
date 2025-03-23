import Animal from '../models/Animal.js';

const getAnimais = async () => {
    return await Animal.findAll();
};

const addAnimais = async (nome, especie) => {
    return await Animal.create({nome, especie});
};

export default {getAnimais, addAnimais};