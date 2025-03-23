import animalService from '../services/animalService.js';

const listarAnimais = async (request, response) => {
    try {
        const animais = await animalService.listAllAnimais();
        response.json(animais);
    } catch(error) {
        response.status(500).json({error: error.message});
    }
};

const criarAnimal = async(request, response) => {
    try {
        const { nome, especie } = request.body;
        const animal = await animalService.createAnimal(nome, especie);
        response.status(201).json(animal);
    } catch(error) {
        response.status(400).json({ error: error.message });
    }
};

export default {listarAnimais, criarAnimal};