import Animal from '../models/Animal.js';

const getAnimais = async () => {
    return await Animal.findAll();
};

const addAnimais = async (nome, especie, raca, tutorId) => {
    return await Animal.create({nome, especie, raca, tutorId});
};

const updateAnimal = async (id, dadosAtualizados) => {
    const animal = await Animal.findByPk(id);
    if(!animal) {throw new Error();}

    await animal.update(dadosAtualizados);
    return animal;
}

const deleteAnimal = async (id) => {
    const animal = await Animal.findByPk(id);
    if(!animal) throw new Error("Animal não encontrado");
    try {
        await animal.destroy();
        return {message: "Animal removido com sucesso"};
    } catch(err) {
        if(err.name === "SequelizeForeignKeyConstraintError") {
            return {message: "SequelizeForeignKeyConstraintError"}
        }
    }
}

const find = async (id) => {
    return await Animal.findByPk(id);
}

export default {getAnimais, addAnimais, updateAnimal, deleteAnimal, find};