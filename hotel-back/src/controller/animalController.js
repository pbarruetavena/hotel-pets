const animalService = require("../services/animalService");

const listAllAnimais = async (request, response) => {
    try {
        const animais = await animalService.listAllAnimais();
        response.json(animais);
    } catch(error) {
        response.status(500).json({error: error.message});
    }
};

const createAnimal = async(request, response) => {
    try {
        const { nome, especie } = request.body;
        const animal = await animalService.createAnimal(nome, especie);
        response.status(201).json(animal);
    } catch(error) {
        response.status(400).json({ error: error.message });
    }
};

module.exports = {listAllAnimais, createAnimal};