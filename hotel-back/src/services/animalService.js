const animalRepository = require("../repository/animalRepository");

const listAllAnimais = async () => {
    return await animalRepository.getAnimais();
};

const createAnimal = async (nome, especie) => {
    if(!nome || !especie) throw new Error("Insira todos os dados");
    return await animalRepository.addAnimais(nome, especie);
};

module.exports = { listAllAnimais, createAnimal }