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
        const { nome, especie, raca, tutorId } = request.body;
        const animal = await animalService.createAnimal(nome, especie, raca, tutorId);
        response.status(201).json(animal);
    } catch(error) {
        response.status(400).json({ error: error.message });
    }
};

const atualizarAnimal = async (request, response) => {
    try {
        const {id} = request.params;
        const dadosAtualizados = request.body;

        const res = await animalService.updateAnimal(id, dadosAtualizados);
        response.status(200).json(res);
    } catch(err) {
        response.status(400).json({error: err.message});
    }
}

const apagarAnimal = async (request, response) => {
    try {
        const {id} = request.params;
        const res = animalService.deleteAnimal(id);

        response.status(200).json(res);

    } catch(err) {
        response.status(400).json({error: err.message});
    }
}

export default {listarAnimais, criarAnimal, atualizarAnimal, apagarAnimal};