import estadiaRepository from "../repository/estadiaRepository.js";

const listAllEstadia = async ()=> {
    return await estadiaRepository.getEstadia();
}

const createEstadia = async (entrada, saida, animalId) => {
    if(!entrada || !saida || !animalId) throw new Error("Insita todos os dados");
    return await estadiaRepository.addEstadia(entrada, saida, animalId);
}

const updateEstadia = async (id, dadosAtualizados) => {
    return await estadiaRepository.updateEstadia(id, dadosAtualizados);
}

const deleteEstadia = async (id) => {
    return await estadiaRepository.deleteEstadia(id);
}

export default {listAllEstadia, createEstadia, updateEstadia, deleteEstadia};