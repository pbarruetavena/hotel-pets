import animalRepository from '../repository/animalRepository.js';

const listAllAnimais = async () => {
    return await animalRepository.getAnimais();
};

const createAnimal = async (nome, especie, raca, tutorId) => {
    if(!nome || !especie) throw new Error("Insira todos os dados");
    return await animalRepository.addAnimais(nome, especie, raca, tutorId);
};

const updateAnimal = async (id, dadosAtualizados) => {
    return await animalRepository.updateAnimal(id, dadosAtualizados);
}

const deleteAnimal = async (id) => {
    return await animalRepository.deleteAnimal(id);
}

export default { listAllAnimais, createAnimal , updateAnimal, deleteAnimal };