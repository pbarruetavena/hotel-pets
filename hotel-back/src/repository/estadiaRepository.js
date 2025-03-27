import Estadia from "../models/Estadia.js";

const getEstadia = async () => {
    return await Estadia.findAll();
}

const addEstadia = async (entrada, saida, animalId) => {
    return await Estadia.create({entrada, saida, animalId});
}

const updateEstadia = async (id, dadosAtualizados) => {
    const estadia = await Estadia.findByPk(id);
    if(!estadia) {throw new Error();}
    await estadia.update(dadosAtualizados);
    return estadia;
}

const deleteEstadia = async (id) => {
    const estadia = await Estadia.findByPk(id);
    if(!estadia) {throw new Error("Não encontrado");}

    await estadia.destroy();
    return {message: "Estádia removida com sucesso"};
}

const find = async (id) => {
    return await Estadia.findByPk(id);
}

export default {getEstadia, addEstadia, updateEstadia, deleteEstadia, find};